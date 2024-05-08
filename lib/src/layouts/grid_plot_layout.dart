import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GridPlotLayout extends StatefulWidget {
  const GridPlotLayout({
    super.key,
    required this.pattern,
    required this.orders,
    required this.children,
  });

  final String pattern;
  final String orders;
  final List<Widget> children;

  @override
  State<GridPlotLayout> createState() => _GridPlotLayoutState();
}

class _GridPlotLayoutState extends State<GridPlotLayout> {
  int nbCols = 0;
  int nbLines = 0;

  Map<String, (Offset, int, int)> _layout = {};

  @override
  void initState() {
    super.initState();

    loadPattern();
  }

  @override
  void didUpdateWidget(covariant GridPlotLayout oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.pattern != widget.pattern ||
        oldWidget.orders != widget.orders) {
      loadPattern();
    }
  }

  void loadPattern() {
    final trimPattern = widget.pattern.replaceAll(RegExp(r"\s"), "");
    final lines = widget.pattern.trim().split("\n");
    final totalLines = lines.length;
    final totalCols = lines.first.length;

    final hasCorrectDimension =
        lines.every((element) => element.length == totalCols);

    if (!hasCorrectDimension) {
      throw Exception(
          "Your GridPlotLayout dimension is not correct. Please check that all your rows have the same number of columns.");
    }

    final letters = <String>{};

    for (var i = 0; i < trimPattern.length; i++) {
      letters.add(trimPattern[i]);
    }

    if (!setEquals(letters, widget.orders.split("").toSet())) {
      throw Exception(
          "Your GridPlotLayout pattern and orders don't match. Please check that all you didn't add or remove a letter.");
    }

    final layout = <String, (Offset, int, int)>{};

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];

      final alreadyAddedRow = <String>{};
      final cols = <String, int>{};
      final fixedCols = <String>{};

      for (var j = 0; j < line.length; j++) {
        final letter = line[j];

        if (!fixedCols.contains(letter)) {
          cols.update(
            letter,
            (value) => value + 1,
            ifAbsent: () => 1,
          );
        }

        layout.update(
          letter,
          (value) => (
            value.$1,
            value.$2 + ((alreadyAddedRow.contains(letter)) ? 0 : 1),
            cols[letter]!,
          ),
          ifAbsent: () => (Offset(i + 1, j + 1), 1, 1),
        );

        alreadyAddedRow.add(letter);
      }
    }

    setState(() {
      nbCols = totalCols;
      nbLines = totalLines;
      _layout = layout;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cellWidth = constraints.maxWidth / nbCols;
        final cellHeight = constraints.maxHeight / nbLines;

        return Stack(
          fit: StackFit.expand,
          children: _layout.entries.map(
            (e) {
              final index = widget.orders.indexOf(e.key);
              final offset = e.value.$1;
              final rows = e.value.$2;
              final cols = e.value.$3;

              return Positioned(
                top: (cellHeight + (offset.dx - 1) * 4) * (offset.dx - 1),
                left: (cellWidth + (offset.dy - 1) * 4) * (offset.dy - 1),
                child: SizedBox(
                  width: cellWidth * cols,
                  height: cellHeight * rows,
                  child: widget.children[index],
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
