import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pretty_charts/src/plots/dependency_wheel/dependency_wheel_data.dart';
import 'package:pretty_charts/src/shared/chart_viewer.dart';
import 'package:pretty_charts/src/shared/color_maps/color_map.dart';
import 'package:pretty_charts/src/shared/color_maps/qualitative_color_map.dart';
import 'package:pretty_charts/src/shared/extensions/offset_extension.dart';

class LinkData {
  final Color color;
  final Path path;
  final String from;
  final String to;

  LinkData({
    required this.color,
    required this.path,
    required this.from,
    required this.to,
  });
}

class SectionData {
  final Color color;
  final Path path;
  final String name;

  SectionData({required this.name, required this.color, required this.path});
}

class TextData {
  final double angle;
  final String text;

  TextData({required this.angle, required this.text});
}

class DependencyWheelChart extends StatefulWidget {
  const DependencyWheelChart({
    super.key,
    required this.data,
    this.colorMap,
    this.animationDuration = Durations.extralong1,
    this.animationCurve = Curves.easeInOut,
    this.sectionSpacing = 2 * math.pi / 360 * 2,
  });

  final List<DependencyWheelChartData> data;
  final Duration animationDuration;
  final Curve animationCurve;
  final ColorMap? colorMap;

  /// padding between circular sections (in radian)
  final double sectionSpacing;

  @override
  State<DependencyWheelChart> createState() => _DependencyWheelChartState();
}

class _DependencyWheelChartState extends State<DependencyWheelChart> {
  double _scaleFactor = 1.0;
  Offset _offset = Offset.zero;
  Offset? _tappedPosition;

  @override
  Widget build(BuildContext context) {
    return ChartViewer(
      initialScale: 1.0,
      onScale: (double scaleFactor, Offset offset) {
        setState(() {
          _scaleFactor = scaleFactor;
          _offset = offset;
        });
      },
      onHover: (details) {
        setState(() {
          _tappedPosition = details.localPosition;
        });
      },
      child: LayoutBuilder(
        builder: (context, constraints) => ClipRect(
          child: IdkYet(
            scaleFactor: _scaleFactor,
            offset: _offset,
            data: widget.data,
            colorMap: widget.colorMap ?? pastel17,
            canvasSize: Size(constraints.maxWidth, constraints.maxHeight),
            animationCurve: widget.animationCurve,
            animationDuration: widget.animationDuration,
            sectionSpacing: widget.sectionSpacing,
            tappedPosition: _tappedPosition,
          ),
        ),
      ),
    );
  }
}

class IdkYet extends StatefulWidget {
  const IdkYet({
    super.key,
    required this.scaleFactor,
    required this.offset,
    required this.data,
    required this.colorMap,
    required this.canvasSize,
    required this.animationCurve,
    required this.animationDuration,
    required this.sectionSpacing,
    required this.tappedPosition,
  });

  final double scaleFactor;
  final Offset offset;
  final List<DependencyWheelChartData> data;
  final ColorMap colorMap;
  final Size canvasSize;
  final Curve animationCurve;
  final Duration animationDuration;
  final double sectionSpacing;
  final Offset? tappedPosition;

  @override
  State<IdkYet> createState() => _IdkYetState();
}

