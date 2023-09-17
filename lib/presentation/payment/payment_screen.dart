import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';
import '../widgets/widgets.dart';
import 'widgets/history_payment.dart';
import 'widgets/pending_payment.dart';

class PaymentScreen extends HookConsumerWidget {
  static const route = '/payment';

  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = useState(1);
    final totalPage = useState(0);
    final count = useState(0);

    final tabController =
        useTabController(initialLength: PaymentTab.values.length);

    return Scaffold(
      appBar: KAppBar(
        titleText: AppStrings.payment,
        backgroundColor: context.colors.primary,
        titleTextStyle: const TextStyle(color: Colors.white),
      ),
      body: ColoredBox(
        color: context.colors.primary,
        child: Column(
          children: [
            TotalDeliverySection(
              totalDelivery: count.value,
            ),
            gap16,
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
                  children: [
                    PendingPayment(count: count),
                    HistoryPayment(count: count),
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

class TotalDeliverySection extends StatelessWidget {
  final int totalDelivery;

  const TotalDeliverySection({super.key, required this.totalDelivery});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainSpaceBetween,
      children: [
        "Total Pending Payment".text.semiBold.white.make(),
        totalDelivery.text.white.bold.make(),
      ],
    )
        .pSymmetric(h: 18, v: 10)
        .box
        .width(.85.sw)
        .color(context.colors.primaryContainer.lighten())
        .roundedLg
        .makeCentered()
        .box
        .color(context.colors.primary)
        .make();
  }
}
