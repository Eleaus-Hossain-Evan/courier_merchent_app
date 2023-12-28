import 'package:courier_merchent_app/application/parcel/parcel_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';
import '../../widgets/parcel_shimmer.dart';
import '../../widgets/widgets.dart';

class RecentParcelSection extends HookConsumerWidget {
  const RecentParcelSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(recentParcelProvider);

    return state.when(
      data: (data) => KListViewSeparated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gap: 16,
        padding: padding0,
        itemBuilder: (context, index) {
          final parcel = data.data[index];

          return DeliveryListTile(parcel: parcel);
        },
        itemCount: data.data.length,
        separator: KDivider(
          color: ColorPalate.bg200,
          thickness: 2.2.h,
        ),
      ).box.white.roundedSM.make(),
      // data: (data) => const RecentParcelShimmerWidget(),
      error: (error, stackTrace) => error.toString().text.make(),
      // loading: () => const CircularProgressIndicator.adaptive(),
      loading: () =>
          RecentParcelShimmerWidget(length: state.value?.data.length),
    );

    // return GroupedListView<ParcelModel, String>(
    //   elements: state.parcelList.unlock,
    //   groupBy: (element) => element.merchantId,
    //   groupSeparatorBuilder: (String groupByValue) => Text(groupByValue),
    //   itemBuilder: (context, element) => DeliveryListTile(parcel: element),
    //   itemComparator: (item1, item2) =>
    //       item1.id.compareTo(item2.id), // optional
    //   // useStickyGroupSeparators: true, // optional
    //   // floatingHeader: true, // optional
    //   // order: GroupedListOrder.ASC, // optional

    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    // );
  }
}
