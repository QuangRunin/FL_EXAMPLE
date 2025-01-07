import 'package:flutter/material.dart';

class WidgetBorderImage extends StatelessWidget {
  const WidgetBorderImage({
    super.key,
    this.shape,
    this.padding = 3,
    required this.child,
  });
  final BoxShape? shape;
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
          ],
        ),
      ),
      child: child,
    );
  }
}
