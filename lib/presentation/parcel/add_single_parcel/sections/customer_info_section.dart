import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class CustomerInfoSection extends StatelessWidget {
  const CustomerInfoSection({
    Key? key,
    required this.nameController,
    required this.nameFocus,
    required this.phoneFocus,
    required this.phoneController,
    required this.isEditable,
  }) : super(key: key);

  final TextEditingController nameController;
  final FocusNode nameFocus;
  final FocusNode phoneFocus;
  final TextEditingController phoneController;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return IndividualSection(
      title: AppStrings.customerInformation,
      child: Column(
        children: [
          KTextFormField2(
            enabled: isEditable,
            hintText: AppStrings.name,
            controller: nameController,
            focusNode: nameFocus,
            containerPadding: padding0,
            validator: ValidationBuilder().maxLength(50).required().build(),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => phoneFocus.requestFocus(),
          ),
          gap16,
          KTextFormField2(
            hintText: AppStrings.phoneNumber,
            controller: phoneController,
            focusNode: phoneFocus,
            containerPadding: padding0,
            validator: ValidationBuilder()
                .maxLength(11)
                .minLength(11)
                .phone()
                .required()
                .build(),
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }
}
