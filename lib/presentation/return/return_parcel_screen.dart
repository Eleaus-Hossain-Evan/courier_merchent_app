import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';
import '../parcel/parcel_list_tabs/all_parcel.dart';
import '../widgets/widgets.dart';

class ReturnParcelScreen extends HookConsumerWidget {
  static const route = '/return-parcel';

  const ReturnParcelScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final normalTabs = [
      ParcelRegularStatus.returns,
      ParcelRegularStatus.returnEnd,
    ];
    final tabController = useTabController(initialLength: normalTabs.length);

    Logger.w(normalTabs);
    return Scaffold(
      backgroundColor: ColorPalate.bg100,
      appBar: KAppBar(
        titleText: 'Your Return Parcel List',
        titleTextStyle: const TextStyle(color: ColorPalate.white),
        backgroundColor: context.colors.primary,
        bottom: TabBar(
          padding: paddingH16,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
            letterSpacing: 1.2,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            letterSpacing: .9,
          ),
          unselectedLabelColor: ColorPalate.white,
          controller: tabController,
          // isScrollable: true,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(
              25.0,
            ),
            color: ColorPalate.white,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.symmetric(vertical: 4.w),
          tabs: normalTabs
              .map((e) => Tab(text: e.changedValue.toTitleCaseFromSnack()))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: normalTabs.map((e) => AllParcel(listType: e)).toList(),
      ),
    );
  }
}
