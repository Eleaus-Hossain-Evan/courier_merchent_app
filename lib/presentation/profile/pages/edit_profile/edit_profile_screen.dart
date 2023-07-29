import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../application/auth/auth_provider.dart';
import '../../../../application/auth/auth_state.dart';
import '../../../../domain/auth/profile_update_body.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class EditProfileScreen extends HookConsumerWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  static const route = '/edit-profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    // final state = ref.watch(profileProvider);

    final formKey = useMemoized(GlobalKey<FormState>.new);

    final imageFile = useState<File?>(null);

    final nameController = useTextEditingController(text: authState.user.name);
    final emailController =
        useTextEditingController(text: authState.user.email);
    final phoneController =
        useTextEditingController(text: authState.user.phone);
    final addressController =
        useTextEditingController(text: authState.user.address);

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

    return Scaffold(
      appBar: KAppBar(
        titleText: AppStrings.profile,
        actions: [
          SizedBox(
            width: 80.w,
            child: TextButton(
              onPressed: () {
                FocusManager.instance.primaryFocus!.unfocus();
                ref.read(authProvider.notifier).profileUpdate(
                    ProfileUpdateBody(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      phone: phoneController.text.trim(),
                      address: addressController.text.trim(),
                    ),
                    imageFile.value);
              },
              child: Text(
                AppStrings.save,
                style: CustomTextStyle.textStyle16w400Primary,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: paddingH16,
                decoration: BoxDecoration(
                  color: ColorPalate.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    gap20,
                    ImagePickWidget(
                      imageFile: imageFile,
                      imagePath: authState.user.image,
                      defaultWidget: Icon(
                        Icons.person,
                        size: 68.sp,
                        color: context.colors.secondary,
                      ),
                      editIcon: true,
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
                      validator: ValidationBuilder().maxLength(15).build(),
                    ),
                    gap16,
                    KTextFormField2(
                      hintText: AppStrings.email,
                      controller: emailController,
                      isLabel: true,
                      validator:
                          ValidationBuilder().maxLength(30).email().build(),
                    ),
                    gap16,
                    KTextFormField2(
                      hintText: AppStrings.phoneNumber,
                      controller: phoneController,
                      isLabel: true,
                      readOnly: true,
                      validator: ValidationBuilder()
                          .maxLength(11)
                          .minLength(11)
                          .phone()
                          .build(),
                    ),
                    gap28,
                  ],
                ),
              ),
              gap24,
              "Address".text.lg.make().objectCenterLeft(),
              gap8,
              Container(
                padding: paddingH16,
                decoration: BoxDecoration(
                  color: ColorPalate.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    gap20,
                    KTextFormField2(
                      controller: addressController,
                      hintText: "Address",
                      isLabel: true,
                    ),
                    gap20,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
