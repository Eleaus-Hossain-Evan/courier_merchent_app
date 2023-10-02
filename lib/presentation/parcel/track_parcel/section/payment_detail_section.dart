import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../domain/parcel/model/parcel_model.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class PaymentDetailSection extends StatelessWidget {
  const PaymentDetailSection({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ParcelModel data;

  @override
  Widget build(BuildContext context) {
    return IndividualSectionParcelTrack(
      title: "Payment Detail",
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          Row(
            children: [
              'cashCollection : '.text.make(),
              data.regularPayment.cashCollection.text.make(),
            ],
          ),
          gap6,
          Row(
            children: [
              'deliveryCharge : '.text.make(),
              data.regularPayment.deliveryCharge.text.make(),
            ],
          ),
          gap6,
          Row(
            children: [
              'codCharge : '.text.make(),
              data.regularPayment.codCharge.text.make(),
            ],
          ),
          gap6,
          Row(
            children: [
              'weightCharge : '.text.make(),
              data.regularPayment.weightCharge.text.make(),
            ],
          ),
          gap12,
          const KDivider(),
          gap6,
          Row(
            mainAxisAlignment: mainCenter,
            children: [
              'Total Charge : '.text.lg.bold.make(),
              data.regularPayment.totalCharge.text.lg.bold.make(),
            ],
          ),
          gap6,
          const KDivider(),
        ],
      ),
    ).px16();
  }
}
