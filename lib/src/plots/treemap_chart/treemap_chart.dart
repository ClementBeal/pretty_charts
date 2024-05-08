import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    this.onGenerateSelectedLabel,
    this.interactions = ChartInteraction.values,
  });

  final List<TreeMapChartData> data;
  final Duration animationDuration;
  final Curve animationCurve;
  final ColorMap? colorMap;
  final String Function(TreeMapChartData data)? onGenerateSelectedLabel;
  final List<ChartInteraction> interactions;

  @override
  State<TreeMapChart> createState() => _TreeMapChartState();
}

class _TreeMapChartState extends State<TreeMapChart> {
  double _scaleFactor = 1.0;
  Offset _offset = Offset.zero;
  Offset _tapScreenOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return ChartViewer(
      initialScale: 1.0,
      interactions: widget.interactions,
      onScale: (double scaleFactor, Offset offset) {
        setState(() {
          _scaleFactor = scaleFactor;
          _offset = offset;
        });
      },
      onTapUp: (details) {
        setState(() {
          _tapScreenOffset = (details.localPosition - _offset) / _scaleFactor;
        });
      },
      child: ClipRect(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return TreemapBuilder(
              scaleFactor: _scaleFactor,
              offset: _offset,
              tapScreen: _tapScreenOffset,
              constraints: constraints,
              data: widget.data,
              colorMap: widget.colorMap,
              animationCurve: widget.animationCurve,
              animationDuration: widget.animationDuration,
              onGenerateSelectedLabel: widget.onGenerateSelectedLabel,
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
    required this.offset,
    required this.constraints,
    required this.data,
    required this.tapScreen,
    required this.animationCurve,
    required this.animationDuration,
    required this.onGenerateSelectedLabel,
    this.colorMap,
  });

  final double scaleFactor;
  final Offset offset;
  final BoxConstraints constraints;
  final List<TreeMapChartData> data;
  final ColorMap? colorMap;
  final Offset tapScreen;
  final Curve animationCurve;
  final Duration animationDuration;
  final String Function(TreeMapChartData data)? onGenerateSelectedLabel;

  @override
  State<TreemapBuilder> createState() => _TreemapBuilderState();
}

class _TreemapBuilderState extends State<TreemapBuilder>
    with TickerProviderStateMixin {
  late List<TreeMapSection> _sections;
  TreeMapSection? _previousSelectedSection;
  TreeMapSection? _selectedSection;

  late AnimationController _controller;
  late AnimationController _selectedController;
  late Animation<double> _progressAnimation;
  late Animation<double> _selectedAnimation;

  @override
  void initState() {
    super.initState();

    load();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..addListener(() {
        setState(() {});
      });

    _selectedController = AnimationController(
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
    _selectedAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _selectedController,
        curve: widget.animationCurve,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _selectedController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TreemapBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tapScreen != widget.tapScreen) {
      final newSelectedSection = _sections.firstWhereOrNull((e) =>
          (e.data.children == null) && e.rect.contains(widget.tapScreen));

      if (newSelectedSection != null) {
        if (newSelectedSection == _selectedSection) {
          _previousSelectedSection = null;
          _selectedSection = null;
        } else {
          _previousSelectedSection = _selectedSection;
          _selectedSection = newSelectedSection;

          _selectedController.reset();
          _selectedController.forward();
        }
      }
    }

    if (oldWidget.constraints != widget.constraints) {
      load();
    }
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

    final c = (widget.colorMap ?? pastel17)..reset();

    for (var i = 0; i < sections.length; i++) {
      final color = c.getColor(i.toDouble());
      sections[i].color = color;

      if (sections[i].data.children != null) {
        for (var j = 1; j < sections[i].data.children!.length + 1; j++) {
          sections[i + j].color = color;
        }
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
      size: Size(widget.constraints.maxWidth, widget.constraints.maxHeight),
      painter: TreeMapChartPainter(
        scaleFactor: widget.scaleFactor,
        animationProgress: _progressAnimation.value,
        offset: widget.offset,
        sections: _sections,
        selectedSection: _selectedSection,
        previousSelectedSection: _previousSelectedSection,
        selectedProgress: _selectedAnimation.value,
        onGenerateSelectedLabel: widget.onGenerateSelectedLabel,
      ),
    );
  }
}

class TreeMapChartPainter extends CustomPainter {
  TreeMapChartPainter({
    super.repaint,
    required this.animationProgress,
    required this.selectedProgress,
    required this.scaleFactor,
    required this.offset,
    required this.sections,
    required this.selectedSection,
    required this.previousSelectedSection,
    required this.onGenerateSelectedLabel,
  });

  final double scaleFactor;
  final Offset offset;
  final List<TreeMapSection> sections;
  final TreeMapSection? selectedSection;
  final TreeMapSection? previousSelectedSection;
  final String Function(TreeMapChartData data)? onGenerateSelectedLabel;

  /// progress value of the animation
  /// 0 is the start || 1 is the end
  /// interval of value : [0, 1]
  final double animationProgress;
  final double selectedProgress;

  @override
  void paint(Canvas canvas, Size size) {
    final sectionPainter = Paint()..style = PaintingStyle.fill;
    final borderPainter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white;
    final selectedSectionBorderPainter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = Colors.grey.shade800;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      maxLines: 1,
    );
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 22,
    );

    final textBoxPadding = min(
        12.0, scaleFactor * (24 + selectedSectionBorderPainter.strokeWidth));
    final scaleFactorWithAnimation = animationProgress * scaleFactor;

    for (final section in sections) {
      final isSectionSelected = section == selectedSection;
      final isPreviousSectionSelected = section == previousSelectedSection;

      if (section.data.children == null) {
        if (isSectionSelected) {
          sectionPainter.color =
              section.color!.withOpacity(1 - 0.2 * selectedProgress);
        } else if (isPreviousSectionSelected) {
          sectionPainter.color =
              section.color!.withOpacity(0.8 + 0.2 * selectedProgress);
        } else {
          sectionPainter.color = section.color!;
        }

        canvas.drawRect(
          Rect.fromLTWH(
            offset.dx + section.rect.left * scaleFactor,
            offset.dy + section.rect.top * scaleFactor,
            section.rect.width * scaleFactorWithAnimation,
            section.rect.height * scaleFactorWithAnimation,
          ),
          sectionPainter,
        );
      }

      if (section.hasBorder) {
        canvas.drawRect(
          Rect.fromLTWH(
            offset.dx + section.rect.left * scaleFactor,
            offset.dy + section.rect.top * scaleFactor,
            section.rect.width * scaleFactorWithAnimation,
            section.rect.height * scaleFactorWithAnimation,
          ),
          borderPainter,
        );
      }

      if (isSectionSelected) {
        selectedSectionBorderPainter.strokeWidth = 4 * selectedProgress;
        canvas.drawRect(
          Rect.fromLTWH(
            offset.dx +
                section.rect.left * scaleFactor +
                selectedSectionBorderPainter.strokeWidth / 2,
            offset.dy +
                section.rect.top * scaleFactor +
                selectedSectionBorderPainter.strokeWidth / 2,
            section.rect.width * scaleFactor -
                selectedSectionBorderPainter.strokeWidth,
            section.rect.height * scaleFactor -
                selectedSectionBorderPainter.strokeWidth,
          ),
          selectedSectionBorderPainter,
        );
      } else if (isPreviousSectionSelected && selectedProgress < 1.0) {
        selectedSectionBorderPainter.strokeWidth = 4 * (1 - selectedProgress);

        canvas.drawRect(
          Rect.fromLTWH(
            offset.dx +
                section.rect.left * scaleFactor +
                selectedSectionBorderPainter.strokeWidth / 2,
            offset.dy +
                section.rect.top * scaleFactor +
                selectedSectionBorderPainter.strokeWidth / 2,
            section.rect.width * scaleFactor -
                selectedSectionBorderPainter.strokeWidth,
            section.rect.height * scaleFactor -
                selectedSectionBorderPainter.strokeWidth,
          ),
          selectedSectionBorderPainter,
        );
      }

      findBestFittingFontSize(section, textBoxPadding, textPainter, textStyle);

      if (section.data.children == null) {
        textPainter.paint(
          canvas,
          (offset + (section.rect.center) * scaleFactor).translate(
            -textPainter.width / 2,
            -textPainter.height / 2,
          ),
        );
      }
    }

    for (var section in sections) {
      if (section.data.children != null) {
        drawParentSectionTitle(canvas, textPainter, section, textStyle);
      }
    }

    if (selectedSection != null) {
      drawSectionInformation(
        canvas,
        selectedSection!,
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );
    }
  }

