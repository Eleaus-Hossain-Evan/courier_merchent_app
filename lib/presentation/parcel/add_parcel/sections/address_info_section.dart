import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../application/parcel/parcel_provider.dart';
import '../../../../domain/auth/model/area_model.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class AddressInfoSection extends HookConsumerWidget {
  const AddressInfoSection({
    super.key,
    required this.selectedDistrict,
    required this.selectedArea,
    required this.addressController,
    required this.addressFocus,
  });

  final ValueNotifier<AreaModel?> selectedDistrict;
  final ValueNotifier<AreaModel?> selectedArea;
  final TextEditingController addressController;
  final FocusNode addressFocus;

  @override
  Widget build(BuildContext context, ref) {
    return IndividualSection(
      title: AppStrings.addressInformation,
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: KDropDownSearchWidget<AreaModel>(
                  hintText: AppStrings.selectDistrict,
                  selectedItem: selectedDistrict.value,
                  popupProps: const PopupProps.dialog(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        hintText: AppStrings.search,
                      ),
                    ),
                    searchDelay: Duration(milliseconds: 400),
                    fit: FlexFit.loose,
                    dialogProps: DialogProps(
                      backgroundColor: ColorPalate.bg200,
                    ),
                  ),
                  asyncItems: (p0) =>
                      ref.read(parcelProvider.notifier).getDistrict(),
                  itemAsString: (p0) => p0.name,
                  compareFn: (p0, p1) => p0.id == p0.id,
                  contentPadding:
                      const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                  containerMargin: EdgeInsets.zero,
                  onChanged: (value) {
                    selectedDistrict.value = value!;
                  },
                  validator: (value) {
                    if (value == null) {
                      return AppStrings.selectDistrict;
                    }
                    return null;
                  },
                ),
              ),
              gap16,
              Flexible(
                child: KDropDownSearchWidget<AreaModel>(
                  hintText: AppStrings.selectArea,
                  selectedItem: selectedArea.value,
                  popupProps: const PopupProps.dialog(
                    showSearchBox: true,
                    searchDelay: Duration(milliseconds: 400),
                    fit: FlexFit.loose,
                    dialogProps: DialogProps(
                      backgroundColor: ColorPalate.bg200,
                    ),
                  ),
                  enabled: selectedDistrict.value != null,
                  asyncItems: (p0) => ref
                      .read(parcelProvider.notifier)
                      .getArea(selectedDistrict.value!.id),
                  itemAsString: (p0) => p0.name.capitalized,
                  compareFn: (p0, p1) => identical(p0.name, p0.name),
                  contentPadding:
                      const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                  containerMargin: EdgeInsets.zero,
                  onChanged: (value) {
                    selectedArea.value = value!;
                  },
                  validator: (value) {
                    if (value == null) {
                      return AppStrings.selectArea;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          gap16,
          KTextFormField2(
            hintText: AppStrings.address,
            controller: addressController,
            focusNode: addressFocus,
            validator: ValidationBuilder().required().build(),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            maxLines: null,
            containerPadding: padding0,
          ),
        ],
      ),
    );
  }
}
