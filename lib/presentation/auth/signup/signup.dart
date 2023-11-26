import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../application/auth/auth_provider.dart';
import '../../../domain/auth/signUp_body.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../login/login.dart';

class SignupScreen extends HookConsumerWidget {
  static String route = "/sign-up";
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final addressController = useTextEditingController();
    final passwordController = useTextEditingController();
    final rePasswordController = useTextEditingController();

    final firstNameFocusNode = useFocusNode();
    final lastNameFocusNode = useFocusNode();
    final emailFocusNode = useFocusNode();
    final phoneFocusNode = useFocusNode();
    final addressFocusNode = useFocusNode();
    final referralFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final rePasswordFocusNode = useFocusNode();

    ref.listen(authProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
      }
    });

    // Controller
    final controller = useMemoized(() => CountdownController(autoStart: true));
    return Scaffold(
      appBar: const KAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.signUp.toTitleCase(),
                        style: CustomTextStyle.textStyle32w600,
                      ),
                    ),
                    Column(
                      children: [
                        Images.logo.assetImage(width: .25.sw).centered(),
                        "Merchant"
                            .text
                            .sm
                            .bold
                            .colorPrimary(context)
                            .italic
                            .makeCentered(),
                        divider.w(.1.sw).centered(),
                      ],
                    ).hero('app-logo'),
                    gap18,
                  ],
                ),
                gap6,
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                  child: Text(
                    AppStrings.signupBelowText,
                    style: context.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: ColorPalate.black,
                    ),
                  ),
                ),
                gap36,
                KTextFormField2(
                  containerPadding: padding0,
                  focusNode: firstNameFocusNode,
                  hintText: AppStrings.name,
                  isLabel: true,
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  validator:
                      ValidationBuilder().maxLength(25).required().build(),
                  onFieldSubmitted: (value) {
                    lastNameFocusNode.requestFocus();
                  },
                ),
                gap16,
                KTextFormField2(
                  containerPadding: padding0,
                  hintText: AppStrings.email,
                  isLabel: true,
                  controller: emailController,
                  focusNode: emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidationBuilder()
                      .maxLength(30)
                      .email()
                      .required()
                      .build(),
                  onFieldSubmitted: (value) {
                    phoneFocusNode.requestFocus();
                  },
                ),
                gap16,
                KTextFormField2(
                  containerPadding: padding0,
                  hintText: AppStrings.phoneNumber,
                  isLabel: true,
                  controller: phoneController,
                  focusNode: phoneFocusNode,
                  keyboardType: TextInputType.phone,
                  validator: ValidationBuilder()
                      .maxLength(11)
                      .minLength(11)
                      .phone()
                      .required()
                      .build(),
                  onFieldSubmitted: (value) {
                    referralFocusNode.requestFocus();
                  },
                ),
                gap16,
                KTextFormField2(
                  containerPadding: padding0,
                  hintText: AppStrings.address,
                  isLabel: true,
                  controller: addressController,
                  focusNode: addressFocusNode,
                  keyboardType: TextInputType.multiline,
                  validator: ValidationBuilder().required().build(),
                  onFieldSubmitted: (value) {
                    referralFocusNode.requestFocus();
                  },
                ),
                gap16,
                KTextFormField2(
                  containerPadding: padding0,
                  hintText: AppStrings.password,
                  isLabel: true,
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  isObscure: true,
                  validator: ValidationBuilder().minLength(6).build(),
                  onFieldSubmitted: (value) {
                    referralFocusNode.requestFocus();
                  },
                ),
                gap16,
                KTextFormField2(
                  containerPadding: padding0,
                  controller: rePasswordController,
                  focusNode: rePasswordFocusNode,
                  hintText: AppStrings.reTypePassword,
                  isObscure: true,
                  validator: ValidationBuilder().minLength(6).add((value) {
                    if (value != passwordController.text) {
                      return "Password doesn't match";
                    }
                    return null;
                  }).build(),
                  onFieldSubmitted: (value) {
                    referralFocusNode.requestFocus();
                  },
                ),
                gap12,
                Text(
                  AppStrings.signUpPrivacyPolicy,
                  textAlign: TextAlign.center,
                  style: context.captionStyle!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    letterSpacing: .02,
                    color: ColorPalate.black600,
                  ),
                ),
                gap12,
                KFilledButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    ref.read(authProvider.notifier).signUp(
                          SignUpBody(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                            address: addressController.text,
                          ),
                        );
                  },
                  text: AppStrings.signUp,
                ),
                gap16,
                Center(
                  child: Row(
                    mainAxisAlignment: mainCenter,
                    children: [
                      Text(
                        AppStrings.orSignUpWith,
                        textAlign: TextAlign.center,
                        style: context.titleSmall!.copyWith(
                          color: ColorPalate.black600,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.50,
                        ),
                      ),
                      gap10,
                      KInkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(100.r),
                        child: Logo(
                          Logos.google,
                          size: 12.sp,
                        ).p12(),
                      )
                          .box
                          .colorSecondary(context, opacity: .2)
                          .roundedFull
                          .make(),
                      gap10,
                      KInkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(100.r),
                        child: Logo(
                          Logos.facebook_f,
                          size: 12.sp,
                        ).p12(),
                      )
                          .box
                          .colorSecondary(context, opacity: .2)
                          .roundedFull
                          .make(),
                    ],
                  ),
                ),
                gap16,
                Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      text: AppStrings.alreadyHaveAccount,
                      style: context.titleSmall!.copyWith(
                        color: ColorPalate.black600,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        const WidgetSpan(
                          child: SizedBox(
                            width: 12,
                          ),
                        ),
                        TextSpan(
                          text: AppStrings.login,
                          style: context.headlineMedium!.copyWith(
                            color: ColorPalate.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.pop(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
