import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';

class KIconElevatedButton extends HookConsumerWidget {
  const KIconElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.loading = false,
  }) : super(key: key);

  final String text;
  final Widget icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;
  final bool? loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ButtonStyle(
        // shape: MaterialStateProperty.all(
        //   RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10.r),
        //   ),
        // ),
        minimumSize: MaterialStateProperty.all(Size.fromHeight(55.h)),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
      ),
      onPressed: onPressed,
      child: (loading != null && loading!)
          ? SizedBox(
              height: 30.h,
              width: 30.h,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? Theme.of(context).colorScheme.secondary,
                ),
              ),
            )
          : Row(
              children: [
                Expanded(child: Center(child: Text(text))),
                Material(
                  elevation: 4,
                  color: backgroundColor ?? Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(100.r),
                  child: Padding(
                    padding: EdgeInsets.all(6.w),
                    child: icon,
                  ),
                ),
              ],
            ),
    );
  }
}

class KElevatedButton extends HookConsumerWidget {
  const KElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.loading,
    this.child,
    this.isSecondary = false,
    this.textStyle,
    this.size,
  }) : super(key: key);

  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onPressed;
  final bool? loading;
  final Widget? child;
  final bool isSecondary;
  final TextStyle? textStyle;
  final Size? size;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      // style: ButtonStyle(
      //   minimumSize: MaterialStateProperty.all(size ?? Size.fromHeight(55.h)),
      //   textStyle: MaterialStateProperty.all(textStyle),
      //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
      //       (Set<MaterialState> states) {
      //     if (states.contains(MaterialState.disabled)) {
      //       return context.theme.disabledColor;
      //     }
      //     return backgroundColor ??
      //         (isSecondary
      //             ? context.color.secondary
      //             : context.color.primary); // Use the component's default.
      //   }),
      //   foregroundColor:
      //       MaterialStateProperty.all(foregroundColor ?? Colors.white),
      //   overlayColor: MaterialStateProperty.all(
      //     isSecondary ? context.color.secondary : context.color.primary,
      //   ),
      // ),
      style: ElevatedButton.styleFrom(
        textStyle: textStyle ??
            TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: ColorPalate.secondary200,
            ),
        foregroundColor: foregroundColor ?? ColorPalate.secondary200,
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: (loading != null && loading!)
          ? SizedBox(
              height: 30.h,
              width: 30.h,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  isSecondary
                      ? context.colors.onSecondaryContainer
                      : context.colors.onPrimaryContainer,
                ),
              ),
            )
          : child ??
              Text(
                text,
              ),
    );
  }
}

class KOutlinedButton extends HookConsumerWidget {
  const KOutlinedButton({
    Key? key,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth,
    required this.onPressed,
    this.loading,
    this.textStyle,
    this.size,
    this.isSecondary = true,
    this.child,
    this.borderSide,
    this.borderStyle,
  }) : super(key: key);

  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final VoidCallback? onPressed;
  final ValueNotifier<bool>? loading;
  final TextStyle? textStyle;
  final Size? size;
  final bool isSecondary;
  final Widget? child;
  final BorderSide? borderSide;
  final BorderStyle? borderStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var side = borderSide?.copyWith(
      color: borderColor ?? ColorPalate.secondary200,
      width: borderWidth,
      style: borderStyle,
    );
    return OutlinedButton(
      // style: ButtonStyle(
      //   // shape: MaterialStateProperty.all(
      //   //   RoundedRectangleBorder(
      //   //     borderRadius: BorderRadius.circular(10.r),
      //   //   ),
      //   // ),

      //   // minimumSize: MaterialStateProperty.all(size ?? Size.fromHeight(48.h)),
      //   backgroundColor: MaterialStateProperty.all(backgroundColor),
      //   foregroundColor: MaterialStateProperty.all(foregroundColor),
      //   side: MaterialStateProperty.all(
      //     BorderSide(
      //       color: borderColor ??
      //           (isSecondary
      //               ? Theme.of(context).colorScheme.secondary
      //               : Theme.of(context).colorScheme.primary),
      //     ),
      //   ),
      //   overlayColor: MaterialStateProperty.all(
      //     (isSecondary
      //         ? Theme.of(context).colorScheme.secondary.withOpacity(.1)
      //         : Theme.of(context).colorScheme.primary.withOpacity(.1)),
      //   ),
      // ),
      style: OutlinedButton.styleFrom(
        textStyle: textStyle ??
            TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: ColorPalate.secondary200,
            ),
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        side: side,
      ),
      onPressed: onPressed,
      child: (loading != null && loading!.value)
          ? SizedBox(
              height: 30.h,
              width: 30.h,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? Theme.of(context).colorScheme.secondary,
                ),
              ),
            )
          : child ??
              Text(
                text,
                style: TextStyle(
                  color: isSecondary
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  letterSpacing: 1.50,
                  fontFamily: "Open Sans",
                ),
              ),
    );
  }
}

class KButton extends HookConsumerWidget {
  const KButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.loading,
    this.child,
  }) : super(key: key);

  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onPressed;
  final bool? loading;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      // style: ButtonStyle(
      //   // shape: MaterialStateProperty.all(
      //   //   RoundedRectangleBorder(
      //   //     borderRadius: BorderRadius.circular(10.r),
      //   //   ),
      //   // ),
      //   // minimumSize: MaterialStateProperty.all(Size.fromHeight(55.h)),
      //   backgroundColor: MaterialStateProperty.all(backgroundColor),
      //   foregroundColor: MaterialStateProperty.all(foregroundColor),
      // ),

      onPressed: onPressed,
      child: (loading != null && loading!)
          ? SizedBox(
              height: 30.h,
              width: 30.h,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? Theme.of(context).colorScheme.secondary,
                ),
              ),
            )
          : child ??
              Text(
                text,
              ),
    );
  }
}

class KFilledButton extends HookConsumerWidget {
  const KFilledButton({
    Key? key,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
    this.loading,
    this.child,
    this.isSecondary = false,
    this.textStyle,
    this.size,
    this.padding,
  }) : super(key: key);

  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onPressed;
  final bool? loading;
  final Widget? child;
  final bool isSecondary;
  final TextStyle? textStyle;
  final Size? size;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(
      // style: ButtonStyle(
      //   minimumSize: MaterialStateProperty.all(size ?? Size.fromHeight(55.h)),
      //   textStyle: MaterialStateProperty.all(textStyle),
      //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
      //       (Set<MaterialState> states) {
      //     if (states.contains(MaterialState.disabled)) {
      //       return context.theme.disabledColor;
      //     }
      //     return backgroundColor ??
      //         (isSecondary
      //             ? context.color.secondary
      //             : context.color.primary); // Use the component's default.
      //   }),
      //   foregroundColor:
      //       MaterialStateProperty.all(foregroundColor ?? Colors.white),
      //   overlayColor: MaterialStateProperty.all(
      //     isSecondary ? context.color.secondary : context.color.primary,
      //   ),
      // ),
      style: FilledButton.styleFrom(
        textStyle: textStyle ??
            TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
        foregroundColor: foregroundColor ?? ColorPalate.bg200,
        backgroundColor: backgroundColor,
        fixedSize: size,
        padding: padding,
      ),
      onPressed: onPressed,
      child: (loading != null && loading!)
          ? SizedBox(
              height: 30.h,
              width: 30.h,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  isSecondary
                      ? context.colors.onSecondaryContainer
                      : context.colors.onPrimaryContainer,
                ),
              ),
            )
          : child ?? Text(text),
    );
  }
}
