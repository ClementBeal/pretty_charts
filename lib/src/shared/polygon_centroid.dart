import 'package:flutter/material.dart';

Offset getPolygonCentroid(Iterable<Offset> cartesianPositions) {
  var xCentroid = 0.0;
  var yCentroid = 0.0;

  for (var e in cartesianPositions) {
    xCentroid += e.dx;
    yCentroid += e.dy;
  }

  return Offset(
    xCentroid / cartesianPositions.length,
    yCentroid / cartesianPositions.length,
  );
}
