import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_merchent_app/application/auth/auth_provider.dart';
import 'package:courier_merchent_app/utils/utils.dart';

import '../../widgets/widgets.dart';

class BankDetailsScreen extends HookConsumerWidget {
  static const route = "/bank-details";
  const BankDetailsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bankDetail = ref.watch(authProvider).user.bankAccount;

    final accHolder = useTextEditingController(text: bankDetail.accName);
    final bankName = useTextEditingController(text: bankDetail.bankName);
    final branchName = useTextEditingController(text: bankDetail.branch);
    final routingNum = useTextEditingController(text: bankDetail.routingNum);
    final accNumber = useTextEditingController(text: bankDetail.accNum);

    final newBankDetail = useState(bankDetail);

    final isUpdate = useState(false);

    return CustomScaffold(
      appBar: KAppBarBGTransparent(
        title: AppStrings.bankDetails.text.make(),
        actions: [
          Visibility(
            // visible: !isUpdate.value,
            child: IconButton(
                onPressed: () => isUpdate.value = !isUpdate.value,
                icon: const Icon(FontAwesome.pen_to_square)
                    .iconColor(ColorPalate.white)
                    .iconSize(18.sp)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: paddingH16,
        child: Padding(
          padding: EdgeInsets.only(top: 160.h),
          child: Column(
            children: [
              ContainerBGWhite(
                padding: paddingV20,
                child: Column(
                  children: [
                    gap12,
                    KTextFormField2(
                      controller: accHolder,
                      hintText: AppStrings.accountHolder,
                      enabled: isUpdate.value,
                      onChanged: (value) =>
                          newBankDetail.value.copyWith(accName: value),
                    ),
                    gap16,
                    KTextFormField2(
                      controller: bankName,
                      hintText: AppStrings.bankName,
                      enabled: isUpdate.value,
                      onChanged: (value) =>
                          newBankDetail.value.copyWith(bankName: value),
                    ),
                    gap16,
                    KTextFormField2(
                      controller: branchName,
                      hintText: AppStrings.branchCode,
                      enabled: isUpdate.value,
                      onChanged: (value) =>
                          newBankDetail.value.copyWith(branch: value),
                    ),
                    gap16,
                    KTextFormField2(
                      controller: routingNum,
                      hintText: AppStrings.routingNumber,
                      enabled: isUpdate.value,
                      onChanged: (value) =>
                          newBankDetail.value.copyWith(routingNum: value),
                    ),
                    gap16,
                    KTextFormField2(
                      controller: accNumber,
                      hintText: AppStrings.accountNumber,
                      enabled: isUpdate.value,
                      onChanged: (value) =>
                          newBankDetail.value.copyWith(accNum: value),
                    ),
                  ],
                ),
              ),
              gap20,
              Visibility(
                visible: isUpdate.value,
                child: KFilledButton(
                  text: AppStrings.save,
                  onPressed: isUpdate.value
                      ? () {
                          isUpdate.value = false;
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
