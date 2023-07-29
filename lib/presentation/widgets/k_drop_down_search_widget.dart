import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/utils.dart';

class KDropDownSearchWidget<AreaModel> extends HookConsumerWidget {
  const KDropDownSearchWidget({
    Key? key,
    this.selectedItem,
    required this.hintText,
    this.isLabel = true,
    this.enable = true,
    this.contentPadding = const EdgeInsetsDirectional.only(
        start: 16, end: 16, top: 10, bottom: 10),
    this.fillColor = Colors.transparent,
    this.borderColor = ColorPalate.secondary200,
    this.hintTextStyle,
    this.asyncItems,
    this.itemAsString,
    this.compareFn,
    this.onChanged,
  }) : super(key: key);

  final AreaModel? selectedItem;
  final String hintText;
  final bool isLabel, enable;
  final EdgeInsetsGeometry contentPadding;
  final Color fillColor, borderColor;
  final TextStyle? hintTextStyle;
  final Future<List<AreaModel>> Function(String)? asyncItems;
  final String Function(AreaModel)? itemAsString;
  final bool Function(AreaModel, AreaModel)? compareFn;
  final void Function(AreaModel?)? onChanged;

  @override
  Widget build(BuildContext context, ref) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(
        color: ColorPalate.black600,
        width: 1,
      ),
    );

    return DropdownSearch<AreaModel>(
      popupProps: const PopupProps.menu(
        showSelectedItems: true,
      ),
      items: const [],
      selectedItem: selectedItem,
      itemAsString: itemAsString,
      enabled: enable,
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: CustomTextStyle.textStyle14w400B900,
        dropdownSearchDecoration: InputDecoration(
          hintText: isLabel ? null : hintText,
          hintStyle: hintTextStyle ?? CustomTextStyle.textStyle14w500B800,
          labelText: isLabel ? hintText : null,
          labelStyle: CustomTextStyle.textStyle12w400B800,
          contentPadding: contentPadding,
          fillColor: fillColor,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          filled: true,
        ),
      ),
      asyncItems: asyncItems,
      compareFn: compareFn,
      onChanged: onChanged,
    );
  }
}
