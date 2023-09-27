import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../application/auth/auth_provider.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/otp_check.dart';
import '../../../widgets/widgets.dart';

class SendOTP extends HookConsumerWidget {
  const SendOTP({
    super.key,
    required this.phoneController,
    required this.token,
    required this.pageController,
  });

  final TextEditingController phoneController;
  final ValueNotifier<String> token;
  final PageController pageController;

  @override
  Widget build(BuildContext context, ref) {
    // Controller
    final controller = useMemoized(() => CountdownController(autoStart: true));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          gap8,
          KTextFormField2(
            containerPadding: padding0,
            controller: phoneController,
            keyboardType: TextInputType.text,
            hintText: AppStrings.phoneNumber,
          ),
          gap24,
          KFilledButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              // ref
              //     .read(authProvider.notifier)
              //     .forgotPassword(phoneController.text)
              //     .then((value) => value
              //         ? showDialog(
              //             context: context,
              //             barrierDismissible: false,
              //             barrierLabel: "Barrier",
              //             useSafeArea: true,
              //             builder: (context) => AlertDialog(
              //               content: OtpCheckWidget(
              //                 controller: controller,
              //                 onTapOtpCheck: (otp) async => ref
              //                     .read(authProvider.notifier)
              //                     .verifyOtp(otp)
              //                     .then((value) {
              //                   if (value.isNotBlank) {
              //                     token.value = value;
              //                     Navigator.pop(context);
              //                     pageController.nextPage(
              //                         duration: 500.milliseconds,
              //                         curve: Curves.easeIn);
              //                   }
              //                 }),
              //               ),
              //             ),
              //           )
              //         : null);
              showDialog(
                context: context,
                barrierDismissible: false,
                barrierLabel: "Barrier",
                useSafeArea: true,
                builder: (context) => Dialog(
                  child: Padding(
                    padding: EdgeInsets.all(22.w),
                    child: OtpCheckWidget(
                      onFinishedTimer: () => Navigator.pop(context),
                      onTapOtpCheck: (otp) async => ref
                          .read(authProvider.notifier)
                          .verifyOtp(otp)
                          .then((value) {
                        if (value.isNotBlank) {
                          token.value = value;
                          Navigator.pop(context);
                          pageController.nextPage(
                              duration: 500.milliseconds, curve: Curves.easeIn);
                        }
                      }),
                    ),
                  ),
                ),
              );
            },
            text: AppStrings.sendOtp,
          ),
        ],
      ),
    );
  }
}
