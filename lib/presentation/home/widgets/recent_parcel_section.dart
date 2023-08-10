import 'package:courier_merchent_app/application/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class RecentParcelSection extends HookConsumerWidget {
  const RecentParcelSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(homeProvider);

    return KListViewSeparated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gap: 16,
      padding: padding0,
      itemBuilder: (context, index) {
        final parcel = state.parcelList[index];

        return DeliveryListTile(
          customerName: parcel.customerInfo.name,
          address: "169/B, North Konipara, Tejgoan, Dhaka, Bangladesh",
          price: parcel.regularPayment.cashCollection.toString(),
          serialId: parcel.serialId,
          status: parcel.regularStatus,
        );
      },
      itemCount: state.parcelList.length,
    );
  }
}
