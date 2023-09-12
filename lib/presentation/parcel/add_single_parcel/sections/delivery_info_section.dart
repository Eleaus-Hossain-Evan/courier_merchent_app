import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../application/parcel/parcel_provider.dart';
import '../../../../domain/parcel/parcel_category_model_response.dart';
import '../../../../domain/parcel/weight_model_response.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class DeliveryInfoSection extends HookConsumerWidget {
  const DeliveryInfoSection({
    super.key,
    required this.invoiceController,
    required this.invoiceFocus,
    required this.productPriceFocus,
    required this.selectedWeight,
    required this.productPriceController,
    required this.cashFocus,
    required this.selectedMaterialType,
    required this.selectedParcelCategory,
    required this.selectedWeightText,
    required this.cashController,
    required this.descriptionFocus,
    required this.descriptionController,
    required this.isEditable,
  });

  final TextEditingController invoiceController;
  final FocusNode invoiceFocus;
  final FocusNode productPriceFocus;
  final ValueNotifier<WeightModel?> selectedWeight;
  final TextEditingController productPriceController;
  final FocusNode cashFocus;
  final ValueNotifier<ParcelMaterialType> selectedMaterialType;
  final ValueNotifier<ParcelCategoryModel?> selectedParcelCategory;
  final ValueNotifier<String> selectedWeightText;
  final TextEditingController cashController;
  final FocusNode descriptionFocus;
  final TextEditingController descriptionController;
  final bool isEditable;

  @override
  Widget build(BuildContext context, ref) {
    return IndividualSection(
      title: AppStrings.deliveryInformation,
      child: Column(
        children: [
          KTextFormField2(
            enabled: isEditable,
            hintText: AppStrings.invoiceNo,
            controller: invoiceController,
            focusNode: invoiceFocus,
            containerPadding: EdgeInsets.zero,
            textInputAction: TextInputAction.next,
            validator: ValidationBuilder().maxLength(50).required().build(),
            onFieldSubmitted: (_) => productPriceFocus.requestFocus(),
          ),
          gap16,
          KDropDownSearchWidget<WeightModel>(
            enabled: isEditable,
            hintText: AppStrings.productWeight,
            selectedItem: selectedWeight.value,
            asyncItems: (p0) => ref.read(parcelProvider.notifier).getWeight(),
            itemAsString: (p0) => p0.name.capitalized,
            compareFn: (p0, p1) => identical(p0.name, p0.name),
            contentPadding:
                const EdgeInsets.only(left: 16, top: 10, bottom: 10),
            containerMargin: EdgeInsets.zero,
            onChanged: (value) {
              selectedWeight.value = value!;
            },
            validator: (p0) {
              if (p0 == null) {
                return AppStrings.selectProductWeight;
              }
              return null;
            },
          ),
          gap16,
          KTextFormField2(
            enabled: isEditable,
            hintText: AppStrings.productPrice,
            controller: productPriceController,
            focusNode: productPriceFocus,
            containerPadding: EdgeInsets.zero,
            textInputAction: TextInputAction.next,
            validator: ValidationBuilder().maxLength(50).required().build(),
            keyboardType: TextInputType.number,
            onFieldSubmitted: (_) => cashFocus.requestFocus(),
          ),
          gap16,
          KDropDownSearchWidget<ParcelMaterialType>(
            enabled: isEditable,
            hintText: AppStrings.materialType,
            selectedItem: selectedMaterialType.value,
            items: ParcelMaterialType.values.withoutLast().toList(),
            itemAsString: (p0) => p0.name.capitalized,
            compareFn: (p0, p1) => identical(p0.name, p0.name),
            contentPadding:
                const EdgeInsets.only(left: 16, top: 10, bottom: 10),
            containerMargin: EdgeInsets.zero,
            onChanged: (value) {
              selectedMaterialType.value = value!;
            },
            validator: (value) {
              if (value == null) {
                return AppStrings.selectMaterialType;
              }
              return null;
            },
          ),
          gap16,
          KDropDownSearchWidget<ParcelCategoryModel>(
            enabled: isEditable,
            hintText: AppStrings.category,
            selectedItem: selectedParcelCategory.value,
            asyncItems: (p0) =>
                ref.read(parcelProvider.notifier).getParcelCategory(),
            itemAsString: (p0) => p0.name.capitalized,
            compareFn: (p0, p1) => identical(p0.name, p0.name),
            contentPadding:
                const EdgeInsets.only(left: 16, top: 10, bottom: 10),
            containerMargin: EdgeInsets.zero,
            onChanged: (value) {
              selectedParcelCategory.value = value!;
            },
            validator: (value) {
              if (value == null) {
                return AppStrings.selectCategory;
              }
              return null;
            },
          ),
          gap16,
          KTextFormField2(
            hintText: AppStrings.cashCollection,
            controller: cashController,
            focusNode: cashFocus,
            containerPadding: EdgeInsets.zero,
            validator: ValidationBuilder().maxLength(50).required().build(),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => descriptionFocus.requestFocus(),
          ),
          gap16,
          KTextFormField2(
            enabled: isEditable,
            hintText: AppStrings.description,
            controller: descriptionController,
            focusNode: descriptionFocus,
            containerPadding: EdgeInsets.zero,
            textInputAction: TextInputAction.newline,
            validator: ValidationBuilder().build(),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onFieldSubmitted: (_) =>
                FocusManager.instance.primaryFocus!.unfocus(),
          ),
        ],
      ),
    );
  }
}
