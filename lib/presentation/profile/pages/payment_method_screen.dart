import 'package:courier_merchent_app/application/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class PaymentMethodScreen extends HookConsumerWidget {
  static const route = '/payment-method';

  const PaymentMethodScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otherAcc = ref.watch(authProvider).user.othersAccount;
    final bcash = useTextEditingController(text: otherAcc.bkashNum);
    final rocket = useTextEditingController(text: otherAcc.rocketNum);
    final nagad = useTextEditingController(text: otherAcc.nagadNum);

    final isUpdate = useState(false);

    return CustomScaffold(
      appBar: KAppBarBGTransparent(
        title: "Payment Method".text.make(),
        actions: [
          Visibility(
            visible: !isUpdate.value,
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
                    KTextFormField2(
                      controller: bcash,
                      hintText: "Bcash Number",
                      enabled: isUpdate.value,
                    ),
                    gap16,
                    KTextFormField2(
                      controller: rocket,
                      hintText: "Rocket Number",
                      enabled: isUpdate.value,
                    ),
                    gap16,
                    KTextFormField2(
                      controller: nagad,
                      hintText: "Nagad Number",
                      enabled: isUpdate.value,
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
