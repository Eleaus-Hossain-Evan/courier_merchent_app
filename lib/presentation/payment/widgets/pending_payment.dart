import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../application/payment/payment_provider.dart';
import '../../../utils/utils.dart';
import '../../widgets/parcel_shimmer.dart';
import '../../widgets/widgets.dart';

class PendingPayment extends HookConsumerWidget {
  const PendingPayment({
    super.key,
    required this.count,
  });

  final ValueNotifier<int> count;

  @override
  Widget build(BuildContext context, ref) {
    return RefreshIndicator(
      onRefresh: () => ref.refresh(getPendingPaymentListProvider().future),
      child: ListView.custom(
        childrenDelegate: SliverChildBuilderDelegate(
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
              loading: () => const RecentParcelShimmerWidget(length: 1),
            );
          },
        ),
      ),
    );
  }
}
