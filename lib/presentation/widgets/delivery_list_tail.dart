import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_merchent_app/presentation/widgets/k_inkwell.dart';

import '../../domain/parcel/model/parcel_model.dart';
import '../../utils/utils.dart';
import '../parcel/add_single_parcel/add_single_parcel_screen.dart';
import '../parcel/track_parcel/track_parcel_screen.dart';
import 'widgets.dart';

class DeliveryListTile extends StatelessWidget {
  const DeliveryListTile({
    Key? key,
    this.leadingImage = Images.deliveryBoxList,
    required this.parcel,
    this.isEditable = true,
  }) : super(key: key);

  final String leadingImage;
  final ParcelModel parcel;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return KInkWell(
      onTap: () =>
          context.push("${TrackParcelScreen.route}/${parcel.serialId}"),
      child: Column(
        mainAxisSize: mainMin,
        mainAxisAlignment: mainStart,
        crossAxisAlignment: crossStart,
        children: [
          gap12,
          Text.rich(
            TextSpan(
              children: [
                "Tr. ID: "
                    .textSpan
                    .caption(context)

                    // .color(ColorPalate.black1000)
                    .make(),
                parcel.serialId.textSpan
                    .caption(context)
                    .letterSpacing(.8)
                    .color(ColorPalate.black500)
                    .semiBold
                    .make(),
              ],
            ),
          ).px16(),
          Row(
            mainAxisSize: mainMin,
            children: [
              leadingImage
                  .assetImage(
                    height: 80.h,
                    width: 80.w,
                  )
                  .box
                  .colorScaffoldBackground(context)
                  .roundedSM
                  .make(),
              gap16,
              Column(
                crossAxisAlignment: crossStart,
                mainAxisAlignment: mainSpaceAround,
                children: [
                  parcel.customerInfo.name.text
                      .softWrap(true)
                      .xl
                      .extraBold
                      .ellipsis
                      .maxLines(1)
                      .make(),
                  gap6,
                  Row(
                    children: [
                      Icon(
                        BoxIcons.bx_phone,
                        size: 14.sp,
                      ),
                      gap4,
                      parcel.customerInfo.phone.text.caption(context).make(),
                    ],
                  ),
                  gap6,
                  Row(
                    mainAxisAlignment: mainStart,
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
                              .caption(context)
                              .make(),
                        ],
                      ),
                      gap16,
                      Row(
                        children: [
                          Icon(
                            BoxIcons.bx_money,
                            size: 14.sp,
                          ),
                          gap4,
                          "${parcel.regularPayment.totalCharge}${AppStrings.tkSymbol}"
                              .text
                              // .caption(context)

                              .caption(context)
                              .make(),
                        ],
                      ),
                    ],
                  ),
                ],
              ).flexible(),

              // parcel edit button (push to add parcel page for editing)

              Column(
                mainAxisAlignment: mainSpaceAround,
                mainAxisSize: mainMax,
                children: [
                  Visibility(
                    visible: parcel.merchantUpdate <= 0 && isEditable,
                    child: SizedBox(
                      width: 48.w,
                      height: 28.h,
                      child: IconButton.outlined(
                        padding: padding0,
                        onPressed: () {
                          context.push(AddSingleParcelScreen.route,
                              extra: parcel);
                        },
                        icon: Icon(
                          BoxIcons.bx_edit_alt,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),
                  gap16,
                  ParcelStatusWidget(status: parcel.regularStatus),
                ],
              ),
            ],
          ).p12(),
        ],
      ),
    );
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