import 'package:courier_merchent_app/presentation/parcel/parcel_list_tabs/all_parcel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';
import '../widgets/widgets.dart';

enum ParcelListType {
  all('all'),
  pending('pending'),
  pickup('pickup'),
  shipping('shipping'),
  shipped('shipped'),
  dropoff('dropoff'),
  returns("return"),
  cancel('cancel');

  final String value;
  const ParcelListType(this.value);
}

class ParcelListScreen extends HookConsumerWidget {
  static const route = '/parcel-list';

  const ParcelListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController =
        useTabController(initialLength: ParcelListType.values.length);
    return Scaffold(
      appBar: KAppBar(
        titleText: 'Your Parcel List',
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
          isScrollable: true,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(
              25.0,
            ),
            color: ColorPalate.white,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.symmetric(vertical: 4.w),
          tabs: ParcelListType.values
              .map((e) => Tab(
                    text: e.value.capitalized,
                  ))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children:
            ParcelListType.values.map((e) => AllParcel(listType: e)).toList(),
      ),
    );
  }
}
