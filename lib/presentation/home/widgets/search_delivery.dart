import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class SearchDelivery extends HookWidget {
  const SearchDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    final searchTextController = useTextEditingController();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: KTextFormField2(
            controller: searchTextController,
            hintText: AppStrings.shippingNumber,
            hintTextStyle: CustomTextStyle.textStyle14w500B800,
            containerPadding: padding0,
            isLabel: false,
            fillColor: ColorPalate.bg200,
            prefixIcon: Icon(
              FontAwesome.truck_fast,
              color: ColorPalate.secondary,
              size: 18.sp,
            ),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: ColorPalate.secondary,
              ),
            ),
          ),
        ),
        gap16,
        SizedBox(
          width: 60.w,
          height: 50.h,
          child: KFilledButton(
            onPressed: () {},
            text: '',
            // size: Size(60, 50.h),
            padding: padding0,
            backgroundColor: ColorPalate.primary.lighten(),
            child: const Icon(
              Icons.qr_code_scanner,
              color: ColorPalate.bg200,
            ),
          ),
        ),
      ],
    );
  }
}
