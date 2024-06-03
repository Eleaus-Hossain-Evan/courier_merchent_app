import 'package:courier_merchent_app/presentation/widgets/k_inkwell.dart';
import 'package:courier_merchent_app/utils/color_palate.dart';
import 'package:courier_merchent_app/utils/constant/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.isPast,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final bool isPast;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      return isPast
          ? context.colors.primary.withOpacity(.5)
          : Colors.transparent;
    }

    return KInkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: mainMin,
        crossAxisAlignment: crossStart,
        mainAxisAlignment: mainSpaceEven,
        children: [
          title
              .toDateString()
              .text
              .labelSmall(context)
              .semiBold
              .color(ColorPalate.black500)
              .make(),
          gap2,
          subTitle.text.lg.letterSpacing(.6).make(),
        ],
      ).p8(),
    ).p8().box.color(getColor()).roundedSM.make().pOnly(left: 8.w);
  }
}
