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
        ParcelRegularStatus.returns => context.colors.error,
        ParcelRegularStatus.returnEnd => context.colors.error,
        ParcelRegularStatus.cancel => context.colors.error,
        ParcelRegularStatus.hold => context.colors.secondary,
        ParcelRegularStatus.pending => context.colors.secondary,
        ParcelRegularStatus.dropoff => ColorPalate.black700,
        _ => context.colors.primary,
      };
    }

    return Container(
      height: 24.h,
      padding: paddingH10,
      decoration: BoxDecoration(
        color: getColor().withOpacity(.1),
        border: Border.all(color: getColor().withOpacity(.2)),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: status.changedValue
          .toTitleCaseFromSnack()
          .text
          .xs
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
