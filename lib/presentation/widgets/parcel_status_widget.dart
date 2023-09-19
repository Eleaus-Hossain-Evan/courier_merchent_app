import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';

class ParcelStatusWidget extends StatelessWidget {
  const ParcelStatusWidget({
    super.key,
    required this.status,
  });

  final ParcelRegularStatus status;

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      return switch (status) {
        ParcelRegularStatus.cancel => context.colors.error,
        ParcelRegularStatus.hold => context.colors.secondary,
        ParcelRegularStatus.pending => context.colors.secondary,
        _ => context.colors.primary,
      };
    }

    return VxCapsule(
      width: 72.w,
      height: 24.h,
      backgroundColor: getColor().withOpacity(.1),
      border: Border.all(color: getColor().withOpacity(.2)),
      child: status.value.text.xs
          .letterSpacing(1)
          .medium
          .color(getColor())
          .bold
          .capitalize
          .make()
          .centered(),
    );
  }
}
