import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

kShowBottomSheet({
  required BuildContext context,
  required Widget child,
}) {
  return showMaterialModalBottomSheet(
    // expand: false,
    context: context,
    builder: (context) => child,
  );
}

kShowbarModalBottomSheet({
  required BuildContext context,
  required Widget child,
}) {
  return showBarModalBottomSheet(
    // expand: false,
    context: context,
    barrierColor: Colors.black38,
    builder: (context) => child,
  );
}

/// Modal which is styled for the Flutter News Example app.
Future<T?> showAppModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  RouteSettings? routeSettings,
  BoxConstraints? constraints,
  double? elevation,
  Color? barrierColor,
  bool isDismissible = true,
  bool enableDrag = true,
  AnimationController? transitionAnimationController,
}) {
  return showModalBottomSheet(
    context: context,
    builder: builder,
    routeSettings: routeSettings,
    constraints: constraints,
    isScrollControlled: true,
    barrierColor: barrierColor,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    transitionAnimationController: transitionAnimationController,
    elevation: elevation,
  );
}
