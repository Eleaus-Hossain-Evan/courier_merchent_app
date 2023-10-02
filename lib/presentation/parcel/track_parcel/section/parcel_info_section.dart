import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../domain/parcel/model/parcel_model.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class ParcelInfoSection extends StatelessWidget {
  const ParcelInfoSection({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ParcelModel data;

  @override
  Widget build(BuildContext context) {
    return IndividualSectionParcelTrack(
      title: AppStrings.parcelInformation,
      child: Column(
        children: [
          Row(
            children: [
              'invoiceId : '.text.make(),
              data.regularParcelInfo.invoiceId.text.make(),
            ],
          ),
          gap6,
          Row(
            children: [
              'Weight : '.text.make(),
              data.regularParcelInfo.weight.text.make(),
            ],
          ),
          gap6,
          Row(
            children: [
              'Product Price : '.text.make(),
              data.regularParcelInfo.productPrice.text.make(),
            ],
          ),
          gap6,
          Row(
            children: [
              'Material Type : '.text.make(),
              data.regularParcelInfo.materialType.value.capitalized.text.make(),
            ],
          ),
          gap6,
          Row(
            children: [
              'Category : '.text.make(),
              data.regularParcelInfo.category.text.make(),
            ],
          ),
          gap6,
          Row(
            children: [
              'Details : '.text.make(),
              data.regularParcelInfo.details.text.make(),
            ],
          ),
          gap6,
          Row(
            children: [
              'Instruction : '.text.make(),
              data.regularParcelInfo.instruction.text.make(),
            ],
          ),
        ],
      ),
    ).px16();
  }
}
