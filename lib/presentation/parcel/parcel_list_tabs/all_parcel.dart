import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../application/parcel/parcel_provider.dart';
import '../../../utils/utils.dart';
import '../../widgets/parcel_shimmer.dart';
import '../../widgets/widgets.dart';

class AllParcel extends HookConsumerWidget {
  const AllParcel({
    super.key,
    required this.listType,
  });

  final ParcelRegularStatus listType;

  @override
  Widget build(BuildContext context, ref) {
    return RefreshIndicator(
      onRefresh: () =>
          ref.refresh(fetchAllTypeParcelProvider(type: listType).future),
      child: ListView.custom(
        padding: padding16,
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) {
            const pageSize = 10;

            final page = index ~/ pageSize + 1;
            final indexInPage = index % pageSize;
            final parcelResponse = ref.watch(
              fetchAllTypeParcelProvider(
                type: listType,
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
