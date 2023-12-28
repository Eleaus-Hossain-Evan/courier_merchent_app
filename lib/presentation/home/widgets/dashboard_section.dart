import 'dart:convert';

import 'package:courier_merchent_app/application/home/home_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';

class DashboardSection extends HookConsumerWidget {
  const DashboardSection({
    super.key,
    required this.isDashboard,
    required this.isDashboardVisible,
  });

  final ValueNotifier<bool> isDashboard;
  final ValueNotifier<bool> isDashboardVisible;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(dashboardProvider());

    final tabController = useTabController(initialLength: 2);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isDashboard.value ? 355 : 0,
      // onEnd: () => isDashboardVisible.value = true,
      margin: isDashboard.value ? paddingTop16 : padding0,
      // padding: padding16,
      width: 1.sw,
      decoration: BoxDecoration(
        // color: ColorPalate.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: state.when(
        data: (data) {
          final allOrderList = [
            DashboardItemModel(
              data: data.parcelList.tPending,
              title: "Pending",
              img: Images.iconParcelPending,
            ),
            DashboardItemModel(
              data: data.parcelList.tDropoff,
              title: "Dropoff",
              img: Images.iconParcelDropoff,
            ),
            DashboardItemModel(
              data: data.parcelList.tReturnEnd,
              title: "Return",
              img: Images.iconParcelReturnEnd,
            ),
            DashboardItemModel(
              data: data.parcelList.tShipping,
              title: "Shipping",
              img: Images.iconParcelShipping,
            ),
            DashboardItemModel(
              data: data.parcelList.tCancel,
              title: "Cancel",
              img: Images.iconParcelCancel,
            ),
            DashboardItemModel(
              data: data.parcelList.tParcel,
              title: "Total",
              img: Images.iconParcelTotal,
            ),
          ];
          final paymentSummeryList = [
            DashboardItemModel(
              data: data.parcelPay.tPayCollection,
              title: "Total sales",
              img: Images.iconPayCollection,
            ),
            DashboardItemModel(
              data: data.parcelPay.tPayDeliveryCharge,
              title: "Total delivery fees paid",
              img: Images.iconParcelDeliveryFeesPaid,
            ),
            DashboardItemModel(
              data: data.parcelPay.tPayProcessing,
              title: "Payment Processing",
              img: Images.iconPayProcessing,
            ),
            DashboardItemModel(
              data: data.parcelPay.tPayWithdraw.toInt(),
              title: "Withdraw",
              img: Images.iconPayWithDraw,
            ),
            DashboardItemModel(
              data: data.parcelPay.tPayPending,
              title: "Pending Cash",
              img: Images.iconPayPending,
            ),
          ];

          return Visibility(
            visible: isDashboardVisible.value,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: CloseButton(
                    onPressed: () => isDashboard.value = false,
                  ),
                ),
                Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    "Dashboard"
                        .text
                        .xl
                        .extraBold
                        .make()
                        .pOnly(left: 16, top: 16),
                    TabBar(
                      tabs: const [
                        Tab(
                          text: "All Orders",
                        ),
                        Tab(
                          text: "Payment Summary",
                        ),
                      ],
                      controller: tabController,
                      isScrollable: true,
                    ),
                    gap16,
                    TabBarView(
                      controller: tabController,
                      children: [
                        DashboardTabView(itemList: allOrderList),
                        DashboardTabView(itemList: paymentSummeryList),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

class DashboardTabView extends StatelessWidget {
  const DashboardTabView({
    super.key,
    required this.itemList,
  });

  final List<DashboardItemModel> itemList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return DashboardItem(
          data: itemList[index].data,
          title: itemList[index].title,
          img: itemList[index].img,
        );
      },
      itemCount: itemList.length,
    );
  }
}

class DashboardItem extends StatelessWidget {
  const DashboardItem({
    Key? key,
    required this.data,
    required this.title,
    required this.img,
  }) : super(key: key);

  final int data;
  final String title;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossCenter,
      mainAxisAlignment: mainCenter,
      mainAxisSize: mainMin,
      children: [
        img.assetImage(
          // height: 50,
          width: 40,
        ),
        gap8,
        Column(
          // crossAxisAlignment: crossStart,
          children: [
            FittedBox(child: Text(title)),
            data.text.xl2.bold.make(),
          ],
        ),
      ],
    )
        .pSymmetric(h: 12, v: 6)
        .box
        .roundedSM
        .shadowSm
        .color(ColorPalate.bg100)
        .make();
  }
}

class DashboardItemModel extends Equatable {
  final int data;
  final String title;
  final String img;

  const DashboardItemModel({
    required this.data,
    required this.title,
    required this.img,
  });

  DashboardItemModel copyWith({
    int? data,
    String? title,
    String? img,
  }) {
    return DashboardItemModel(
      data: data ?? this.data,
      title: title ?? this.title,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'title': title,
      'img': img,
    };
  }

  factory DashboardItemModel.fromMap(Map<String, dynamic> map) {
    return DashboardItemModel(
      data: map['data']?.toInt() ?? 0,
      title: map['title'] ?? '',
      img: map['img'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardItemModel.fromJson(String source) =>
      DashboardItemModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'DashboardItemModel(data: $data, title: $title, img: $img)';

  @override
  List<Object> get props => [data, title, img];
}
