import 'package:courier_merchent_app/presentation/parcel/add_parcel/add_parcel_screen.dart';
import 'package:courier_merchent_app/presentation/widgets/k_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';

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
        childAspectRatio: 1.4,
      ),
      children: [
        ServiceItem(
          title: "Pick Up",
          child: Image.asset(
            Images.truck,
            height: 52.h,
          ),
          onTap: () => context.push(AddParcelScreen.route),
        ),
        ServiceItem(
          title: "Tracking",
          child: Image.asset(
            Images.parcelSearch,
            height: 52.h,
          ),
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
          child,
          gap6,
          title.text.bold.xl.make(),
        ],
      ).box.color(context.colors.primary.withOpacity(.1)).rounded.make(),
    );
  }
}
