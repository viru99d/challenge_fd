import 'package:flutter/material.dart';

class VerticalSpace {
  const VerticalSpace._();
  static const xxs = SizedBox(height: Spacing.xxs);

  static const xs = SizedBox(height: Spacing.xs);

  static const sm = SizedBox(height: Spacing.sm);

  static const sl = SizedBox(height: Spacing.sl);

  static const md = SizedBox(height: Spacing.md);

  static const lg = SizedBox(height: Spacing.lg);

  static const xl = SizedBox(height: Spacing.xl);

  static const xxl = SizedBox(height: Spacing.xxl);
}

class HorizontalSpace {
  const HorizontalSpace._();
  static const xxs = SizedBox(width: Spacing.xxs);

  static const xs = SizedBox(width: Spacing.xs);

  static const sm = SizedBox(width: Spacing.sm);

  static const sl = SizedBox(width: Spacing.sl);

  static const md = SizedBox(width: Spacing.md);

  static const lg = SizedBox(width: Spacing.lg);

  static const xl = SizedBox(width: Spacing.xl);

  static const xxl = SizedBox(width: Spacing.xxl);
}

class Spacing {
  Spacing._();

  ///zero = 0
  static const double zero = 0;

  ///xxs = 2
  static const double xxs = 2;

  ///xs = 4
  static const double xs = 4;

  ///sm = 8
  static const double sm = 8;

  ///sl = 12
  static const double sl = 12;

  ///md = 16
  static const double md = 16;

  ///lg = 24
  static const double lg = 24;

  ///xl = 32
  static const double xl = 32;

  ///xxl = 48
  static const double xxl = 48;
}
