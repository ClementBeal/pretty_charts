import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_charts/pretty_charts.dart';
import 'package:pretty_charts/src/plots/treemap_chart/scarify_algo.dart';
import 'package:pretty_charts/src/shared/chart_viewer.dart';
import 'package:pretty_charts/src/shared/color_maps/color_map.dart';

class TreeMapChart extends StatefulWidget {
  const TreeMapChart({
    super.key,
    required this.data,
    this.colorMap,
    this.animationDuration = Durations.extralong1,
    this.animationCurve = Curves.easeInOut,
  });

  final List<TreeMapChartData> data;
  final Duration animationDuration;
  final Curve animationCurve;
  final ColorMap? colorMap;

  @override
  State<TreeMapChart> createState() => _TreeMapChartState();
}

class _TreeMapChartState extends State<TreeMapChart>
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return TreemapBuilder(
              scaleFactor: _scaleFactor,
              progressAnimation: _progressAnimation,
              offset: _offset,
              constraints: constraints,
              data: widget.data,
              colorMap: widget.colorMap,
            );
          },
        ),
      ),
    );
  }
}

class TreemapBuilder extends StatefulWidget {
  const TreemapBuilder({
    super.key,
    required this.scaleFactor,
    required this.progressAnimation,
    required this.offset,
    required this.constraints,
    required this.data,
    this.colorMap,
  });

  final double scaleFactor;
  final Animation<double> progressAnimation;
  final Offset offset;
  final BoxConstraints constraints;
  final List<TreeMapChartData> data;
  final ColorMap? colorMap;

  @override
  State<TreemapBuilder> createState() => _TreemapBuilderState();
}

class _TreemapBuilderState extends State<TreemapBuilder> {
  late List<TreeMapSection> _sections;

  @override
  void initState() {
    super.initState();

    load();
  }

  void load() {
    final rect = Rect.fromLTWH(
      0,
      0,
      widget.constraints.maxWidth,
      widget.constraints.maxHeight,
    );
    final normalizedValues = ScarifyTreeMap.normalizeValues(widget.data, rect);

    final sections = ScarifyTreeMap().scarify(
      normalizedValues,
      rect,
    );

    final c = widget.colorMap ?? pastel17;

    for (var i = 0; i < sections.length; i++) {
      final color = c.getColor(i.toDouble());
      sections[i].color = color;

      if (sections[i].data.children != null) {
        // the children have no color. We use the parent's color
        i += sections[i].data.children!.length;
      }
    }

    setState(() {
      _sections = sections;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TreeMapChartPainter(
        scaleFactor: widget.scaleFactor,
        animationProgress: widget.progressAnimation.value,
        offset: widget.offset,
        sections: _sections,
      ),
    );
  }
}

class TreeMapChartPainter extends CustomPainter {
  TreeMapChartPainter({
    super.repaint,
    required this.animationProgress,
    required this.scaleFactor,
    required this.offset,
    required this.sections,
  });

  final double scaleFactor;
  final Offset offset;
  final List<TreeMapSection> sections;

  /// progress value of the animation
  /// 0 is the start || 1 is the end
  /// interval of value : [0, 1]
  final double animationProgress;

  @override
  void paint(Canvas canvas, Size size) {
    final sectionPainter = Paint()..style = PaintingStyle.fill;
    final borderPainter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 22 * animationProgress,
    );

    final textBoxPadding = scaleFactor * 0.90;
    final scaleFactorWithAnimation = animationProgress * scaleFactor;

    for (final section in sections) {
      if (section.color != null) {
        sectionPainter.color = section.color!;

        canvas.drawRect(
          Rect.fromLTWH(
            section.rect.left * scaleFactor,
            section.rect.top * scaleFactor,
            section.rect.width * scaleFactorWithAnimation,
            section.rect.height * scaleFactorWithAnimation,
          ),
          sectionPainter,
        );
      } else {
        canvas.drawRect(
          Rect.fromLTWH(
            section.rect.left * scaleFactor,
            section.rect.top * scaleFactor,
            section.rect.width * scaleFactorWithAnimation,
            section.rect.height * scaleFactorWithAnimation,
          ),
          borderPainter,
        );
      }

      textPainter.text = TextSpan(
        text: section.data.name,
        style: textStyle,
      );

      textPainter.layout(maxWidth: section.rect.width);

      while (section.rect.height * textBoxPadding < textPainter.height ||
          section.rect.width * textBoxPadding < textPainter.width) {
        textPainter.text = TextSpan(
          text: section.data.name,
          style: textStyle.copyWith(
            fontSize: textPainter.text!.style!.fontSize! * 0.83,
          ),
        );
        textPainter.layout(maxWidth: section.rect.width);
      }

      if (section.data.children != null) {
        textPainter.paint(
          canvas,
          (section.rect.topLeft * scaleFactor).translate(10, 10),
        );
      } else {
        textPainter.paint(
          canvas,
          (section.rect.center * scaleFactor).translate(
            -textPainter.width / 2,
            -textPainter.height / 2,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
