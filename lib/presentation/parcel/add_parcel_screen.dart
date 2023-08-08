import 'package:bot_toast/bot_toast.dart';
import 'package:courier_merchent_app/utils/utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_merchent_app/application/auth/auth_provider.dart';
import 'package:courier_merchent_app/application/parcel/parcel_provider.dart';
import 'package:courier_merchent_app/domain/parcel/parcel_category_model_response.dart';
import 'package:courier_merchent_app/domain/parcel/weight_model_response.dart';

import '../../application/global.dart';
import '../../domain/auth/model/area_model.dart';
import '../../domain/auth/model/shop_model.dart';
import '../widgets/widgets.dart';
import 'widgets/create_parcel_end_drawer.dart';

enum MaterialType { fragile, liquid }

enum DistrictArea {
  inside("642e4713912a102364a618e1"),
  subside("63cfd08ade135f30482f5783");

  final String id;
  const DistrictArea(this.id);
}

class AddParcelScreen extends HookConsumerWidget {
  static const route = '/add-parcel';

  const AddParcelScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    final formKey = useMemoized<GlobalKey<FormState>>(GlobalKey.new);
    final scaffoldKey = useMemoized<GlobalKey<ScaffoldState>>(GlobalKey.new);

    final selectedShop = useState<MyShopModel?>(
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

    final deliveryCharge = useState<double>(0);
    final codCharge = useState(0.0);

    void getDeliveryCharge() {
      if (selectedDistrict.value == null) {
        deliveryCharge.value = 0;
      } else if (state.user.hub.district.id == DistrictArea.inside.id &&
          selectedDistrict.value?.id == DistrictArea.subside.id) {
        deliveryCharge.value = state.user.regularCharge.subside;
      } else if (state.user.hub.district.id == DistrictArea.subside.id &&
          selectedDistrict.value?.id == DistrictArea.inside.id) {
        deliveryCharge.value = state.user.regularCharge.subside;
      } else if (state.user.hub.district.id == selectedDistrict.value?.id) {
        deliveryCharge.value = state.user.regularCharge.inside;
      } else {
        deliveryCharge.value = state.user.regularCharge.outside;
      }
    }

    void calculateCod() {
      codCharge.value = (int.tryParse(cashController.text) ?? 0) / 100 * 1;
    }

    selectedDistrict.addListener(getDeliveryCharge);

    cashController.addListener(calculateCod);

    ref.listen(parcelProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
      }
    });

    useEffect(() {
      return () {
        selectedDistrict.removeListener(getDeliveryCharge);
        cashController.removeListener(calculateCod);

        BotToast.closeAllLoading();
      };
    }, []);

    return Scaffold(
      key: scaffoldKey,
      appBar: KAppBar(
        titleText: AppStrings.createNewParcel,
        actions: [Container()],
      ),
      endDrawer: CreateParcelEndDrawer(
        scaffoldKey: scaffoldKey,
        selectedShop: selectedShop.value,
        onTap: (shop) => selectedShop.value = shop,
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          padding: padding16,
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              //  Merchant-------------------

              IndividualSection(
                title: AppStrings.merchantInformation,
                action: KInkWell(
                  onTap: () => scaffoldKey.currentState?.openEndDrawer(),
                  child: const Icon(EvaIcons.chevron_right),
                ),
                child: KInkWell(
                  onTap: () => scaffoldKey.currentState?.openEndDrawer(),
                  child: Visibility(
                    visible: selectedShop.value != null,
                    replacement: AppStrings.noShopSelected.text
                        .caption(context)
                        .red500
                        .make()
                        .p20(),
                    child: Column(
                      crossAxisAlignment: crossStart,
                      children: [
                        (selectedShop.value?.shopName ?? "")
                            .text
                            .make()
                            .objectCenterLeft(),
                        gap4,
                        // "Address: ".richText.semiBold.withTextSpanChildren([
                        //   "${selectedShop.value?.address}".textSpan.normal.make(),
                        // ]).make(),
                        Text.rich(
                          TextSpan(
                            text: "${AppStrings.address}:  ",
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: "${selectedShop.value?.address}",
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                        .pOnly(left: 16, right: 16, top: 10, bottom: 10)
                        .box
                        .roundedSM
                        .border(color: ColorPalate.black500, width: 1.2.w)
                        .make(),
                  ),
                ),
              ),
              gap16,

              //  Customer Information--------
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

              //   address Information-----------
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
                            validator: (value) {
                              if (value == null) {
                                return AppStrings.selectDistrict;
                              }
                              return null;
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
                            validator: (value) {
                              if (value == null) {
                                return AppStrings.selectArea;
                              }
                              return null;
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

              //  delivery Information-----------
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
                      validator: (p0) {
                        if (p0 == null) {
                          return AppStrings.selectProductWeight;
                        }
                        return null;
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
                      validator: (value) {
                        if (value == null) {
                          return AppStrings.selectMaterialType;
                        }
                        return null;
                      },
                    ),
                    gap16,
                    KDropDownSearchWidget<ParcelCategoryModel>(
                      hintText: AppStrings.category,
                      selectedItem: selectedParcelCategory.value,
                      asyncItems: (p0) =>
                          ref.read(parcelProvider.notifier).getParcelCategory(),
                      itemAsString: (p0) => p0.name.capitalized,
                      compareFn: (p0, p1) => identical(p0.name, p0.name),
                      contentPadding:
                          const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                      containerMargin: EdgeInsets.zero,
                      onChanged: (value) {
                        selectedParcelCategory.value = value!;
                      },
                      validator: (value) {
                        if (value == null) {
                          return AppStrings.selectCategory;
                        }
                        return null;
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

              //  other Information-------------
              IndividualSection(
                title: AppStrings.otherInformation,
                child: Column(
                  children: [
                    OtherInfoItem(
                      title: AppStrings.deliveryCharge,
                      amount: deliveryCharge.value.toString(),
                    ),
                    gap8,
                    OtherInfoItem(
                      title: AppStrings.codCharge,
                      amount: codCharge.value.toString(),
                    ),
                    gap8,
                    OtherInfoItem(
                      title: AppStrings.weightCharge,
                      amount: (selectedWeight.value?.price ?? 0).toString(),
                    ),
                  ],
                ),
              ),
              gap16,

              //  Create Parcel Button----------
              KFilledButton(
                text: AppStrings.createParcel,
                onPressed: () async {
                  // if (selectedShop.value == null) {
                  //   showErrorToast("Please a shop!");
                  // } else if (formKey.currentState!.validate()) {
                  //   ref
                  //       .read(parcelProvider.notifier)
                  //       .createParcel(
                  //         CreateParcelBody(
                  //           merchantInfo: MerchantInfo(
                  //             name: ref.watch(authProvider).user.name,
                  //             phone: ref.watch(authProvider).user.phone,
                  //             address: ref.watch(authProvider).user.address,
                  //             shopName: selectedShop.value?.shopName ?? "",
                  //             shopAddress: selectedShop.value?.address ?? "",
                  //           ),
                  //           customerInfo: CustomerInfo(
                  //             name: nameController.text,
                  //             phone: phoneController.text,
                  //             address: addressController.text,
                  //             districtId: selectedDistrict.value?.id ?? "",
                  //             areaId: selectedArea.value?.id ?? "",
                  //           ),
                  //           regularParcelInfo: RegularParcelInfo(
                  //             invoiceId: invoiceController.text,
                  //             weight: selectedWeight.value?.name ?? "",
                  //             productPrice:
                  //                 int.tryParse(productPriceController.text) ??
                  //                     0,
                  //             materialType: selectedMaterialType.value.name,
                  //             category:
                  //                 selectedParcelCategory.value?.name ?? "",
                  //             details: descriptionController.text,
                  //           ),
                  //           regularPayment: RegularPaymentModel(
                  //             cashCollection:
                  //                 double.tryParse(cashController.text) ?? 0.0,
                  //             deliveryCharge: deliveryCharge.value,
                  //             codCharge: codCharge.value,
                  //             weightCharge:
                  //                 (selectedWeight.value?.price ?? 0).toDouble(),
                  //             totalCharge: deliveryCharge.value +
                  //                 codCharge.value +
                  //                 (selectedWeight.value?.price ?? 0).toDouble(),
                  //           ),
                  //         ),
                  //       )
                  //       .then((value) =>
                  //           value ? showSuccessDialog(context) : null);
                  // }

                  showSuccessDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool? showSuccessDialog(
  BuildContext context,
) {
  return showSimpleDialog(
    backButtonBehavior: BackButtonBehavior.ignore,
    builder: (cancelFunc) => Dialog(
      clipBehavior: Clip.hardEdge,
      child: Container(
        color: ColorPalate.bg100,
        child: Column(
          crossAxisAlignment: crossCenter,
          mainAxisSize: mainMin,
          children: [
            gap32,
            CircleAvatar(
              backgroundColor: context.colors.primary.lighten().withOpacity(.2),
              radius: 52.r,
              child: CircleAvatar(
                backgroundColor:
                    context.colors.primary.lighten().withOpacity(.4),
                radius: 44.r,
                child: CircleAvatar(
                  backgroundColor:
                      context.colors.primary.lighten().withOpacity(.6),
                  radius: 40.r,
                  child: Image.asset(
                    Images.deliveryBoxCheck,
                    width: 200.w,
                    height: 200.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            gap32,
            "Your parcel has been created successfully"
                .text
                .lg
                .bold
                .center
                .make()
                .objectCenter(),
            gap6,
            "Your track your parcel with tracking id: #5YE339XX19NINTXI"
                .text
                .caption(context)
                .center
                .make(),
            gap12,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: KElevatedButton(
                      text: 'No',
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      onPressed: () {
                        cancelFunc.call();
                      },
                    ),
                  ),
                  gap12,
                  Expanded(
                    child: KFilledButton(
                      text: AppStrings.trackParcel,
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        cancelFunc.call();
                      },
                    ),
                  ),
                ],
              ),
            ),
            gap18,
          ],
        ),
      ),
    ),
  );
}

class OtherInfoItem extends StatelessWidget {
  const OtherInfoItem({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainSpaceBetween,
      children: [
        title.text.caption(context).make().flexible(),
        "TK $amount".text.sm.semiBold.make(),
      ],
    );
  }
}
