import 'dart:developer';

import 'package:courier_merchent_app/presentation/profile/pages/my_shop_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_merchent_app/application/auth/auth_provider.dart';
import 'package:courier_merchent_app/application/parcel/percel_provider.dart';
import 'package:courier_merchent_app/domain/auth/model/shop_model.dart';
import 'package:courier_merchent_app/domain/parcel/create_parcel_body.dart';
import 'package:courier_merchent_app/domain/parcel/parcel_category_model_reponse.dart';
import 'package:courier_merchent_app/domain/parcel/weight_model_response.dart';
import 'package:courier_merchent_app/utils/color_palate.dart';
import 'package:courier_merchent_app/utils/strings.dart';
import 'package:courier_merchent_app/utils/ui_constant.dart';

import '../../domain/parcel/get_area_model_response.dart';
import '../widgets/widgets.dart';

enum MaterialType { fragile, liquid }

class AddParcelScreen extends HookConsumerWidget {
  static const route = '/add-parcel';

  const AddParcelScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    final scaffoldKey = useMemoized<GlobalKey<ScaffoldState>>(GlobalKey.new);

    final selectedShop = useState(
      state.user.myShops.isNotEmpty ? state.user.myShops.first : null,
    );

    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final addressController = useTextEditingController();
    final invoiceController = useTextEditingController();
    final productPriceController = useTextEditingController();
    final cashController = useTextEditingController();
    final descriptionController = useTextEditingController();

    final nameFocus = useFocusNode();
    final phoneFocus = useFocusNode();
    final addressFocus = useFocusNode();
    final invoiceFocus = useFocusNode();
    final productPriceFocus = useFocusNode();
    final cashFocus = useFocusNode();
    final descriptionFocus = useFocusNode();

    final selectedDistrict = useState<AreaModel?>(null);
    final selectedArea = useState<AreaModel?>(null);
    final selectedMaterialType = useState<MaterialType>(MaterialType.fragile);
    final selectedWeight = useState<WeightModel?>(null);
    final selectedParcelCategory = useState<ParcelCategoryModel?>(null);