class _IdkYetState extends State<IdkYet> with SingleTickerProviderStateMixin {
  List<LinkData> _links = [];
  List<SectionData> _sections = [];
  List<TextData> _texts = [];

  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  SectionData? _selectedSection;
  LinkData? _selectedLink;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..addListener(() {
        _compute();
      });

    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.animationCurve,
      ),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant IdkYet oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.canvasSize != widget.canvasSize) {
      _compute();
    }

    if (oldWidget.tappedPosition != widget.tappedPosition) {
      SectionData? selectedSection;
      LinkData? selectedLink;

      if (widget.tappedPosition != null) {
        for (var section in _sections) {
          if (section.path.contains(widget.tappedPosition!)) {
            selectedSection = section;
            break;
          }
        }

        if (selectedSection == null) {
          for (var link in _links) {
            if (link.path.contains(widget.tappedPosition!)) {
              selectedLink = link;
              break;
            }
          }
        }

        setState(() {
          _selectedLink = selectedLink;
          _selectedSection = selectedSection;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _compute() async {
    widget.colorMap.reset();
    const internalPadding = 50.0;
    final totalPerDestination = <String, double>{};
    final size = widget.canvasSize;
    final links = <LinkData>[];
    final sections = <SectionData>[];
    final texts = <TextData>[];

    // total of the quantity from the data
    // ex: total of inhabitants/export/sells...
    double total = 0.0;
    final center = Offset(size.width / 2, size.height / 2);

    final circleRadius = size.shortestSide / 2 - internalPadding;
    final insideCircleRadius = circleRadius - 12 / 2;

    // we calculate the total value for each section
    for (var element in widget.data) {
      totalPerDestination.update(
        element.from,
        (value) => value + element.value,
        ifAbsent: () => element.value,
      );
      totalPerDestination.update(
        element.to,
        (value) => value + element.value,
        ifAbsent: () => element.value,
      );
      total += element.value * 2;
    }

    // give a color for each section
    final Map<String, Color> colors = Map.fromEntries(
      totalPerDestination.keys.map(
        (e) => MapEntry(e, widget.colorMap.getColor(0.0)),
      ),
    );

    // store the start angle of a section (in radian)
    final startSectionDestination = Map<String, double>.fromIterable(
      totalPerDestination.keys,
      value: (element) => 0.0,
    );
    // store the end angle of a section (in radian)
    final endSectionDestination =
        Map<String, double>.from(startSectionDestination);

    // if we have only one data, we don't have padding because it's a full circle (it doesn't make sense tho)
    final totalPaddingAngle =
        (widget.data.length <= 1) ? 0 : (widget.sectionSpacing);

    var angle = -math.pi / 2;

    // we need this to draw the arcs
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.shortestSide - internalPadding * 2,
      height: size.shortestSide - internalPadding * 2,
    );

    final insideRect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: insideCircleRadius,
    );

    for (final a in totalPerDestination.entries) {
      final ratio = a.value;
      final sectionAngle = math.pi * 2 * ratio / total - totalPaddingAngle;

      startSectionDestination[a.key] = angle;
      endSectionDestination[a.key] = sectionAngle + angle;

      sections.add(
        SectionData(
          name: a.key,
          color: colors[a.key]!,
          path: Path()
            ..addArc(rect, angle, sectionAngle * _progressAnimation.value),
        ),
      );
      texts.add(TextData(angle: angle + sectionAngle / 2, text: a.key));

      angle += sectionAngle + totalPaddingAngle;
    }

    // we need to have to mutate the values of startSectionDestination
    final progress = Map.from(startSectionDestination);

    for (var d in widget.data) {
      final from = d.from;
      final to = d.to;
      final fromValue = totalPerDestination[from]!;
      final toValue = totalPerDestination[to]!;

      final startAngleSource = progress[from]!;
      final startAngleDestination = progress[to]!;
      final endAngleSource = startAngleSource +
          d.value /
              fromValue *
              _progressAnimation.value *
              (endSectionDestination[from]! - startSectionDestination[from]!);
      final endAngleDestination = startAngleDestination +
          d.value /
              toValue *
              _progressAnimation.value *
              (endSectionDestination[to]! - startSectionDestination[to]!);

      final path = Path();

      final sourcePointStart =
          center.translateIntoCartesian(insideCircleRadius, startAngleSource);
      final destinationPointStart = center.translateIntoCartesian(
          insideCircleRadius, startAngleDestination);

      // we moove at the begining of the first section
      path.moveTo(sourcePointStart.dx, sourcePointStart.dy);
      // we draw an arc to the end of the section according to the value of the link (maybe 15%)
      path.arcTo(insideRect, startAngleSource,
          endAngleSource - startAngleSource, true);
      // draw a curve between the end of the source section to the start of the destination section
      path.cubicTo(
        center.dx,
        center.dy,
        center.dx,
        center.dy,
        destinationPointStart.dx,
        destinationPointStart.dy,
      );
      // draw an arc between the begining and the end of the section accoding to the value of the link
      path.arcTo(insideRect, startAngleDestination,
          endAngleDestination - startAngleDestination, true);

      // draw a curve to the start of the first section
      path.cubicTo(
        center.dx,
        center.dy,
        center.dx,
        center.dy,
        sourcePointStart.dx,
        sourcePointStart.dy,
      );

      // we mouve the cursor and close the path
      path.moveTo(sourcePointStart.dx, sourcePointStart.dy);
      path.close();

      links.add(
        LinkData(
          color: colors[from]!.withOpacity(0.3),
          path: path,
          from: from,
          to: to,
        ),
      );

      // update because we need to know wher to start the next link
      progress.update(
          from, (value) => value + (endAngleSource - startAngleSource));
      progress.update(
          to, (value) => value + (endAngleDestination - startAngleDestination));
    }

    setState(() {
      _links = links;
      _sections = sections;
      _texts = texts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.canvasSize,
      painter: DependencyWheelChartPainter(
        animationProgress: _progressAnimation.value,
        scaleFactor: widget.scaleFactor,
        offset: widget.offset,
        links: _links,
        sections: _sections,
        texts: _texts,
        selectedSection: _selectedSection,
        selectedLink: _selectedLink,
      ),
    );
  }
}

class DependencyWheelChartPainter extends CustomPainter {
  DependencyWheelChartPainter({
    super.repaint,
    required this.animationProgress,
    required this.scaleFactor,
    required this.offset,
    required this.links,
    required this.sections,
    required this.texts,
    required this.selectedSection,
    required this.selectedLink,
  });

  final double scaleFactor;
  final Offset offset;

  final double animationProgress;

  final List<LinkData> links;
  final List<SectionData> sections;
  final List<TextData> texts;

  final SectionData? selectedSection;
  final LinkData? selectedLink;

  @override
  void paint(Canvas canvas, Size size) {
    final sectionPainter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    final center = Offset(size.width / 2, size.height / 2);
    final circleRadius = size.shortestSide / 2 - 50.0;

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (var section in sections) {
      if (selectedSection != null && section != selectedSection) {
        sectionPainter.color =
            HSLColor.fromColor(section.color).withLightness(0.05).toColor();
      } else {
        sectionPainter.color = section.color;
      }

      canvas.drawPath(section.path, sectionPainter);
    }

    for (final a in texts) {
      textPainter.text = TextSpan(
        text: a.text,
        style: TextStyle(
          color: Colors.grey.shade800,
        ),
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        center.translateIntoCartesian(circleRadius + 24, a.angle) -
            Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }

    final linkPainter = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    for (var d in links) {
      linkPainter.color = d.color;
      if (selectedSection != null &&
          (d.from != selectedSection!.name && d.to != selectedSection!.name)) {
        linkPainter.color =
            HSLColor.fromColor(d.color).withLightness(0.05).toColor();
      }

      if (selectedLink != null) {
        if (d != selectedLink) {
          linkPainter.color =
              HSLColor.fromColor(d.color).withLightness(0.05).toColor();
        }
      }

      canvas.drawPath(d.path, linkPainter);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
