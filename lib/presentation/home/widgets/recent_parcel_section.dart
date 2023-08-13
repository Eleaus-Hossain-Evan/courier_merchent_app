import 'package:courier_merchent_app/application/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

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

        return DeliveryListTile(parcel: parcel);
      },
      itemCount: state.parcelList.length,
      separator: KDivider(
        color: ColorPalate.bg200,
        thickness: 2.2.h,
      ),
    ).box.white.roundedSM.make();
  }
}