    return Scaffold(
      key: scaffoldKey,
      appBar: KAppBar(
        titleText: AppStrings.createNewParcel,
        actions: [Container()],
      ),
      endDrawer: CreateParcelEndDrawer(
        drawerKey: scaffoldKey,
        selectedShop: selectedShop.value,
        onTap: (shop) => selectedShop.value = shop,
      ),
      body: SingleChildScrollView(
        padding: padding16,
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            (selectedShop.value?.toJson() ?? "null").text.make(),
            KOutlinedButton(
              isSecondary: false,
              text: "Marchent Information",
              onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
            ),
            gap16,
            IndividualSection(
              title: AppStrings.customerInformation,
              child: Column(
                children: [
                  KTextFormField2(
                    hintText: AppStrings.name,
                    controller: nameController,
                    focusNode: nameFocus,
                    containerPadding: padding0,
                    validator:
                        ValidationBuilder().maxLength(50).required().build(),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => phoneFocus.requestFocus(),
                  ),
                  gap16,
                  KTextFormField2(
                    hintText: AppStrings.phoneNumber,
                    controller: phoneController,
                    focusNode: phoneFocus,
                    containerPadding: padding0,
                    validator: ValidationBuilder()
                        .maxLength(11)
                        .minLength(11)
                        .phone()
                        .required()
                        .build(),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                ],
              ),
            ),
            gap16,
            IndividualSection(
              title: AppStrings.addressInformation,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: KDropDownSearchWidget<AreaModel>(
                          hintText: AppStrings.selectDistrict,
                          selectedItem: selectedDistrict.value,
                          popupProps: const PopupProps.dialog(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                hintText: AppStrings.search,
                              ),
                            ),
                            searchDelay: Duration(milliseconds: 400),
                            fit: FlexFit.loose,
                            dialogProps: DialogProps(
                              backgroundColor: ColorPalate.bg200,
                            ),
                          ),
                          asyncItems: (p0) =>
                              ref.read(parcelProvider.notifier).getDistrict(),
                          itemAsString: (p0) => p0.name,
                          compareFn: (p0, p1) => p0.id == p0.id,
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 10, bottom: 10),
                          containerMargin: EdgeInsets.zero,
                          onChanged: (value) {
                            selectedDistrict.value = value!;
                          },
                        ),
                      ),
                      gap16,
                      Flexible(
                        child: KDropDownSearchWidget<AreaModel>(
                          hintText: AppStrings.selectArea,
                          selectedItem: selectedArea.value,
                          popupProps: const PopupProps.dialog(
                            showSearchBox: true,
                            searchDelay: Duration(milliseconds: 400),
                            fit: FlexFit.loose,
                            dialogProps: DialogProps(
                              backgroundColor: ColorPalate.bg200,
                            ),
                          ),
                          enabled: selectedDistrict.value != null,
                          asyncItems: (p0) => ref
                              .read(parcelProvider.notifier)
                              .getArea(selectedDistrict.value!.id),
                          itemAsString: (p0) => p0.name.capitalized,
                          compareFn: (p0, p1) => identical(p0.name, p0.name),
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 10, bottom: 10),
                          containerMargin: EdgeInsets.zero,
                          onChanged: (value) {
                            selectedArea.value = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                  gap16,
                  KTextFormField2(
                    hintText: AppStrings.address,
                    controller: addressController,
                    focusNode: addressFocus,
                    validator: ValidationBuilder().required().build(),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    containerPadding: padding0,
                  ),
                ],
              ),
            ),
            gap16,
            IndividualSection(
              title: AppStrings.deliveryInformation,
              child: Column(
                children: [
                  KTextFormField2(
                    hintText: AppStrings.invoiceNo,
                    controller: invoiceController,
                    focusNode: invoiceFocus,
                    containerPadding: EdgeInsets.zero,
                    textInputAction: TextInputAction.next,
                    validator:
                        ValidationBuilder().maxLength(50).required().build(),
                    onFieldSubmitted: (_) => productPriceFocus.requestFocus(),
                  ),
                  gap16,
                  KDropDownSearchWidget<WeightModel>(
                    hintText: AppStrings.productWeight,
                    selectedItem: selectedWeight.value,
                    asyncItems: (p0) =>
                        ref.read(parcelProvider.notifier).getWeight(),
                    itemAsString: (p0) => p0.name.capitalized,
                    compareFn: (p0, p1) => identical(p0.name, p0.name),
                    contentPadding:
                        const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                    containerMargin: EdgeInsets.zero,
                    onChanged: (value) {
                      selectedWeight.value = value!;
                    },
                  ),
                  gap16,
                  KTextFormField2(
                    hintText: AppStrings.productPrice,
                    controller: productPriceController,
                    focusNode: productPriceFocus,
                    containerPadding: EdgeInsets.zero,
                    textInputAction: TextInputAction.next,
                    validator:
                        ValidationBuilder().maxLength(50).required().build(),
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (_) => cashFocus.requestFocus(),
                  ),
                  gap16,
                  KDropDownSearchWidget<MaterialType>(
                    hintText: AppStrings.materialType,
                    selectedItem: selectedMaterialType.value,
                    items: MaterialType.values,
                    itemAsString: (p0) => p0.name.capitalized,
                    compareFn: (p0, p1) => identical(p0.name, p0.name),
                    contentPadding:
                        const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                    containerMargin: EdgeInsets.zero,
                    onChanged: (value) {
                      selectedMaterialType.value = value!;
                    },
                  ),
                  gap16,
                  KDropDownSearchWidget<ParcelCategoryModel>(
                    hintText: AppStrings.category,
                    selectedItem: selectedParcelCategory.value,
                    asyncItems: (p0) =>
                        ref.read(parcelProvider.notifier).getParcelCategpry(),
                    itemAsString: (p0) => p0.name.capitalized,
                    compareFn: (p0, p1) => identical(p0.name, p0.name),
                    contentPadding:
                        const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                    containerMargin: EdgeInsets.zero,
                    onChanged: (value) {
                      selectedParcelCategory.value = value!;
                    },
                  ),
                  gap16,
                  KTextFormField2(
                    hintText: AppStrings.cashCollection,
                    controller: cashController,
                    focusNode: cashFocus,
                    containerPadding: EdgeInsets.zero,
                    validator:
                        ValidationBuilder().maxLength(50).required().build(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => descriptionFocus.requestFocus(),
                  ),
                  gap16,
                  KTextFormField2(
                    hintText: AppStrings.description,
                    controller: descriptionController,
                    focusNode: descriptionFocus,
                    containerPadding: EdgeInsets.zero,
                    textInputAction: TextInputAction.newline,
                    validator: ValidationBuilder().required().build(),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onFieldSubmitted: (_) =>
                        FocusManager.instance.primaryFocus!.unfocus(),
                  ),
                ],
              ),
            ),
            gap16,
            KFilledButton(
              text: AppStrings.createParcel,
              onPressed: () {
                ref.read(parcelProvider.notifier).createParcel(
                      CreateParcelBody(
                        merchantInfo: MerchantInfo(
                          name: ref.watch(authProvider).user.name,
                          phone: ref.watch(authProvider).user.phone,
                          address: ref.watch(authProvider).user.address,
                          shopName: selectedShop.value?.shopName ?? "",
                          shopAddress: selectedShop.value?.address ?? "",
                        ),
                        customerInfo: CustomerInfo(
                          name: nameController.text,
                          phone: phoneController.text,
                          address: addressController.text,
                          districtId: selectedDistrict.value?.id ?? "",
                          areaId: selectedArea.value?.id ?? "",
                        ),
                        regularParcelInfo: RegularParcelInfo(
                          invoiceId: invoiceController.text,
                          weight: selectedWeight.value?.name ?? "",
                          productPrice:
                              int.tryParse(productPriceController.text) ?? 0,
                          materialType: selectedMaterialType.value.name,
                          category: selectedParcelCategory.value?.name ?? "",
                          details: descriptionController.text,
                        ),
                        regularPayment: RegularPayment(
                          cashCollection:
                              int.tryParse(cashController.text) ?? 0,
                          deliveryCharge: 0,
                          codCharge: 0,
                          weightCharge: 0,
                          totalCharge: 0,
                        ),
                      ),
                    );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CreateParcelEndDrawer extends HookConsumerWidget {
  const CreateParcelEndDrawer({
    super.key,
    this.onTap,
    required this.drawerKey,
    this.selectedShop,
  });

  final Function(MyShopModel)? onTap;
  final GlobalKey<ScaffoldState> drawerKey;
  final MyShopModel? selectedShop;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(authProvider);

    final nameController = useTextEditingController(text: state.user.name);
    final emailController = useTextEditingController(text: state.user.email);
    final phoneController = useTextEditingController(text: state.user.phone);

    return Drawer(
      child: Center(
        child: Padding(
          padding: padding22.copyWith(top: 42.h),
          child: Column(
            children: [
              ContainerBGWhite(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          BoxIcons.bxs_user_account,
                          size: 18.sp,
                          color: ColorPalate.secondary,
                        ).pOnly(right: 12.w, left: 8.w),
                        AppStrings.personalInfo.text.lg
                            .make()
                            .objectCenterLeft(),
                      ],
                    ),
                    gap28,
                    KTextFormField2(
                      hintText: AppStrings.name,
                      controller: nameController,
                      isLabel: true,
                      enabled: false,
                      containerPadding: EdgeInsets.zero,
                      validator: ValidationBuilder().maxLength(15).build(),
                    ),
                    gap16,
                    KTextFormField2(
                      hintText: AppStrings.email,
                      controller: emailController,
                      isLabel: true,
                      readOnly: true,
                      enabled: false,
                      containerPadding: EdgeInsets.zero,
                      validator:
                          ValidationBuilder().maxLength(30).email().build(),
                    ),
                    gap16,
                    KTextFormField2(
                      hintText: AppStrings.phoneNumber,
                      controller: phoneController,
                      isLabel: true,
                      readOnly: true,
                      enabled: false,
                      containerPadding: EdgeInsets.zero,
                      validator: ValidationBuilder()
                          .maxLength(11)
                          .minLength(11)
                          .phone()
                          .build(),
                    ),
                  ],
                ),
              ),
              gap36,
              ContainerBGWhite(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Bootstrap.shop,
                          size: 18.sp,
                          color: ColorPalate.secondary,
                        ),
                        gap12,
                        "My Shops".text.lg.semiBold.make().objectCenterLeft(),
                      ],
                    ),
                    Visibility(
                      visible: state.user.myShops.isNotEmpty,
                      replacement: Column(
                        children: [
                          gap12,
                          "No Shop added yet!"
                              .text
                              .caption(context)
                              .make()
                              .p24(),
                          gap16,
                          KFilledButton(
                            text: "Add Shop",
                            isSecondary: true,
                            foregroundColor: ColorPalate.black900,
                            onPressed: () => context.push(MyShopScreen.route),
                          ),
                        ],
                      ),
                      child: KListViewSeparated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: padding0,
                        itemBuilder: (context, index) {
                          final shop = state.user.myShops[index];
                          return ListTile(
                            selected: shop == selectedShop,
                            onTap: () {
                              onTap?.call(shop);
                              log(shop.toJson());
                              drawerKey.currentState!.closeEndDrawer();
                            },
                            title: shop.shopName.text.make(),
                            subtitle: shop.address.text.make(),
                            dense: true,
                            style: ListTileStyle.drawer,
                            enableFeedback: true,
                            tileColor: context.colors.primaryContainer,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        },
                        itemCount: state.user.myShops.length,
                      ),
                    ),
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