  void findBestFittingFontSize(
    TreeMapSection section,
    double padding,
    TextPainter textPainter,
    TextStyle textStyle,
  ) {
    textPainter.text = TextSpan(
      text: section.data.name,
      style: textStyle,
    );
    var fontSize = textStyle.fontSize!;

    textPainter.layout(maxWidth: section.rect.width);

    textIsBigger() =>
        section.rect.height * scaleFactor + padding < textPainter.height ||
        section.rect.width * scaleFactor + padding < textPainter.width;
    while (textIsBigger() || textPainter.didExceedMaxLines) {
      fontSize = fontSize / 2;
      textPainter.text = TextSpan(
        text: section.data.name,
        style: textStyle.copyWith(
          fontSize: fontSize,
        ),
      );
      textPainter.layout(maxWidth: section.rect.width);
    }
  }

  /// Draw the title of a section having children at the top left corner
  void drawParentSectionTitle(
    Canvas canvas,
    TextPainter textPainter,
    TreeMapSection section,
    TextStyle textStyle,
  ) {
    textPainter.text = TextSpan(
      text: section.data.name,
      style: textStyle,
    );

    textPainter.layout(maxWidth: section.rect.width);
    textPainter.paint(
      canvas,
      (offset + (section.rect.topLeft) * scaleFactor).translate(10, 10),
    );
  }

