import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../application/auth/auth_provider.dart';
import '../../../../application/auth/auth_state.dart';
import '../../../../domain/auth/profile_update_body.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../bank_detail/bank_details_screen.dart';
import 'widgets/profile_section.dart';

enum PickUpStyle { perRequest, daily }

class ProfileDetailScreen extends HookConsumerWidget {
  static const route = '/profile-detail';

  const ProfileDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    final isLoading = useState(false);

    final formKey = useMemoized(GlobalKey<FormState>.new);

    final isUpdate = useState(false);

    final imageFile = useState<File?>(null);

    final nameController = useTextEditingController(text: state.user.name);
    final emailController = useTextEditingController(text: state.user.email);
    final phoneController = useTextEditingController(text: state.user.phone);
    final addressController =
        useTextEditingController(text: state.user.address);

    final selectedPickUpStyle = useState<PickUpStyle?>(
        PickUpStyle.values.byName(state.user.pickupStyle));

    final selectedDefaultPayment = useState<DefaultPayment>(
        DefaultPayment.values.byName(state.user.defaultPayment));
    final selectedPaymentStyle =
        useState(PaymentStyle.values.byName(state.user.paymentStyle));

    ref.listen<AuthState>(
      authProvider,
      (previous, next) {
        if (previous!.loading == false && next.loading) {
          BotToast.showLoading();
        } else {
          BotToast.closeAllLoading();
        }
      },
    );

    useEffect(() {
      Future.microtask(() => ref.read(authProvider.notifier).profileView());
      return null;
    }, const []);

