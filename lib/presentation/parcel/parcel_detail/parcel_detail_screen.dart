import 'package:courier_merchent_app/presentation/parcel/invoice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_merchent_app/presentation/widgets/widgets.dart';

import '../../../application/parcel/parcel_provider.dart';
import '../../../utils/utils.dart';
import 'section/customer_info_section.dart';
import 'section/merchant_shop_info_section.dart';
import 'section/parcel_info_section.dart';
import 'section/parcel_reguler_log_section.dart';
import 'section/payment_detail_section.dart';

class ParcelDetailScreen extends HookConsumerWidget {
  static const route = '/parcel-detail';

  final String parcelId;
  const ParcelDetailScreen({
    super.key,
    required this.parcelId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parcel = ref.watch(singleParcelProvider(parcelId));

    final scaffoldKey = useMemoized<GlobalKey<ScaffoldState>>(GlobalKey.new);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: const Drawer(),
      appBar: const KAppBar(titleText: 'TRACK PARCEL'),
      body: parcel.when(
        data: (data) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                gap16,
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: crossStart,
                      children: [
                        Text.rich(
                          'Tracking ID: '.textSpan.withChildren([
                            data.serialId.textSpan
                                .color(ColorPalate.black600)
                                .semiBold
                                .make(),
                          ]).make(),
                        ).px16(),
                        gap16,
                        Row(
                          children: [
                            'Status : '.text.make(),
                            ParcelStatusWidget(status: data.regularStatus),
                          ],
                        ).px16(),
                      ],
                    ).flexible(),
                    IconButton(
                      onPressed: () =>
                          context.push("${InvoiceScreen.route}/$parcelId"),
                      icon: Icon(
                        Bootstrap.file_earmark_pdf,
                        size: 26.sp,
                      ).p12(),
                    ),
                    gap4,
                  ],
                ),
                gap6,
                ParcelRegularLogSection(data: data),
                gap16,
                CustomerInfoSection(data: data),
                gap16,
                ParcelInfoSection(data: data),
                gap16,
                MerchantShopInfoSection(data: data),
                gap16,
                PaymentDetailSection(data: data),
              ],
            ),
          );
        },
        // data: (data) => const ParcelDetailShimmer(),
        error: (error, stackTrace) => error.toString().text.make(),
        loading: () => const ParcelDetailShimmer(),
      ),
    );
  }
}

class ParcelDetailShimmer extends StatelessWidget {
  const ParcelDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return VxShimmer(
      primaryColor: Colors.grey.shade300,
      secondaryColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              children: [
                VxSkeleton(
                  height: 120.h,
                  width: .3.sw,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                gap16,
                Column(
                  children: [
                    VxSkeleton(
                      height: 50.h,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    gap16,
                    VxSkeleton(
                      height: 50.h,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ],
                ).expand(),
              ],
            ),
            gap16,
            VxSkeleton(
              height: 50.h,
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            gap16,
            VxSkeleton(
              height: 50.h,
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            gap16,
            VxSkeleton(
              height: 50.h,
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            gap16,
            Row(
              children: [
                VxSkeleton(
                  height: 50.h,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ).flexible(),
                gap16,
                VxSkeleton(
                  height: 50.h,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ).flexible(),
              ],
            ),
            gap16,
            Row(
              children: [
                VxSkeleton(
                  height: 50.h,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ).flexible(),
                gap16,
                VxSkeleton(
                  height: 50.h,
                  width: .2.sw,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ],
            ),
            gap16,
            Row(
              children: [
                VxSkeleton(
                  height: 50.h,
                  width: .2.sw,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                gap16,
                VxSkeleton(
                  height: 50.h,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ).flexible(),
              ],
            ),
            gap16,
            VxSkeleton(
              height: 50.h,
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            gap16,
            VxSkeleton(
              height: 50.h,
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ],
        ),
      ),
    );
  }
}
