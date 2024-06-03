import 'package:flutter/material.dart';

class KCircleButton extends StatelessWidget {
  const KCircleButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.size = 16,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(const CircleBorder()),
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        minimumSize: WidgetStateProperty.all(Size(size, size)),
        maximumSize: WidgetStateProperty.all(Size(size, size)),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
