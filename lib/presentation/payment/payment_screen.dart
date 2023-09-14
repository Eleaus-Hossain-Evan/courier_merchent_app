import 'package:courier_merchent_app/application/payment/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';
import '../widgets/widgets.dart';

class PaymentScreen extends HookConsumerWidget {
  static const route = '/payment';

  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = useState(1);
    final totalPage = useState(0);
    final count = useState(0);

    final refreshController = useMemoized(() => RefreshController());
    return Container(
      color: ColorPalate.bg100,
      height: 1.sh,
      width: 1.sw,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: AppStrings.payment.text.bold.white.xl.make(),
            backgroundColor: context.colors.primary,
            floating: true,
            pinned: true,
          ),
          SliverPersistentHeader(
            delegate: TotalDeliverySection(
              totalDelivery: count.value,
            ),
          ),
          SliverGap(16.h),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                const pageSize = 10;

                final page = index ~/ pageSize + 1;
                final indexInPage = index % pageSize;
                final parcelResponse = ref.watch(
                  getPendingPaymentListProvider(
                    page: page,
                  ),
                );
                return parcelResponse.when(
                  data: (data) {
                    if (indexInPage >= data.data.length) return null;

                    final parcel = data.data[indexInPage];
                    return Column(
                      children: [
                        DeliveryListTile(parcel: parcel),
                        KDivider(
                          color: ColorPalate.bg200,
                          thickness: 2.2.h,
                        )
                      ],
                    );
                  },
                  error: (err, stack) {
                    Logger.e(err);
                    return Text('Error $err');
                  },
                  loading: () => const CircularProgressIndicator(),
                );
              },
            ),
          ),
          // SliverFillRemaining(
          //   child: ListView.custom(
          //     childrenDelegate: SliverChildBuilderDelegate(
          //       (context, index) => null,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class TotalDeliverySection extends SliverPersistentHeaderDelegate {
  final int totalDelivery;

  TotalDeliverySection({required this.totalDelivery});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
