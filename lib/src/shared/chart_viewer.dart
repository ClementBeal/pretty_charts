import 'package:flutter/widgets.dart';

class ChartViewer extends StatefulWidget {
  const ChartViewer({
    super.key,
    required this.child,
    required this.onScale,
    required this.initialScale,
  });

  final Widget child;
  final void Function(double scaleFactor) onScale;
  final double initialScale;

  @override
  State<ChartViewer> createState() => _ChartViewerState();
}

class _ChartViewerState extends State<ChartViewer> {
  double _scale = 1.0;
  double _tmpScale = 1.0;

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
        _scale = _tmpScale * details.scale;
        widget.onScale(_scale);
      },
      child: widget.child,
    );
  }
}
