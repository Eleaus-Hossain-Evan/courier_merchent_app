import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../application/payment/payment_provider.dart';
import '../../utils/utils.dart';
import '../widgets/widgets.dart';
import 'widgets/history_payment.dart';
import 'widgets/pending_payment.dart';

class PaymentScreen extends HookConsumerWidget {
  static const route = '/payment';

  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController =
        useTabController(initialLength: PaymentTab.values.length);

    return Scaffold(
      appBar: KAppBar(
        title: AppStrings.payment.text.make(),
        foregroundColor: Colors.white,
        leading: const CloseButton(
          color: Colors.white,
        ),
        backgroundColor: context.colors.primary,
      ),
      body: ColoredBox(
        color: context.colors.primary,
        child: Column(
          children: [
            const TotalDeliverySection().px16(),
            gap16,
            // const PaymentDetail(),
            // gap16,
            TabBar(
              padding: paddingH16,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
                letterSpacing: 1.2,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
                letterSpacing: 1.2,
              ),
              unselectedLabelColor: ColorPalate.white,
              controller: tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: ColorPalate.white,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(vertical: 4.w),
              tabs: PaymentTab.values
                  .map((e) => Tab(
                        text: e.name.capitalized,
                      ))
                  .toList(),
            ),
            Expanded(
              child: ColoredBox(
                color: ColorPalate.bg200,
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    PendingPayment(),
                    HistoryPayment(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentDetail extends HookConsumerWidget {
  const PaymentDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(getPendingPaymentListProvider());
    return state.when(
      data: (data) {
        //        print('${data[index].toJson()}');

        return GridView.builder(
          padding: padding16,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / .4,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
          ),
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                color: ColorPalate.primary.lighten(),
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0.0, 3.0),
                    blurRadius: 1.0,
                    spreadRadius: -2.0,
                    color: ColorPalate.bg100.withOpacity(.1),
                  ),
                  BoxShadow(
                    offset: const Offset(0.0, 2.0),
                    blurRadius: 2.0,
                    color: ColorPalate.bg100.withOpacity(.2),
                  ),
                  BoxShadow(
                    offset: const Offset(0.0, 1.0),
                    blurRadius: 5.0,
                    color: ColorPalate.bg100.withOpacity(.2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: mainCenter,
                children: [
                  "Total Delivery Charge"
                      .text
                      .sm
                      .bold
                      .colorScaffoldBackground(context)
                      .makeCentered(),
                  gap8,
                  100
                      .text
                      .lg
                      .bold
                      .colorScaffoldBackground(context)
                      .makeCentered(),
                ],
              ),
            );
          },
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class TotalDeliverySection extends HookConsumerWidget {
  const TotalDeliverySection({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(getPendingPaymentListProvider());
    return Row(
      mainAxisAlignment: mainSpaceBetween,
      children: [
        "Total Pending Parcel".text.semiBold.white.make(),
        gap8,
        state.when(
          data: (data) =>
              data.paymentDetails.totalParcel.text.white.bold.make(),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(.2),
            highlightColor: Colors.grey.shade100,
            child: KSkeletonWidget(
              width: 20.w,
              height: 20.h,
            ),
          ),
        ),
      ],
    )
        .pSymmetric(h: 18, v: 10)
        .box
        .color(context.colors.primaryContainer.lighten())
        .roundedLg
        .makeCentered()
        .box
        .color(context.colors.primary)
        .make();
  }
}
