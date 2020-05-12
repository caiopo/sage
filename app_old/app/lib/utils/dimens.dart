import 'dart:math';

import 'package:flutter/material.dart';

final _base = Size(360, 592);

bool isTablet(BuildContext context) {
  return MediaQuery.of(context).size.shortestSide >= 600;
}

double test(double size, BuildContext context) {
  final screenSize = MediaQuery.of(context).size;

  final ratioHeight = screenSize.longestSide / _base.longestSide;
  final ratioWidth = screenSize.shortestSide / _base.longestSide;

  return size * max(ratioWidth, ratioHeight);
}
