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
  const SearchDelivery({
    super.key,
    this.onTapDashboard,
    required this.isDashboard,
  });

  final VoidCallback? onTapDashboard;
  final ValueNotifier<bool> isDashboard;

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        Row(
          children: [
            "Track your package".text.xl.extraBold.make(),
            gap6,
            Images.iconDelivery
                .assetSvg(
                  width: 24.w,
                  height: 24.h,
                )
                .objectBottomLeft()
                .expand(),
            Tooltip(
              message: "Dashboard",
              child: KOutlinedButton(
                onPressed: onTapDashboard,
                foregroundColor: isDashboard.value
                    ? ColorPalate.bg200
                    : context.colors.primary,
                backgroundColor: isDashboard.value
                    ? context.colors.primary.withOpacity(.5)
                    : null,
                padding: padding0,
                borderColor: context.colors.primary,
                borderRadius: BorderRadius.circular(18.r),
                size: const Size(44, 34),
                isSecondary: false,
                child: Icon(
                  BoxIcons.bxs_dashboard,
                  size: 18.sp,
                ),
              ),
            ),
          ],
        ),
        gap12,
        "Please enter appropriate property from tracing parcel"
            .text
            .labelSmall(context)
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
                    builder: (context) =>
                        const SearchParcelWidget(searchBy: SearchBy.bySerialId),
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
                    builder: (context) =>
                        const SearchParcelWidget(searchBy: SearchBy.byPhone),
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
    this.initialText,
    required this.searchBy,
    this.onTapSearch,
  });

  final String? initialText;
  final SearchBy searchBy;
  final Function(String)? onTapSearch;

  @override
  Widget build(BuildContext context, ref) {
    final searchTextController = useTextEditingController(text: initialText);

    return Dialog(
      backgroundColor: Colors.white,
      // title: const Text("Search Parcel"),
      child: Padding(
        padding: padding16,
        child: Column(
          mainAxisSize: mainMin,
          children: [
            Text(
              "Search Parcel ${searchBy.name.toTitleCaseFromCamel()}",
              style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            gap10,
            KTextFormField2(
              containerPadding: padding0,
              controller: searchTextController,
              autofocus: true,
              suffixIcon: CloseButton(
                onPressed: () => searchTextController.clear(),
              ),
            ),
            gap16,
            KFilledButton(
              onPressed: () {
                Navigator.pop(context);
                if (onTapSearch != null) {
                  onTapSearch?.call(searchTextController.text);
                } else {
                  context.push(
                      "${ParcelFilterScreen.route}?${searchBy == SearchBy.bySerialId ? "serialId" : "customerPhone"}=${searchTextController.text}");
                }
              },
              text: "Search",
            ),
          ],
        ),
      ),
    );
  }
}
