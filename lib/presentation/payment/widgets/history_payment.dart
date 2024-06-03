import 'package:courier_merchent_app/domain/payment/model/payment_history_model.dart';
import 'package:courier_merchent_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../application/payment/payment_provider.dart';
import '../../../utils/utils.dart';
import 'payment_history_detail.dart';

class HistoryPayment extends HookConsumerWidget {
  const HistoryPayment({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return RefreshIndicator(
      onRefresh: () => ref.refresh(getHistoryPaymentListProvider().future),
      child: ListView.custom(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) {
            const pageSize = 10;

            final page = index ~/ pageSize + 1;
            final indexInPage = index % pageSize;
            final parcelResponse = ref.watch(
              getHistoryPaymentListProvider(
                page: page,
              ),
            );
            return parcelResponse.when(
              data: (data) {
                if (indexInPage >= data.data.length) return null;

                final history = data.data[indexInPage];
                return PaymentHistoryListTile(history: history);
              },
              // data: (data) => const PaymentHistoryShimmer(),
              error: (err, stack) {
                Logger.e(err);
                return Text('Error $err');
              },
              loading: () => const PaymentHistoryShimmer(),
            );
          },
        ),
      ),
    );
  }
}

class PaymentHistoryListTile extends StatelessWidget {
  const PaymentHistoryListTile({
    super.key,
    required this.history,
  });

  final HistoryPaymentModel history;

  @override
  Widget build(BuildContext context) {
    return KInkWell(
      onTap: () {
        showAppModal(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => PaymentHistoryDetails(historyId: history.id),
        );
      },
      child: Column(
        mainAxisSize: mainMin,
        mainAxisAlignment: mainStart,
        crossAxisAlignment: crossStart,
        children: [
          Row(
            // mainAxisAlignment: mainEnd,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    "Serial. ID :  ".textSpan.bodySmall(context).make(),
                    history.serialId.textSpan
                        .letterSpacing(.8)
                        .bodySmall(context)
                        .color(ColorPalate.black500)
                        .semiBold
                        .make(),
                  ],
                ),
                textAlign: TextAlign.right,
              )
            ],
          ).px12().py4().box.colorPrimary(context, opacity: .2).make(),
          gap6,
          Row(
            crossAxisAlignment: crossStart,
            children: [
              // Images.deliveryBoxCheck.assetImage(
              //   height: 80.h,
              //   width: 80.w,
              // ),
              // gap16,
              Column(
                mainAxisAlignment: mainSpaceAround,
                crossAxisAlignment: crossStart,
                children: [
                  gap6,
                  Text.rich(
                    TextSpan(
                      children: [
                        "Total Cash Collection :  "
                            .textSpan
                            .bodySmall(context)
                            .make(),
                        history.totalCashCollection
                            .toString()
                            .textSpan
                            .bodySmall(context)
                            .letterSpacing(.8)
                            .color(ColorPalate.black500)
                            .semiBold
                            .make(),
                      ],
                    ),
                  ),
                  gap4,
                  Text.rich(
                    TextSpan(
                      children: [
                        "Total Delivery Charge :  "
                            .textSpan
                            .bodySmall(context)
                            .make(),
                        history.totalDeliverCharge
                            .toString()
                            .textSpan
                            .bodySmall(context)
                            .letterSpacing(.8)
                            .color(ColorPalate.black500)
                            .semiBold
                            .make(),
                      ],
                    ),
                  ),
                  gap4,
                  Text.rich(
                    TextSpan(
                      children: [
                        "Merchant Due :  ".textSpan.bodySmall(context).make(),
                        history.prevMerchantDue
                            .toString()
                            .textSpan
                            .bodySmall(context)
                            .letterSpacing(.8)
                            .color(ColorPalate.black500)
                            .semiBold
                            .make(),
                      ],
                    ),
                  ),
                ],
              ).expand(),
              Column(
                children: [
                  history.parcelIds.length
                      .toString()
                      .text
                      .xl4
                      .extraBold
                      .color(context.theme.primaryColorDark.withOpacity(.6))
                      .letterSpacing(.8)
                      .make(),
                  "Total Parcels"
                      .text
                      .labelSmall(context)
                      .xs
                      .colorPrimary(context)
                      .make(),
                ],
              ),
            ],
          ),
        ],
      ).pSymmetric(h: 16.w, v: 12.h),
    ).box.color(ColorPalate.bg100).shadowSm.roundedSM.make().pSymmetric(v: 8.h);
  }
}

class PaymentHistoryShimmer extends StatelessWidget {
  const PaymentHistoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          SizedBox(
            height: 96.h,
          )
        ],
      )
          .pSymmetric(h: 16.w, v: 8.h)
          .box
          .color(ColorPalate.bg100)
          .roundedSM
          .make()
          .pSymmetric(v: 8.h),
    );
  }
}
