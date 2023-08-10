import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../application/parcel/parcel_provider.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../parcel_list_screen.dart';

class AllParcel extends HookConsumerWidget {
  const AllParcel({
    super.key,
    required this.listType,
  });

  final ParcelListType listType;

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

    return Center(
      child: KListViewSeparated(
        gap: 16,
        padding: padding0,
        alternateWidget:
            "No order placed yet!".text.caption(context).make().objectCenter(),
        itemBuilder: (context, index) {
          final parcel = listType == ParcelListType.all
              ? state.allParcel[index]
              : listType == ParcelListType.pending
                  ? state.pendingParcel[index]
                  : listType == ParcelListType.pickup
                      ? state.pickupParcel[index]
                      : listType == ParcelListType.shipping
                          ? state.shippingParcel[index]
                          : listType == ParcelListType.shipped
                              ? state.shippedParcel[index]
                              : listType == ParcelListType.dropoff
                                  ? state.dropoffParcel[index]
                                  : listType == ParcelListType.returns
                                      ? state.returnParcel[index]
                                      : listType == ParcelListType.cancel
                                          ? state.cancelParcel[index]
                                          : state.allParcel[index];

          return DeliveryListTile(
            customerName: parcel.customerInfo.name,
            address: "169/B, North Konipara, Tejgoan, Dhaka, Bangladesh",
            price: parcel.regularPayment.cashCollection.toString(),
            serialId: parcel.serialId,
            status: parcel.regularStatus,
          );
        },
        itemCount: listType == ParcelListType.all
            ? state.allParcel.length
            : listType == ParcelListType.pending
                ? state.pendingParcel.length
                : listType == ParcelListType.pickup
                    ? state.pickupParcel.length
                    : listType == ParcelListType.shipping
                        ? state.shippingParcel.length
                        : listType == ParcelListType.shipped
                            ? state.shippedParcel.length
                            : listType == ParcelListType.dropoff
                                ? state.dropoffParcel.length
                                : listType == ParcelListType.returns
                                    ? state.returnParcel.length
                                    : listType == ParcelListType.cancel
                                        ? state.cancelParcel.length
                                        : state.allParcel.length,
      ),
    );
  }
}
