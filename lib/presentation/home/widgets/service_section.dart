import 'package:courier_merchent_app/presentation/parcel/add_single_parcel/add_single_parcel_screen.dart';
import 'package:courier_merchent_app/presentation/widgets/k_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';
import '../../parcel/add_bulk_parcel/add_bulk_parcel_screen.dart';

class ServiceSection extends StatelessWidget {
  const ServiceSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        childAspectRatio: 1.2,
      ),
      children: [
        ServiceItem(
          title: "Single Parcel",
          child: Image.asset(
            Images.singleParcel3d,
            height: 64.h,
          ),
          onTap: () => context.push(AddSingleParcelScreen.route),
        ),
        ServiceItem(
          title: "Bulk Parcel",
          child: Image.asset(
            Images.bulkParcel3d,
            height: 64.h,
          ),
          onTap: () => context.push(AddBulkParcelScreen.route),
        ),
      ],
    );
  }
}

class ServiceItem extends StatelessWidget {
  const ServiceItem({
    Key? key,
    required this.title,
    required this.child,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return KInkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.r),
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          Container(
            padding: padding16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPalate.white.withOpacity(.4),
            ),
            alignment: Alignment.center,
            child: child,
          ),
          title.text.bold.xl.color(ColorPalate.primary300.darken()).make(),
        ],
      ).box.color(context.colors.primary.withOpacity(.1)).rounded.make(),
    );
  }
}
