import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../domain/parcel/model/parcel_model.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class CustomerInfoSection extends StatelessWidget {
  const CustomerInfoSection({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ParcelModel data;

  @override
  Widget build(BuildContext context) {
    return IndividualSection(
      title: AppStrings.customerInformation,
      bgColor: ColorPalate.bg200,
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          Row(
            children: [
              'Name : '.text.make(),
              data.customerInfo.name.text.make(),
            ],
          ),
          gap6,
          Row(
            children: [
              'Phone : '.text.make(),
              data.customerInfo.phone.text.make(),
            ],
          ),
          gap6,
          Text.rich(
            TextSpan(
              children: [
                'Address : '.textSpan.make(),
                data.customerInfo.address.textSpan.make(),
                data.customerInfo.area.name.isNotBlank
                    ? ", ".textSpan.make()
                    : "".textSpan.make(),
                data.customerInfo.area.name.textSpan.make(),
                data.customerInfo.district.name.isNotBlank
                    ? ", ".textSpan.make()
                    : "".textSpan.make(),
                data.customerInfo.district.name.textSpan.make(),
              ],
            ),
          ),
        ],
      ),
    ).px16();
  }
}