    return CustomScaffold(
      appBar: KAppBarBGTransparent(
        titleText: AppStrings.profile,
        actions: [
          Visibility(
            visible: !isUpdate.value,
            // replacement: SizedBox(
            //   width: 100.w,
            //   child: TextButton(
            //     child: "Save"
            //         .text
            //         .colorSecondary(context)
            //         .bold
            //         .letterSpacing(1.2)
            //         .make(),
            //     onPressed: () {
            //       isUpdate.value = !isUpdate.value;
            //     },
            //   ),
            // ),
            child: IconButton(
              onPressed: () {
                isUpdate.value = !isUpdate.value;
              },
              icon: const Icon(FontAwesome.pen_to_square)
                  .iconColor(ColorPalate.white)
                  .iconSize(18.sp),
            ),
          ),
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () {
          return ref.read(authProvider.notifier).profileView();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 100.h),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // show warning for edit
                SizedBox(
                  height: 70,
                  child: WarningSection(
                      text: 'You can\'t change phone and email'
                          .text
                          .color(ColorPalate.warning)
                          .titleSmall(context)
                          .make()),
                ),
                //  Personal Info------------------

                ProfileSection(
                  title: AppStrings.personalInfo,
                  leading: Icon(
                    BoxIcons.bxs_user_account,
                    size: 18.sp,
                    color: ColorPalate.secondary,
                  ),
                  visible: true,
                  containerPadding: paddingV20,
                  child: Column(
                    crossAxisAlignment: crossStart,
                    children: [
                      ImagePickWidget(
                        imageFile: imageFile,
                        imagePath: state.user.image,
                        defaultWidget: Icon(
                          Icons.person,
                          size: 68.sp,
                          color: context.colors.secondaryContainer,
                        ),
                        editIcon: isUpdate.value,
                        onTapUploadImage: (file) async {
                          Logger.w(file);
                          final success = await ref
                              .read(authProvider.notifier)
                              .uploadImage(file);
                          if (success) imageFile.value = null;
                        },
                      ),
                      gap24,
                      KTextFormField2(
                        hintText: AppStrings.name,
                        controller: nameController,
                        isLabel: true,
                        enabled: isUpdate.value,
                        validator: ValidationBuilder().maxLength(15).build(),
                      ),
                      gap16,
                      KTextFormField2(
                        hintText: AppStrings.email,
                        controller: emailController,
                        isLabel: true,
                        readOnly: true,
                        enabled: isUpdate.value,
                        validator:
                            ValidationBuilder().maxLength(30).email().build(),
                      ),
                      gap16,
                      KTextFormField2(
                        hintText: AppStrings.phoneNumber,
                        controller: phoneController,
                        isLabel: true,
                        readOnly: true,
                        enabled: isUpdate.value,
                        validator: ValidationBuilder()
                            .maxLength(11)
                            .minLength(11)
                            .phone()
                            .build(),
                      ),
                    ],
                  ),
                ),

                //  Address ----------------

                ProfileSection(
                  title: AppStrings.address,
                  leading: const Icon(
                    FontAwesome.address_card,
                    size: 18,
                    color: ColorPalate.secondary,
                  ),
                  visible: isUpdate.value,
                  containerPadding: paddingV20,
                  replacement: Row(
                    children: [
                      gap16,
                      Visibility(
                        visible: state.user.address.isNotBlank,
                        replacement: "No address added yet..."
                            .text
                            .labelSmall(context)
                            .make(),
                        child: state.user.address.text.lg.make().flexible(),
                      ),
                    ],
                  ).px16(),
                  child: KTextFormField2(
                    controller: addressController,
                    hintText: AppStrings.address,
                    enabled: isUpdate.value,
                    isLabel: true,
                  ),
                ),

                ProfileSection(
                  title: AppStrings.paymentStyle,
                  leading: Icon(
                    BoxIcons.bx_money_withdraw,
                    size: 18.sp,
                    color: ColorPalate.secondary,
                  ),
                  visible: isUpdate.value,
                  containerPadding: paddingV20,
                  replacement: Row(
                    children: [
                      " ${state.user.paymentStyle.toTitleCaseFromCamel()}"
                          .text
                          .lg
                          .make()
                          .flexible(),
                    ],
                  ).px16(),
                  child: KDropDownSearchWidget<PaymentStyle>(
                    enabled: isUpdate.value,
                    hintText: AppStrings.paymentOptions,
                    selectedItem: selectedPaymentStyle.value,
                    items: PaymentStyle.values,
                    itemAsString: (p0) => p0.name.capitalized,
                    compareFn: (p0, p1) => identical(p0.name, p0.name),
                    onChanged: (value) {
                      selectedPaymentStyle.value = value!;
                    },
                  ),
                ),

                //  Default Payment -------------

                ProfileSection(
                  title: AppStrings.defaultPayment,
                  leading: Icon(
                    FontAwesome.money_bill_1_wave_solid,
                    size: 18.sp,
                    color: ColorPalate.secondary,
                  ),
                  visible: isUpdate.value,
                  containerPadding: paddingV20,
                  replacement: Row(
                    children: [
                      " ${state.user.defaultPayment.toTitleCaseFromCamel()}"
                          .text
                          .lg
                          .make()
                          .flexible(),
                    ],
                  ).px16(),
                  child: KDropDownSearchWidget<DefaultPayment>(
                    enabled: isUpdate.value,
                    // containerMargin: padding0,
                    hintText: AppStrings.paymentOptions,
                    selectedItem: selectedDefaultPayment.value,
                    items: DefaultPayment.values,
                    itemAsString: (p0) => p0.name.capitalized,
                    compareFn: (p0, p1) => identical(p0.name, p0.name),
                    onChanged: (value) {
                      selectedDefaultPayment.value = value!;
                    },
                  ),
                ),
                // PICKUP Style---------------

                ProfileSection(
                  title: AppStrings.pickupStyle,
                  leading: Icon(
                    FontAwesome.location_pin_lock_solid,
                    size: 18.sp,
                    color: ColorPalate.secondary,
                  ),
                  visible: isUpdate.value,
                  containerPadding: paddingV20,
                  replacement: Row(
                    children: [
                      " ${state.user.pickupStyle.toTitleCaseFromCamel()}"
                          .text
                          .lg
                          .make()
                          .flexible(),
                    ],
                  ).px16(),
                  child: KDropDownSearchWidget<PickUpStyle>(
                    enabled: isUpdate.value,
                    hintText: AppStrings.pickupStyleOptions,
                    selectedItem: selectedPickUpStyle.value,
                    items: PickUpStyle.values,
                    itemAsString: (p0) => p0.name.toTitleCaseFromCamel(),
                    compareFn: (p0, p1) => identical(p0.name, p0.name),
                    onChanged: (value) {
                      selectedPickUpStyle.value = value!;
                    },
                  ),
                ),

                gap20,
                Visibility(
                  visible: isUpdate.value,
                  child: KFilledButton(
                    text: AppStrings.save,
                    loading: isLoading.value,
                    onPressed: () async {
                      isLoading.value = true;
                      FocusManager.instance.primaryFocus!.unfocus();
                      ref
                          .read(authProvider.notifier)
                          .profileUpdate(
                              ProfileUpdateBody(
                                name: nameController.text.trim(),
                                address: addressController.text.trim(),
                                pickupStyle:
                                    selectedPickUpStyle.value?.name ?? "",
                                defaultPayment:
                                    selectedDefaultPayment.value.name,
                                paymentStyle: selectedPaymentStyle.value.name,
                              ),
                              imageFile.value)
                          .then((value) {
                        isLoading.value = false;
                        if (value) {
                          isUpdate.value = false;
                        }
                      });
                    },
                  ),
                ),
                gap36,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
