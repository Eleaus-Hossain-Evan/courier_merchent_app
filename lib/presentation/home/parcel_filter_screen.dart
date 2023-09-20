import 'dart:developer';

import 'package:courier_merchent_app/application/parcel/parcel_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';
import '../widgets/parcel_shimmer.dart';
import '../widgets/widgets.dart';
import 'widgets/search_delivery.dart';

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
    final isSerialId = useState(serialId.isNotBlank);
    final isPhone = useState(customerPhone.isNotBlank);
    final isTime = useState(startTime.isNotBlank);
    final isExpanded = useState(false);
    final title = serialId.isNotBlank
        ? 'Serial ID'
        : serialId.isNotBlank
            ? 'Customer Phone'
            : 'Date';

    final animController = useAnimationController(duration: 300.milliseconds);
    final anim =
        useAnimation(Tween<double>(begin: 36, end: 92).animate(animController));

    isExpanded.addListener(() {
      if (isExpanded.value) {
        animController.forward();
      } else {
        animController.reverse();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: "Parcel by $title".text.make(),
      ),
      body: Column(
        children: [
          Row(
            children: [
              gap28,
              AnimatedCrossFade(
                crossFadeState: isExpanded.value
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: 300.milliseconds,
                firstChild: ColoredBox(
                  color: Colors.blueGrey.shade500,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50.h,
                        child: KFilledButton(
                          isSecondary: isSerialId.value,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const SearchParcelWidget(),
                            );
                          },
                          text: '',
                          // size: Size(60, 50.h),
                          padding: padding0,
                          backgroundColor: ColorPalate.primary.lighten(),
                          child: const Icon(
                            IonIcons.id_card_sharp,
                            color: ColorPalate.bg200,
                          ),
                        ),
                      ).flexible(),
                      gap16,
                      SizedBox(
                        height: 50.h,
                        child: KFilledButton(
                          isSecondary: isPhone.value,
                          onPressed: () => showDateRangePicker(
                            context: context,
                            lastDate: DateTime.now(),
                            firstDate: DateTime(2019),
                          ).then((picked) {
                            if (picked == null) return;
                            log(picked.toString());
                          }),
                          text: '',
                          // size: Size(60, 50.h),
                          padding: padding0,
                          backgroundColor: ColorPalate.primary.lighten(),
                          child: const Icon(
                            Bootstrap.calendar2_check,
                            color: ColorPalate.bg200,
                          ),
                        ),
                      ).flexible(),
                    ],
                  ),
                ),
                secondChild: "Add More Filter".text.make(),
              ).expand(),
              IconButton(
                onPressed: () {
                  isExpanded.value = !isExpanded.value;
                },
                icon: const Icon(BoxIcons.bxs_down_arrow_circle).iconColor(
                    isExpanded.value
                        ? context.colors.secondary
                        : context.colors.primary),
              ),
            ],
          ).box.fuchsia300.height(anim).make(),
          Expanded(
            child: RefreshIndicator(
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
          ),
        ],
      ),
    );
  }
}
