import 'package:flutter/material.dart';

import '../../utils/util.dart';

class ResponsiveText extends StatelessWidget {
  const ResponsiveText(
    this.text, {
    this.fontSize = 14,
    this.textColor,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.fontFamily,
    this.fontStyle,
    this.textOverflow,
    this.maxLines,
    this.decoration,
        this.height
  });

  final double fontSize;
  final String text;
  final Color? textColor;
  final TextAlign textAlign;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextOverflow? textOverflow;
  final FontStyle? fontStyle;
  final int? maxLines;
  final double? height;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      textScaler: const TextScaler.linear(1),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        decoration: decoration,
          color: textColor,
          height: height,
          fontFamily: 'Poppins',
          fontSize: getResponsiveFont(fontSize),
          fontWeight: fontWeight,
          overflow: textOverflow,

          fontStyle: fontStyle),
      maxLines: maxLines,
    );
  }
}
