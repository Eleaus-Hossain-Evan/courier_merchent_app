import 'package:courier_merchent_app/application/parcel/parcel_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';
import '../widgets/parcel_shimmer.dart';
import '../widgets/widgets.dart';

class ParcelFilterScreen extends HookConsumerWidget {
  static const route = '/parcel-filter';

  const ParcelFilterScreen({
    super.key,
    this.serialId = '',
    this.customerPhone = '',
    this.startTime = '',
    this.endTime = '',
  });

  final String serialId;
  final String customerPhone;
  final String startTime;
  final String endTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = serialId.isNotBlank
        ? 'Serial ID'
        : serialId.isNotBlank
            ? 'Customer Phone'
            : 'Date';
    return Scaffold(
      appBar: KAppBar(titleText: "Parcel by $title"),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(fetchAllTypeParcelProvider(
          serialId: serialId,
          customerPhone: customerPhone,
          startTime: startTime,
          endTime: endTime,
        ).future),
        child: ListView.custom(
          padding: padding16,
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
              const pageSize = 10;

              final page = index ~/ pageSize + 1;
              final indexInPage = index % pageSize;
              final parcelResponse = ref.watch(
                fetchAllTypeParcelProvider(
                  page: page,
                  serialId: serialId,
                  customerPhone: customerPhone,
                  startTime: startTime,
                  endTime: endTime,
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
                  Logger.json(stack as String?);
                  return Text('Error $err');
                },
                loading: () => const RecentParcelShimmerWidget(length: 1),
              );
            },
          ),
        ),
      ),
    );
  }
}
