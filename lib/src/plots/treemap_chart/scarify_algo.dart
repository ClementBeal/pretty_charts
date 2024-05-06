import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class TreeMapSection {
  final Rect rect;
  final TreeMapChartData data;
  Color? color;

  TreeMapSection({required this.rect, required this.data, this.color});

  @override
  String toString() {
    return "$rect $data";
  }
}

class ScarifyTreeMap {
  static List<TreeMapChartData> normalizeValues(
      List<TreeMapChartData> data, Rect rect) {
    final totalSize = data.fold(
        0.0, (previousValue, element) => previousValue + element.value);
    final totalArea = rect.width * rect.height;

    return data
        .map(
          (e) => TreeMapChartData(
            name: e.name,
            value: e.value / totalSize * totalArea,
            children: e.children,
          ),
        )
        .sorted((a, b) => b.value.compareTo(a.value))
        .toList();
  }

  List<TreeMapSection> scarify(
    List<TreeMapChartData> data,
    Rect rect,
  ) {
    if (data.isEmpty) {
      return [];
    }

    var i = 1;
    while ((i < data.length) &&
        (worstRatio(data.sublist(0, i), rect) >=
            worstRatio(data.sublist(0, i + 1), rect))) {
      i += 1;
    }
    final current = layout(data.sublist(0, i), rect);
    final remaining = data.sublist(i);
    final a = data.sublist(0, i);

    final remainingRect = getRemainingRect(current, rect);
    int j = 0;

    for (var d in a) {
      if (d.children?.isNotEmpty ?? false) {
        final normalizedChildrenValues =
            ScarifyTreeMap.normalizeValues(d.children!, current[j].rect);
        final rects = scarify(normalizedChildrenValues, current[j].rect);
        current.insertAll(j + 1, rects);
        j += d.children!.length;
      }
      j++;
    }

    return [...current, ...scarify(remaining, remainingRect)];
  }

  List<TreeMapSection> layout(List<TreeMapChartData> data, Rect rect) {
    final rects = <TreeMapSection>[];

    if (rect.width > rect.height) {
      // stack in col
      final totalArea = data.fold(
          0.0, (previousValue, element) => previousValue + element.value);
      final height = rect.height;
      final width = totalArea / height;

      var y = rect.top;

      for (final d in data) {
        rects.add(
          TreeMapSection(
            rect: Rect.fromLTWH(
                rect.left, y, width, d.value / totalArea * height),
            data: d,
          ),
        );
        y += d.value / totalArea * height;
      }
    } else {
      // stack in row
      final totalArea = data.fold(
          0.0, (previousValue, element) => previousValue + element.value);
      final width = rect.width;
      final height = totalArea / width;

      var x = rect.left;

      for (final d in data) {
        rects.add(
          TreeMapSection(
            rect: Rect.fromLTWH(
              x,
              rect.top,
              d.value / totalArea * width,
              height,
            ),
            data: d,
          ),
        );
        x += d.value / totalArea * width;
      }
    }

    return rects;
  }

  Rect getRemainingRect(List<TreeMapSection> currentRects, Rect biggerRect) {
    if (biggerRect.width >= biggerRect.height) {
      return Rect.fromLTWH(
        biggerRect.left + currentRects.first.rect.width,
        biggerRect.top,
        biggerRect.width - currentRects.first.rect.width,
        biggerRect.height,
      );
    } else {
      return Rect.fromLTWH(
        biggerRect.left,
        biggerRect.top + currentRects.first.rect.height,
        biggerRect.width,
        biggerRect.height - currentRects.first.rect.height,
      );
    }
  }

  double worstRatio(List<TreeMapChartData> data, Rect rect) {
    final rects = layout(data, rect);

    final ration = rects
        .map((e) => math.max(
            e.rect.width / e.rect.height, e.rect.height / e.rect.width))
        .fold(
          double.negativeInfinity,
          (previousValue, element) => math.max(previousValue, element),
        );

    return ration;
  }
}
