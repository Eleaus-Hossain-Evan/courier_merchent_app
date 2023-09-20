import 'package:courier_merchent_app/presentation/home/parcel_filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class SearchDelivery extends HookConsumerWidget {
  const SearchDelivery({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        Row(
          children: [
            "Track your package".text.xl.extraBold.make(),
            gap6,
            Images.iconDelivery.assetSvg(
              width: 24.w,
              height: 24.h,
            )
          ],
        ),
        gap12,
        "Please enter appropriate property from tracing parcel"
            .text
            .caption(context)
            .make(),
        gap14,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
              child: KFilledButton(
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
                child: "ID".text.white.make(),
              ),
            ).flexible(),
            gap16,
            SizedBox(
              height: 50.h,
              child: KFilledButton(
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
                child: Images.iconCallDropped.assetSvg(
                  width: 24.w,
                  height: 24.h,
                  color: Colors.white,
                ),
              ),
            ).flexible(),
            gap16,
            SizedBox(
              height: 50.h,
              child: KFilledButton(
                onPressed: () => showDateRangePicker(
                  context: context,
                  lastDate: DateTime.now(),
                  firstDate: DateTime(2019),
                ).then((picked) {
                  if (picked == null) return;
                  context.push(
                      "${ParcelFilterScreen.route}?startTime=${picked.start}&&endTime=${picked.end}");
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
            gap16,
            SizedBox(
              height: 50.h,
              child: KFilledButton(
                onPressed: () {},
                text: '',
                // size: Size(60, 50.h),
                padding: padding0,
                backgroundColor: ColorPalate.primary.lighten(),
                child: Images.iconObjectScan.assetSvg(
                  width: 24.w,
                  height: 24.h,
                  color: Colors.white,
                ),
              ),
            ).flexible(),
          ],
        ),
      ],
    ).p16().box.rounded.color(context.colors.primary.withOpacity(.1)).make();
  }
}

class SearchParcelWidget extends HookConsumerWidget {
  const SearchParcelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final searchTextController = useTextEditingController();

    final groupValue = useState(SearchBy.bySerialId);

    return Dialog(
      backgroundColor: Colors.white,
      // title: const Text("Search Parcel"),
      child: Padding(
        padding: padding16,
        child: Column(
          mainAxisSize: mainMin,
          children: [
            Text(
              "Search Parcel",
              style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                ...SearchBy.values.mapIndexed(
                  (currentValue, index) => Row(
                    children: [
                      Radio.adaptive(
                        value: currentValue,
                        groupValue: groupValue.value,
                        onChanged: (value) {
                          groupValue.value = value!;
                        },
                      ),
                      currentValue.name.toWordTitleCase().text.make().onTap(() {
                        groupValue.value = currentValue;
                      }),
                    ],
                  ).flexible(),
                ),
              ],
            ),
            KTextFormField2(
              containerPadding: padding0,
              controller: searchTextController,
            ),
            gap16,
            KFilledButton(
              onPressed: () {
                Navigator.pop(context);
                context.push(
                    "${ParcelFilterScreen.route}?${groupValue.value == SearchBy.bySerialId ? "serialId" : "customerPhone"}=${searchTextController.text}");
              },
              text: "Search",
            ),
          ],
        ),
      ),
    );
  }
}
