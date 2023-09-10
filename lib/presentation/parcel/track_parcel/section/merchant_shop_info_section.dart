import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../domain/parcel/model/parcel_model.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class MerchantShopInfoSection extends StatelessWidget {
  const MerchantShopInfoSection({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ParcelModel data;

  @override
  Widget build(BuildContext context) {
    return IndividualSection(
      title: "${AppStrings.merchantInfo} - ${AppStrings.shop}",
      bgColor: ColorPalate.bg200,
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          Row(
            children: [
              'Shop Name : '.text.make(),
              data.merchantInfo.shopName.text.make(),
            ],
          ),
          gap6,
          Text.rich(
            TextSpan(
              children: [
                'Address : '.textSpan.make(),
                data.merchantInfo.address.textSpan.make(),
                data.merchantInfo.area.name.isNotBlank
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
