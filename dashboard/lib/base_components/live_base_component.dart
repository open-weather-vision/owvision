import 'package:dashboard/base_components/label_component.dart';
import 'package:flutter/material.dart';

class LiveBaseComponent extends StatelessWidget {
  final List<Widget> children;
  final Color color;
  final Color? borderColor;
  final EdgeInsets? padding;
  final String? label;
  final Color? labelColor;
  final double? borderWidth;
  final double? height;
  final DecorationImage? backgroundImage;
  final Widget? labelIcon;
  final bool connected;

  const LiveBaseComponent(
    this.children, {
    super.key,
    required this.label,
    this.color = Colors.blueGrey,
    this.borderColor,
    this.padding,
    this.labelColor,
    this.borderWidth,
    this.height,
    this.backgroundImage,
    this.labelIcon,
    required this.connected,
  });

  @override
  Widget build(BuildContext context) {
    final lightMode = Theme.of(context).brightness == Brightness.light;
    return Opacity(
      opacity: connected ? 1.0 : 0.5,
      child: Container(
        height: height,
        padding: padding ?? const EdgeInsets.all(16),
        margin: const EdgeInsets.all(5),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          image: backgroundImage,
          color: lightMode ? color : color.withAlpha(150),
          borderRadius: BorderRadius.circular(12),
          border: borderWidth != 0
              ? Border.all(
                  color:
                      borderColor ??
                      (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withAlpha(120)
                          : Colors.transparent),
                  width: borderWidth ?? 1.5,
                )
              : null,
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            ...children,
            if (label != null)
              LabelComponent(
                labelText: label!,
                labelColor: labelColor,
                icon: labelIcon,
              ),
          ],
        ),
      ),
    );
  }
}
