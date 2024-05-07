import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pretty_charts/src/plots/dependency_wheel/dependency_wheel_data.dart';
import 'package:pretty_charts/src/shared/chart_viewer.dart';
import 'package:pretty_charts/src/shared/color_maps/color_map.dart';
import 'package:pretty_charts/src/shared/color_maps/qualitative_color_map.dart';

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

class _DependencyWheelChartState extends State<DependencyWheelChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  double _scaleFactor = 1.0;
  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..addListener(() {
        setState(() {});
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      child: ClipRect(
        child: CustomPaint(
          painter: DependencyWheelChartPainter(
              animationProgress: _progressAnimation.value,
              scaleFactor: _scaleFactor,
              offset: _offset,
              data: widget.data,
              colorMap: widget.colorMap ?? pastel17,
              sectionSpacing: widget.sectionSpacing),
        ),
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
    required this.data,
    required this.colorMap,
    required this.sectionSpacing,
  });

  final double scaleFactor;
  final Offset offset;
  final List<DependencyWheelChartData> data;
  final ColorMap colorMap;
  final double sectionSpacing;

  final double animationProgress;

  @override
  void paint(Canvas canvas, Size size) {
    colorMap.reset();
    const internalPadding = 50.0;
    final sectionPainter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    final totalPerDestination = <String, double>{};

    // total of the quantity from the data
    // ex: total of inhabitants/export/sells...
    double total = 0.0;
    final center = Offset(size.width / 2, size.height / 2);

    final circleRadius = size.shortestSide / 2 - internalPadding;

    // we calculate the total value for each section
    for (var element in data) {
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
        (e) => MapEntry(e, colorMap.getColor(0.0)),
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
    final totalPaddingAngle = (data.length <= 1) ? 0 : (sectionSpacing);

    var angle = -math.pi / 2;

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // we need this to draw the arcs
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.shortestSide - internalPadding * 2,
      height: size.shortestSide - internalPadding * 2,
    );

    for (final a in totalPerDestination.entries) {
      textPainter.text = TextSpan(
        text: a.key,
        style: TextStyle(
          color: Colors.grey.shade800,
        ),
      );

      sectionPainter.color = colors[a.key]!;

      final ratio = a.value;
      final sectionAngle = math.pi * 2 * ratio / total - totalPaddingAngle;

      startSectionDestination[a.key] = angle;
      endSectionDestination[a.key] = sectionAngle + angle;

      canvas.drawArc(
        rect,
        angle,
        sectionAngle,
        false,
        sectionPainter,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        translateIntoCartesian(
          center,
          circleRadius * 1.1,
          angle + sectionAngle / 2,
        ),
      );

      angle += sectionAngle + totalPaddingAngle;
    }

    final linkPainter = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    // we need to have to mutate the values of startSectionDestination
    final progress = Map.from(startSectionDestination);

    for (var d in data) {
      final from = d.from;
      final to = d.to;
      final fromValue = totalPerDestination[from]!;
      final toValue = totalPerDestination[to]!;

      linkPainter.color = colors[from]!.withOpacity(0.3);

      final startAngleSource = progress[from]!;
      final startAngleDestination = progress[to]!;
      final endAngleSource = startAngleSource +
          d.value /
              fromValue *
              (endSectionDestination[from]! - startSectionDestination[from]!);
      final endAngleDestination = startAngleDestination +
          d.value /
              toValue *
              (endSectionDestination[to]! - startSectionDestination[to]!);

      final path = Path();

      final sourcePointStart =
          translateIntoCartesian(center, circleRadius, startAngleSource);
      final destinationPointStart =
          translateIntoCartesian(center, circleRadius, startAngleDestination);

      // we moove at the begining of the first section
      path.moveTo(sourcePointStart.dx, sourcePointStart.dy);
      // we draw an arc to the end of the section according to the value of the link (maybe 15%)
      path.arcTo(
          rect, startAngleSource, endAngleSource - startAngleSource, true);
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
      path.arcTo(rect, startAngleDestination,
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

      canvas.drawPath(path, linkPainter);

      // update because we need to know wher to start the next link
      progress.update(
          from, (value) => value + (endAngleSource - startAngleSource));
      progress.update(
          to, (value) => value + (endAngleDestination - startAngleDestination));
    }
  }

  Offset translateIntoCartesian(Offset origin, double radius, double angle) {
    return Offset(
      origin.dx + (math.cos(angle) * radius),
      origin.dy + (math.sin(angle) * radius),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
