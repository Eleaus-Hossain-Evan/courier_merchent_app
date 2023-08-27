import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../domain/auth/model/shop_model.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class MerchantInfoSection extends StatelessWidget {
  const MerchantInfoSection({
    super.key,
    required this.scaffoldKey,
    required this.myShops,
    required this.selectedShop,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final AsyncValue<IList<MyShopModel>> myShops;
  final ValueNotifier<MyShopModel?> selectedShop;

  @override
  Widget build(BuildContext context) {
    return IndividualSection(
      title: AppStrings.merchantInformation,
      action: KInkWell(
        onTap: () => scaffoldKey.currentState?.openEndDrawer(),
        child: const Icon(EvaIcons.chevron_right),
      ),
      child: KInkWell(
        onTap: () => scaffoldKey.currentState?.openEndDrawer(),
        child: myShops.when(
          data: (data) => Visibility(
            visible: selectedShop.value != null,
            replacement: AppStrings.noShopSelected.text
                .caption(context)
                .red500
                .make()
                .p20(),
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                (selectedShop.value?.shopName ?? "")
                    .text
                    .bold
                    .make()
                    .objectCenterLeft(),
                gap4,
                // "Address: ".richText.semiBold.withTextSpanChildren([
                //   "${selectedShop.value?.address}".textSpan.normal.make(),
                // ]).make(),
                Text.rich(
                  TextSpan(
                    text: "${AppStrings.address}:  ",
                    children: [
                      TextSpan(
                        text: "${selectedShop.value?.address}",
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            )
                .pOnly(left: 16, right: 16, top: 10, bottom: 10)
                .box
                .roundedSM
                .border(color: ColorPalate.black500, width: 1.2.w)
                .make(),
          ),
          error: (error, stackTrace) => const SizedBox.shrink(),
          loading: () => Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade100,
            child: KShimmerContainer(
              height: 70.h,
            ),
          ),
        ),
      ),
    );
  }
}
