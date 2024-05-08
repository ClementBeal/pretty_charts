import 'package:flutter/widgets.dart';

enum ChartInteraction {
  scale,
  move;
}

class ChartViewer extends StatefulWidget {
  const ChartViewer({
    super.key,
    required this.child,
    required this.onScale,
    required this.initialScale,
    this.interactions = ChartInteraction.values,
    this.onTapUp,
  });

  final Widget child;
  final void Function(double scaleFactor, Offset offset) onScale;
  final void Function(TapUpDetails details)? onTapUp;
  final double initialScale;
  final List<ChartInteraction> interactions;

  @override
  State<ChartViewer> createState() => _ChartViewerState();
}

class _ChartViewerState extends State<ChartViewer> {
  double _scale = 1.0;
  double _tmpScale = 1.0;
  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();

    _scale = widget.initialScale;
    _tmpScale = widget.initialScale;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        _tmpScale = _scale;
      },
      onScaleUpdate: (details) {
        if (widget.interactions.contains(ChartInteraction.scale)) {
          _scale = _tmpScale * details.scale;
        }
        if (widget.interactions.contains(ChartInteraction.move)) {
          _offset += details.focalPointDelta * 0.9;
        }

        widget.onScale(_scale, _offset);
      },
      onTapUp: (details) {
        widget.onTapUp?.call(details);
      },
      child: widget.child,
    );
  }
}
