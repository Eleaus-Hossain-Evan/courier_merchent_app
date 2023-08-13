import 'package:courier_merchent_app/presentation/parcel/add_parcel_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../domain/parcel/model/parcel_model.dart';
import '../../utils/utils.dart';

class DeliveryListTile extends StatelessWidget {
  const DeliveryListTile({
    Key? key,
    this.leadingImage = Images.deliveryBoxList,
    required this.parcel,
  }) : super(key: key);

  final String leadingImage;
  final ParcelModel parcel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: mainMin,
      children: [
        leadingImage
            .assetImage(
              height: 90.h,
              width: 80.w,
            )
            .box
            .colorScaffoldBackground(context)
            .roundedSM
            .make(),
        gap16,
        Column(
          crossAxisAlignment: crossStart,
          mainAxisAlignment: mainSpaceEven,
          children: [
            parcel.customerInfo.name.text
                .softWrap(true)
                .xl
                .extraBold
                .ellipsis
                .maxLines(1)
                .make(),
            gap12,
            Row(
              mainAxisAlignment: mainEnd,
              crossAxisAlignment: crossStart,
              children: [
                Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    "Tr. ID: ${parcel.serialId}".text.caption(context).make(),
                    gap12,
                    Row(
                      mainAxisAlignment: mainSpaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Bootstrap.currency_exchange,
                              size: 14.sp,
                            ),
                            gap4,
                            "${parcel.regularPayment.cashCollection}${AppStrings.tkSymbol}"
                                .text
                                // .caption(context)
                                .extraBold
                                .caption(context)
                                .make(),
                          ],
                        ),
                        VxCapsule(
                          width: 72.w,
                          height: 24.h,
                          backgroundColor:
                              context.theme.primaryColorLight.withOpacity(.2),
                          child: parcel.regularStatus.text.xs
                              .letterSpacing(1)
                              .medium
                              .colorPrimary(context)
                              .bold
                              .capitalize
                              .make()
                              .centered(),
                        ),
                      ],
                    ),
                  ],
                ).flexible(),
                gap8,
                Visibility(
                  visible: parcel.merchantUpdate <= 0,
                  child: IconButton.outlined(
                    padding: padding0,
                    onPressed: () {
                      context.push(AddParcelScreen.route, extra: parcel);
                    },
                    icon: Icon(
                      BoxIcons.bx_edit_alt,
                      size: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).flexible(),
      ],
    ).p12();
  }

  factory DeliveryListTile.loading({
    required ParcelModel parcel,
  }) =>
      DeliveryListTile(
        leadingImage: Images.deliveryBoxLoading,
        parcel: parcel,
      );
  factory DeliveryListTile.complete({
    required String customerName,
    required ParcelModel parcel,
  }) =>
      DeliveryListTile(
        leadingImage: Images.deliveryBoxCheck,
        parcel: parcel,
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