import 'package:flutter/material.dart';

class LabelComponent extends StatelessWidget {
  final String? labelText;
  final Widget? labelWidget;
  final Color? labelColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget? icon;

  const LabelComponent({
    this.labelText,
    this.labelWidget,
    super.key,
    this.labelColor,
    this.padding,
    this.margin,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(12),
      padding: padding ?? EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color:
            labelColor ??
            Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withValues(alpha: .3),
        borderRadius: BorderRadius.circular(8),
      ),
      child:
          labelWidget ??
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              if (icon != null) icon!,
              Text(
                labelText ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
    );
  }
}
