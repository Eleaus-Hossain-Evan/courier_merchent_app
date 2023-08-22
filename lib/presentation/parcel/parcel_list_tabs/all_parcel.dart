import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../application/parcel/parcel_provider.dart';
import '../../../domain/parcel/model/parcel_model.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class AllParcel extends HookConsumerWidget {
  const AllParcel({
    super.key,
    required this.listType,
  });

  final ParcelRegularStatus listType;

  @override
  Widget build(BuildContext context, ref) {
    final loading = useState(false);
    final state = ref.watch(parcelProvider);

    ref.listen(parcelProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
        loading.value = true;
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
        loading.value = false;
      }
    });

    useEffect(() {
      Future.microtask(() => ref
          .read(parcelProvider.notifier)
          .fetchCategorizedParcel(type: listType));
      return () => BotToast.closeAllLoading();
    }, const []);

    return KListViewSeparated(
      gap: 16,
      padding: padding0,
      alternateWidget: "No order placed yet!"
          .text
          .caption(context)
          .make()
          .objectCenter()
          .box
          .height(1.sh)
          .make(),
      itemBuilder: (context, index) {
        final parcel = listType == ParcelRegularStatus.all
            ? state.allParcel[index]
            : listType == ParcelRegularStatus.pending
                ? state.pendingParcel[index]
                : listType == ParcelRegularStatus.pickup
                    ? state.pickupParcel[index]
                    : listType == ParcelRegularStatus.shipping
                        ? state.shippingParcel[index]
                        : listType == ParcelRegularStatus.shipped
                            ? state.shippedParcel[index]
                            : listType == ParcelRegularStatus.dropoff
                                ? state.dropoffParcel[index]
                                : listType == ParcelRegularStatus.returns
                                    ? state.returnParcel[index]
                                    : listType == ParcelRegularStatus.cancel
                                        ? state.cancelParcel[index]
                                        : state.allParcel[index];

        return DeliveryListTile(parcel: parcel);
      },
      itemCount: listType == ParcelRegularStatus.all
          ? state.allParcel.length
          : listType == ParcelRegularStatus.pending
              ? state.pendingParcel.length
              : listType == ParcelRegularStatus.pickup
                  ? state.pickupParcel.length
                  : listType == ParcelRegularStatus.shipping
                      ? state.shippingParcel.length
                      : listType == ParcelRegularStatus.shipped
                          ? state.shippedParcel.length
                          : listType == ParcelRegularStatus.dropoff
                              ? state.dropoffParcel.length
                              : listType == ParcelRegularStatus.returns
                                  ? state.returnParcel.length
                                  : listType == ParcelRegularStatus.cancel
                                      ? state.cancelParcel.length
                                      : state.allParcel.length,
      separator: KDivider(
        color: ColorPalate.bg200,
        thickness: 2.2.h,
      ),
    ).box.white.roundedSM.make().p16();
  }
}
