import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';

class DeliveryListTile extends StatelessWidget {
  const DeliveryListTile({
    Key? key,
    this.leadingImage = Images.deliveryBoxList,
    required this.customerName,
    required this.address,
    required this.price,
    required this.serialId,
    required this.status,
  }) : super(key: key);

  final String leadingImage;
  final String customerName;
  final String address;
  final String price;
  final String serialId;
  final String status;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      visualDensity: VisualDensity.adaptivePlatformDensity,
      style: ListTileStyle.list,
      // isThreeLine: true,
      contentPadding: EdgeInsets.only(left: 16.w, right: 8.w),
      leading: leadingImage.assetImage(
        height: 42.h,
        width: 42.w,
      ),
      title: customerName.text.extraBold.make(),
      subtitle: "Tracking ID $serialId".text.caption(context).make(),
      trailing: Column(
        children: [
          "${AppStrings.tkSymbol}$price"
              .text
              // .caption(context)
              .extraBold
              .lg
              .caption(context)
              .make(),
          gap8,
          VxCapsule(
            width: 72.w,
            height: 24.h,
            backgroundColor: context.theme.primaryColorLight,
            child: status.text.xs
                .letterSpacing(1)
                .medium
                .capitalize
                .make()
                .centered(),
          ),
        ],
      ),
    )
        .box
        // .color(ColorPalate.secondary.lighten())
        .border(
          color: ColorPalate.black.withOpacity(.05),
          width: 1.2.w,
        )
        .roundedSM
        // .shadowSm
        // .colorScaffoldBackground(context)
        .make();
  }

  factory DeliveryListTile.loading({
    required String customerName,
    required String address,
    required String distance,
    String serialId = "",
    required String status,
  }) =>
      DeliveryListTile(
        leadingImage: Images.deliveryBoxLoading,
        customerName: customerName,
        address: address,
        price: distance,
        serialId: serialId,
        status: status,
      );
  factory DeliveryListTile.complete({
    required String customerName,
    required String address,
    required String distance,
    String serialId = "",
    required String status,
  }) =>
      DeliveryListTile(
        leadingImage: Images.deliveryBoxCheck,
        customerName: customerName,
        address: address,
        price: distance,
        serialId: serialId,
        status: status,
      );
}


// KInkWell(
//       onTap: () {},
//       child: Column(
//         crossAxisAlignment: crossStart,
//         children: [
//           Row(
//             crossAxisAlignment: crossCenter,
//             children: [
//               leadingImage.assetImage(
//                 height: 42.h,
//                 width: 42.w,
//               ),
//               gap12,
//               Expanded(
//                 child: customerName.text.xl.bold.make(),
//               ),
//               "${AppStrings.tkSymbol}$price"
//                   .text
//                   // .caption(context)
//                   .extraBold
//                   .lg
//                   .caption(context)
//                   .make()
//                   .p4(),
//             ],
//           ),
//           gap4,
//           Row(
//             mainAxisAlignment: mainSpaceBetween,
//             children: [
//               "Tracking ID : $serialId".text.caption(context).make(),
//               VxCapsule(
//                 width: 68.w,
//                 height: 32.h,
//                 backgroundColor: context.theme.primaryColorLight,
//                 child: status.text.xs
//                     .letterSpacing(1)
//                     .medium
//                     .capitalize
//                     .make()
//                     .centered(),
//               ),
//             ],
//           ),
//           gap4,
//         ],
//       ),
//     )
//         .p8()