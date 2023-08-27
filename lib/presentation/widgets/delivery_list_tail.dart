import 'package:courier_merchent_app/presentation/widgets/k_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../domain/parcel/model/parcel_model.dart';
import '../../utils/utils.dart';
import '../parcel/add_parcel/add_parcel_screen.dart';
import '../parcel/parcel_detail_screen.dart';

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
    Color getColor() {
      return parcel.regularStatus == ParcelRegularStatus.pending
          ? context.colors.secondary
          : parcel.regularStatus == ParcelRegularStatus.cancel
              ? context.colors.error
              : context.colors.primary;
    }

    return KInkWell(
      onTap: () =>
          context.push("${ParcelDetailScreen.route}/${parcel.serialId}"),
      child: Row(
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
            mainAxisAlignment: mainSpaceEven,
            children: [
              Row(
                mainAxisAlignment: mainSpaceBetween,
                children: [
                  parcel.customerInfo.name.text
                      .softWrap(true)
                      .xl
                      .extraBold
                      .ellipsis
                      .maxLines(1)
                      .make()
                      .flexible(),
                  Visibility(
                    visible: parcel.merchantUpdate <= 0,
                    child: SizedBox(
                      width: 48.w,
                      height: 28.h,
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
                  ),
                ],
              ),
              // gap8,
              "Tr. ID: ${parcel.serialId}".text.caption(context).make(),
              // gap8,
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
                          // .caption(context)
                          .extraBold
                          .caption(context)
                          .make(),
                    ],
                  ),
                  gap16,
                  VxCapsule(
                    width: 72.w,
                    height: 24.h,
                    backgroundColor: getColor().withOpacity(.1),
                    border: Border.all(color: getColor().withOpacity(.2)),
                    child: parcel.regularStatus.value.text.xs
                        .letterSpacing(1)
                        .medium
                        .color(getColor())
                        .bold
                        .capitalize
                        .make()
                        .centered(),
                  ),
                ],
              ),
            ],
          ).flexible(),
        ],
      ).p12(),
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