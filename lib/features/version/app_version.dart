import 'package:alabtechnology/core/theme/font_size.dart';
import 'package:flutter/material.dart';

class AppVersionInfo extends StatelessWidget {
  const AppVersionInfo({
    required this.version,
    required this.isProduction,
    super.key,
    this.labelStyle,
    this.subLabelStyle,
    this.label,
    this.spacing,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.mainAxisSize,
    this.widget,
  }) : assert(
          widget == null || label == null,
          'Provide either label or widget, not both',
        );

  final String version;
  final bool isProduction;
  final double? spacing;
  final String? label;
  final TextStyle? labelStyle;
  final TextStyle? subLabelStyle;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final Widget? widget;

  static const String _label = 'Crafted by Alabtechnology Pvt Ltd';

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacing ?? 0,
      mainAxisSize: mainAxisSize ?? MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: [
        if (widget != null)
          widget!
        else
          Text(
            label ?? _label,
            style: labelStyle ??
                Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: AppFontSize.xxs),
            textAlign: TextAlign.center,
          ),
        Text(
          'App version:${isProduction ? "" : " DEV"} - $version',
          style: subLabelStyle ??
              Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: AppFontSize.xxxs),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