  void drawSectionInformation(
      Canvas canvas, TreeMapSection section, Rect canvasRect) {
    final backgroundPainter = Paint()
      ..color = Colors.black.withOpacity(
          0.67 * ((previousSelectedSection != null) ? 1 : selectedProgress));
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.text = TextSpan(
      text: onGenerateSelectedLabel?.call(section.data) ??
          section.data.value.toStringAsFixed(2),
      style: TextStyle(
        color: Colors.white.withOpacity(
            (previousSelectedSection != null) ? 1 : selectedProgress),
      ),
    );

    textPainter.layout();

    final previousSectionPosition =
        _getSelectedSectionPosition(previousSelectedSection);
    final currentSectionPosition = _getSelectedSectionPosition(section);

    // the text position is between the top and the center of the section
    // it's animated. We move from the previous section position to the new one
    final textCenter = (offset +
        (previousSectionPosition +
                (currentSectionPosition - previousSectionPosition) *
                    selectedProgress) *
            scaleFactor);

    // add custom margin to the width and height of the rect
    var a = Rect.fromCenter(
      center: textCenter,
      width: textPainter.width + 24,
      height: textPainter.height + 24,
    );

    if (canvasRect.top > a.top) {
      a = a.translate(0, -a.top);
    } else if (canvasRect.bottom < a.bottom) {
      a = a.translate(0, -(a.bottom - canvasRect.bottom));
    }
    if (canvasRect.right < a.right) {
      a = a.translate(-(a.right - canvasRect.right), 0);
    } else if (a.left < canvasRect.left) {
      a = a.translate(-a.left, 0);
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        a,
        const Radius.circular(4),
      ),
      backgroundPainter,
    );

    textPainter.paint(
      canvas,
      a.center - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  Offset _getSelectedSectionPosition(TreeMapSection? section) {
    if (section == null) {
      return Offset.zero;
    }
    return (section.rect.center +
        (section.rect.topCenter - section.rect.center) / 2);
  }

  @override
  bool shouldRepaint(covariant TreeMapChartPainter oldDelegate) {
    return oldDelegate.animationProgress != animationProgress ||
        oldDelegate.selectedProgress != selectedProgress ||
        oldDelegate.scaleFactor != scaleFactor ||
        oldDelegate.offset != offset ||
        !listEquals(oldDelegate.sections, sections) ||
        oldDelegate.selectedSection != selectedSection ||
        oldDelegate.previousSelectedSection != previousSelectedSection ||
        oldDelegate.onGenerateSelectedLabel != onGenerateSelectedLabel;
  }
}
