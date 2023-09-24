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
    final loading = useState(false);

    final serialVal = useState(serialId);
    final phoneVal = useState(customerPhone);
    final startTimeVal = useState(startTime);
    final endTimeVal = useState(endTime);

    final isSerialId = useState(serialVal.value.isNotBlank);
    final isPhone = useState(phoneVal.value.isNotBlank);
    final isTime =
        useState(startTimeVal.value.isNotBlank && endTimeVal.value.isNotBlank);

    return Scaffold(
      appBar: const KAppBar(
        titleText: "Search Result",
        // titleTextStyle: TextStyle(color: ColorPalate.black),
      ),
      body: Column(
        children: [
          SearchFilterWidget(
            isSerialId: isSerialId,
            serialVal: serialVal,
            phoneVal: phoneVal,
            startTimeVal: startTimeVal,
            endTimeVal: endTimeVal,
            isPhone: isPhone,
            isTime: isTime,
          ),
          // serialVal.toString().text.make(),
          // phoneVal.toString().text.make(),
          // isSerialId.toString().text.make(),
          // isPhone.toString().text.make(),
          const LinearProgressIndicator().hide(
              isVisible: ref
                  .watch(
                    fetchAllTypeParcelProvider(
                      serialId: serialVal.value,
                      customerPhone: phoneVal.value,
                      startTime: startTimeVal.value,
                      endTime: endTimeVal.value,
                    ),
                  )
                  .isLoading),
          Expanded(
            child: ColoredBox(
              color: ColorPalate.bg100,
              child: RefreshIndicator(
                onRefresh: () => ref.refresh(fetchAllTypeParcelProvider(
                  serialId: serialVal.value,
                  customerPhone: phoneVal.value,
                  startTime: startTimeVal.value,
                  endTime: endTimeVal.value,
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
                          serialId: serialVal.value,
                          customerPhone: phoneVal.value,
                          startTime: startTimeVal.value,
                          endTime: endTimeVal.value,
                        ),
                      );

                      loading.value = !parcelResponse.isLoading;

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
                        loading: () =>
                            const RecentParcelShimmerWidget(length: 1),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchFilterWidget extends HookConsumerWidget {
  const SearchFilterWidget({
    super.key,
    required this.isSerialId,
    required this.serialVal,
    required this.phoneVal,
    required this.startTimeVal,
    required this.endTimeVal,
    required this.isPhone,
    required this.isTime,
  });

  final ValueNotifier<bool> isSerialId;
  final ValueNotifier<String> serialVal;
  final ValueNotifier<String> phoneVal;
  final ValueNotifier<String> startTimeVal;
  final ValueNotifier<String> endTimeVal;
  final ValueNotifier<bool> isPhone;
  final ValueNotifier<bool> isTime;

  @override
  Widget build(BuildContext context, ref) {
    final isExpanded = useState(false);

    final animController = useAnimationController(duration: 300.milliseconds);
    final anim =
        useAnimation(Tween<double>(begin: 42, end: 92).animate(animController));

    isExpanded.addListener(() {
      if (isExpanded.value) {
        animController.forward();
      } else {
        animController.reverse();
      }
    });

    serialVal.addListener(() {
      isSerialId.value = serialVal.value.isNotBlank;
    });
    phoneVal.addListener(() {
      isPhone.value = phoneVal.value.isNotBlank;
    });
    startTimeVal.addListener(() {
      isTime.value = startTimeVal.value.isNotBlank;
    });

    return Row(
      children: [
        gap24,
        AnimatedCrossFade(
          crossFadeState: isExpanded.value
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: 300.milliseconds,
          firstChild: Row(
            children: [
              KFilledButton(
                isSecondary: isSerialId.value,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => SearchParcelWidget(
                      searchBy: SearchBy.bySerialId,
                      initialText: serialVal.value,
                      onTapSearch: (text) {
                        serialVal.value = text;
                        ref
                            .refresh(fetchAllTypeParcelProvider(
                          serialId: serialVal.value,
                          customerPhone: phoneVal.value,
                          startTime: startTimeVal.value,
                          endTime: endTimeVal.value,
                        ).future)
                            .then((_) {
                          isExpanded.value = false;
                        });
                      },
                    ),
                  );
                },
                text: '',
                // size: Size(60, 50.h),
                padding: padding0,
                backgroundColor: ColorPalate.primary.lighten(),
                child: "ID".text.white.make(),
              ).flexible(),
              gap28,
              KFilledButton(
                isSecondary: isPhone.value,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => SearchParcelWidget(
                      searchBy: SearchBy.byPhone,
                      initialText: phoneVal.value,
                      onTapSearch: (text) {
                        phoneVal.value = text;
                        ref
                            .refresh(fetchAllTypeParcelProvider(
                          serialId: serialVal.value,
                          customerPhone: phoneVal.value,
                          startTime: startTimeVal.value,
                          endTime: endTimeVal.value,
                        ).future)
                            .then((_) {
                          isExpanded.value = false;
                        });
                      },
                    ),
                  );
                },
                text: '',
                // size: Size(60, 50.h),
                padding: padding0,
                backgroundColor: ColorPalate.primary.lighten(),
                child: Images.iconCallDropped.assetSvg(
                  width: 24.w,
                  height: 24.h,
                  color: Colors.white,
                ),
              ).flexible(),
              gap28,
              KFilledButton(
                isSecondary: isTime.value,
                onPressed: () => showDateRangePicker(
                  context: context,
                  saveText: "Search",
                  initialDateRange: DateTimeRange(
                    start: startTimeVal.value.toDate() ?? DateTime.now(),
                    end: endTimeVal.value.toDate() ?? DateTime.now(),
                  ),
                  lastDate: DateTime.now(),
                  firstDate: DateTime(2019),
                ).then((picked) {
                  if (picked == null) return;
                  log(picked.toString());
                  startTimeVal.value = picked.start.toIso8601String();
                  endTimeVal.value = picked.end.toIso8601String();
                  ref
                      .refresh(fetchAllTypeParcelProvider(
                    serialId: serialVal.value,
                    customerPhone: phoneVal.value,
                    startTime: startTimeVal.value,
                    endTime: endTimeVal.value,
                  ).future)
                      .then((_) {
                    isExpanded.value = false;
                  });
                }),
                text: '',
                // size: Size(60, 50.h),
                padding: padding0,
                backgroundColor: ColorPalate.primary.lighten(),
                child: const Icon(
                  Bootstrap.calendar2_check,
                  color: ColorPalate.bg200,
                ),
              ).flexible(),
            ],
          ),
          secondChild: Row(
            children: [
              "ID"
                  .text
                  .xs
                  .white
                  .bold
                  .makeCentered()
                  .circle(
                    radius: 22,
                    backgroundColor: context.colors.primary,
                  )
                  .px4()
                  .hide(isVisible: serialVal.value.isNotBlank),
              Images.iconCallDropped
                  .assetSvg(
                    width: 8.w,
                    height: 8.h,
                    color: Colors.white,
                  )
                  .p4()
                  .circle(
                    radius: 22,
                    backgroundColor: context.colors.primary,
                  )
                  .px4()
                  .hide(isVisible: isPhone.value),
              const Icon(
                Bootstrap.calendar2_check,
                color: ColorPalate.bg200,
                size: 14,
              )
                  .circle(
                    radius: 22,
                    backgroundColor: context.colors.primary,
                  )
                  .px4()
                  .hide(isVisible: isTime.value),
              gap8,
              "Add More Filter".text.make(),
            ],
          ),
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
    )
        .pOnly(bottom: 6.h)
        .box
        .height(anim)
        .withDecoration(const BoxDecoration(
          border: Border(bottom: BorderSide(color: ColorPalate.bg300)),
        ))
        .make();
  }
}
