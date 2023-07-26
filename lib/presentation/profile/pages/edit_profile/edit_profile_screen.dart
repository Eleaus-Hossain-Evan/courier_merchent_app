import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:select2dot1/select2dot1.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../application/auth/auth_provider.dart';
import '../../../../application/auth/auth_state.dart';
import '../../../../domain/auth/profile_update_body.dart';
import '../../../../application/global.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class EditProfileScreen extends HookConsumerWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  static const route = '/edit-profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    final formKey = useMemoized(GlobalKey<FormState>.new);

    final imageFile = useState<File?>(null);
    final avatar = useState('');

    final nameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();

    final loading = useState(false);

    useEffect(() {
      // Future.microtask(() => ref.read(profileProvider.notifier).getProfile());
      return null;
    }, []);

    ref.listen<AuthState>(
      authProvider,
      (previous, next) {
        if (previous!.loading == false && next.loading) {
          showLoading();
        } else {
          closeLoading();

          nameController.text = next.user.name;
          // setDate(next.user.dateOfBirth);
          emailController.text = next.user.email;
          phoneController.text = next.user.phone;
        }
      },
    );

    final firstName = useState(nameController.text);
    final email = useState(emailController.text);
    final phone = useState(phoneController.text);

    useEffect(() {
      // Future.microtask(() => ref.read(authProvider.notifier).profileView());
      return null;
    }, []);

    const List<SingleCategoryModel> exampleData3 = [
      SingleCategoryModel(
        nameCategory: null,
        singleItemCategoryList: [
          SingleItemCategoryModel(nameSingleItem: 'Alabama'),
          SingleItemCategoryModel(nameSingleItem: 'Arkansas'),
          SingleItemCategoryModel(nameSingleItem: 'California'),
          SingleItemCategoryModel(nameSingleItem: 'Illonois'),
          SingleItemCategoryModel(nameSingleItem: 'Las Vegas'),
        ],
      ),
    ];

    return Scaffold(
      appBar: KAppBar(
        titleText: AppStrings.profile,
        actions: [
          SizedBox(
            width: 80.w,
            child: TextButton(
              onPressed: () {
                ref.read(authProvider.notifier).profileUpdate(
                    ProfileUpdateBody(
                      email: emailController.text.trim(),
                      firstName: nameController.text.trim(),
                      lastName: lastNameController.text.trim(),
                      phone: phoneController.text.trim(),
                      profilePicture: state.user.image,
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
                      image: state.user.image,
                      defaultWidget: Icon(
                        Icons.person,
                        size: 68.sp,
                        color: ColorPalate.secondary,
                      ),
                      editIcon: true,
                      builder: (imageProvider, child) => CircleAvatar(
                        radius: 48.r,
                        backgroundColor: ColorPalate.secondary.withOpacity(.2),
                        backgroundImage: imageProvider,
                        child: child,
                      ),
                    ),
                    gap36,
                    KTextFormField2(
                      hintText: AppStrings.name,
                      controller: nameController,
                      isLabel: true,
                      validator: ValidationBuilder().maxLength(15).build(),
                      onChanged: (value) {
                        firstName.value = value;
                      },
                    ),
                    gap16,
                    KTextFormField2(
                      hintText: AppStrings.email,
                      controller: emailController,
                      isLabel: true,
                      validator:
                          ValidationBuilder().maxLength(30).email().build(),
                      onChanged: (value) {
                        email.value = value;
                      },
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
                      onChanged: (value) {
                        phone.value = value;
                      },
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
                    Row(
                      children: [
                        Flexible(
                          child: KTextFormField2(
                            hintText: "City",
                            readOnly: true,
                            onTap: () {},
                          ),
                        ),
                        gap16,
                        Flexible(
                          child: KTextFormField2(
                            hintText: "Thana",
                            readOnly: true,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    gap16,
                    Select2dot1(
                      selectDataController: SelectDataController(
                        data: exampleData3,
                        isMultiSelect: false,
                      ),
                      // globalSettings: GlobalSettings(
                      //   mainColor: ColorPalate.primary,
                      //   backgroundColor: ColorPalate.bg100,
                      //   activeColor: context.colors.primary,
                      // ),
                      // searchBarModalBuilder: (context, searchBarModalDetails) {
                      //   return TextFormField(
                      //     controller:
                      //         searchBarModalDetails.searchBarModalController,
                      //     onChanged: (value) => searchBarModalDetails
                      //         .onChangedSearchBarController,
                      //   ).cornerRadius(6.r).px12();
                      // },
                      // doneButtonModalSettings: DoneButtonModalSettings(
                      //   margin: EdgeInsets.only(
                      //     bottom: 16.h,
                      //     right: 12.w,
                      //     top: 6.h,
                      //   ),
                      // ),
                      // dropdownModalSettings: const DropdownModalSettings(
                      //   backgroundColor: ColorPalate.bg100,
                      // ),
                    ),
                    Select2dot1(
                      selectDataController:
                          SelectDataController(data: exampleData3),
                      globalSettings: const GlobalSettings(
                        fontFamily: 'Roboto',
                        mainColor: Colors.blue,
                      ),
                    ),
                    gap16,
                    const KTextFormField2(
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
