import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_merchent_app/application/payment/payment_provider.dart';
import 'package:courier_merchent_app/utils/utils.dart';

import '../../widgets/widgets.dart';

class PaymentHistoryDetails extends HookConsumerWidget {
  const PaymentHistoryDetails({
    super.key,
    required this.historyId,
  });

  final String historyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(getSinglePaymentHistoryProvider(historyId: historyId));
    return state.when(
      data: (data) => Container(
        color: Colors.white,
        margin: paddingTop30,
        padding: paddingH16,
        child: SafeArea(
          child: Column(
            mainAxisSize: mainMin,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: mainSpaceBetween,
                children: [
                  SizedBox(width: 45.w),
                  const Text(
                    "Payment History Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const CloseButton(),
                ],
              ),
              const Divider(
                color: ColorPalate.black600,
                thickness: 1.2,
              ),
              gap4,
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: mainEnd,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                "Serial. ID :  "
                                    .textSpan
                                    //caption(context)
                                    .bodySmall(context)
                                    .make(),
                                data.data.serialId.textSpan
                                    .bodySmall(context)
                                    .letterSpacing(.8)
                                    .color(ColorPalate.black500)
                                    .semiBold
                                    .make(),
                              ],
                            ),
                            textAlign: TextAlign.right,
                          )
                        ],
                      )
                          .px12()
                          .py4()
                          .box
                          .colorPrimary(context, opacity: .2)
                          .roundedSM
                          .make(),
                      gap14,
                      Row(
                        mainAxisAlignment: mainSpaceBetween,
                        children: [
                          SummeryItem(
                            title: "Cash Collection",
                            amount: data.data.totalCashCollection,
                          ),
                          SummeryItem(
                            title: "Total Charge",
                            amount: data.data.totalCashCollection,
                          ),
                          SummeryItem(
                            title: "Merchant Due",
                            amount: data.data.totalCashCollection,
                          ),
                        ],
                      ),
                      gap16,
                      Row(
                        mainAxisAlignment: mainCenter,
                        children: [
                          "Detail".text.xl.bodyText1(context).makeCentered(),
                        ],
                      )
                          .pSymmetric(v: 4.h)
                          .box
                          .colorPrimary(context, opacity: .2)
                          .roundedSM
                          .make(),
                      gap8,
                      data.data.details.text.make(),
                      gap16,
                      Row(
                        mainAxisAlignment: mainCenter,
                        children: [
                          "Parcels".text.xl.bodyText1(context).makeCentered(),
                        ],
                      )
                          .pSymmetric(v: 4.h)
                          .box
                          .colorPrimary(context, opacity: .2)
                          .roundedSM
                          .make(),
                      gap8,
                      ...List.generate(
                        data.data.parcels.length,
                        (index) => DeliveryListTile(
                          parcel: data.data.parcels[index],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) {
        Logger.e("$error, $stackTrace");
        return Text(error.toString());
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class SummeryItem extends StatelessWidget {
  const SummeryItem({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  final String title;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title.text.xs.make(),
        gap4,
        "TK $amount".text.semiBold.make(),
      ],
    )
        .p16()
        .box
        .colorScaffoldBackground(context)
        .roundedSM
        .shadowSm
        .make()
        .flexible();
  }
}
