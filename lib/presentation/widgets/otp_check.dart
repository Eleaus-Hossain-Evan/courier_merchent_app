import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';
import 'widgets.dart';

class OtpCheckWidget extends HookConsumerWidget {
  const OtpCheckWidget({
    super.key,
    required this.onTapOtpCheck,
  });

  final Function(String) onTapOtpCheck;

  @override
  Widget build(BuildContext context, ref) {
    final otpController = useTextEditingController();

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
        color: ColorPalate.black,
        letterSpacing: 1.2,
      ),
      decoration: BoxDecoration(
        color: ColorPalate.white,
        border: Border.all(color: ColorPalate.black400),
        borderRadius: BorderRadius.circular(6),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: context.colors.secondary,
        width: 1.4,
      ),
      borderRadius: BorderRadius.circular(12),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: ColorPalate.success),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(
          color: context.colors.error.withOpacity(.4),
          width: 1.4,
        ),
        color: context.colors.primary.withOpacity(.04),
      ),
    );

    return AlertDialog(
      titlePadding: EdgeInsets.only(
        left: 18.w,
        right: 8.w,
      ),
      title: Row(
        children: [
          Text(
            'Enter OTP',
            style: context.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ).expand(),
          const CloseButton()
        ],
      ),
      content: Column(
        mainAxisSize: mainMin,
        children: [
          Pinput(
            controller: otpController,
            length: 6,
            defaultPinTheme: defaultPinTheme,
            followingPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            errorPinTheme: errorPinTheme,
            // enabled: !isTimerFinished.value,
            // validator: (s) {
            //   return s == "1111111" ? null : 'Pin is incorrect';
            // },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            showCursor: true,
            errorBuilder: (errorText, pin) => Padding(
              padding: padding6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    errorText!,
                    style: context.bodySmall!.copyWith(
                      color: context.colors.error,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
            onCompleted: (pin) => print(pin),
          ),
          gap16,
          KElevatedButton(
            onPressed: () => onTapOtpCheck(otpController.text),
            text: "Check OTP",
            isSecondary: true,
          ),
        ],
      ),
    );
  }
}
