import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:courier_merchent_app/domain/parcel/model/parcel_model.dart';
import 'package:courier_merchent_app/domain/parcel/update_parcel_body.dart';
import 'package:courier_merchent_app/presentation/parcel/invoice_screen.dart';
import 'package:courier_merchent_app/utils/utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_merchent_app/application/auth/auth_provider.dart';
import 'package:courier_merchent_app/application/parcel/parcel_provider.dart';
import 'package:courier_merchent_app/domain/parcel/parcel_category_model_response.dart';
import 'package:courier_merchent_app/domain/parcel/weight_model_response.dart';

import '../../../application/global.dart';
import '../../../application/shop/shop_provider.dart';
import '../../../domain/auth/model/area_model.dart';
import '../../../domain/auth/model/shop_model.dart';
import '../../../domain/parcel/create_parcel_body.dart';
import '../../../domain/parcel/model/customer_info_model.dart';
import '../../../domain/parcel/model/merchant_info_model.dart';
import '../../../domain/parcel/model/regular_charge_model.dart';
import '../../../domain/parcel/model/regular_parcel_info_model.dart';
import '../../widgets/widgets.dart';
import '../widgets/create_parcel_end_drawer.dart';
import 'sections/address_info_section.dart';
import 'sections/customer_info_section.dart';
import 'sections/delivery_info_section.dart';
import 'sections/merchant_info_section.dart';
import 'sections/update_parcel_warning_section.dart';

class AddSingleParcelScreen extends HookConsumerWidget {
  static const route = '/add-single-parcel';

  final ParcelModel? parcel;

  const AddSingleParcelScreen({super.key, this.parcel});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);
    final myShops = ref.watch(getMyShopsProvider);

    final formKey = useMemoized<GlobalKey<FormState>>(GlobalKey.new);
    final scaffoldKey = useMemoized<GlobalKey<ScaffoldState>>(GlobalKey.new);

    final selectedShop =
        useState<MyShopModel?>(myShops.asData?.value.firstOrNull);

    final nameController =
        useTextEditingController(text: parcel?.customerInfo.name);
    final merchantInfoController =
        useTextEditingController(text: parcel?.regularParcelInfo.instruction);
    final phoneController =
        useTextEditingController(text: parcel?.customerInfo.phone);
    final addressController =
        useTextEditingController(text: parcel?.customerInfo.address);
    final invoiceController =
        useTextEditingController(text: parcel?.regularParcelInfo.invoiceId);
    final productPriceController = useTextEditingController(
        text: parcel?.regularParcelInfo.productPrice.toString());
    final cashController = useTextEditingController(
        text: parcel?.regularPayment.cashCollection.toString());
    final descriptionController =
        useTextEditingController(text: parcel?.regularParcelInfo.details);

    final nameFocus = useFocusNode();
    final phoneFocus = useFocusNode();
    final addressFocus = useFocusNode();
    final invoiceFocus = useFocusNode();
    final productPriceFocus = useFocusNode();
    final cashFocus = useFocusNode();
    final descriptionFocus = useFocusNode();

    //  ----- Area ------
    final selectedDistrict = useState<AreaModel?>(null);
    final selectedArea = useState<AreaModel?>(null);

    //  ----- Material Type ------
    final selectedMaterialType = useState<ParcelMaterialType>(
        parcel?.regularParcelInfo.materialType ?? ParcelMaterialType.values[0]);

    //  ----- Weight ------
    final selectedWeight = useState<WeightModel?>(null);
    final selectedWeightText =
        useState<String>(selectedWeight.value?.name ?? '');
    final selectedWeightCharge = useState(parcel?.regularPayment.weightCharge);
    final selectedParcelCategory = useState<ParcelCategoryModel?>(null);

    //  ----- Delivery ------
    final deliveryCharge =
        useState(parcel?.regularPayment.deliveryCharge ?? 0.0);
    final codCharge = useState(parcel?.regularPayment.codCharge ?? 0);
    final codPercentage = useState(0.0);

    void getDeliveryCharge() {
      if (selectedShop.value == null) {
        deliveryCharge.value = 0;
      } else if (selectedShop.value!.district.id == DistrictArea.inside.id &&
          selectedDistrict.value?.id == DistrictArea.subside.id) {
        deliveryCharge.value = state.user.regularCharge.subside;
      } else if (selectedShop.value!.district.id == DistrictArea.subside.id &&
          selectedDistrict.value?.id == DistrictArea.inside.id) {
        deliveryCharge.value = state.user.regularCharge.subside;
      } else if (selectedShop.value!.district.id ==
          selectedDistrict.value?.id) {
        deliveryCharge.value = state.user.regularCharge.inside;
      } else {
        deliveryCharge.value = state.user.regularCharge.outside;
      }
      log('deliveryCharge: $deliveryCharge');
    }

    void calculateCod() {
      codCharge.value = ((int.tryParse(cashController.text) ?? 0) / 100) *
          codPercentage.value;
      log('codCharge: $codCharge');
    }

    void getWeight() {
      if (selectedShop.value == null) {
      } else if (selectedShop.value!.district.id == DistrictArea.inside.id &&
          selectedDistrict.value?.id == DistrictArea.subside.id) {
        selectedWeightCharge.value = selectedWeight.value?.subSidePrice ?? 0;
      } else if (selectedShop.value!.district.id == DistrictArea.subside.id &&
          selectedDistrict.value?.id == DistrictArea.inside.id) {
        selectedWeightCharge.value = selectedWeight.value?.subSidePrice ?? 0;
      } else if (selectedShop.value!.district.id ==
          selectedDistrict.value?.id) {
        selectedWeightCharge.value = selectedWeight.value?.insidePrice ?? 0;
      } else {
        selectedWeightCharge.value = selectedWeight.value?.outSidePrice ?? 0;
      }
      log('selectedWeightCharge: $selectedWeightCharge');
    }

    void getCodCharge() {
      if (selectedShop.value == null) {
      } else if (selectedShop.value!.district.id == DistrictArea.inside.id &&
          selectedDistrict.value?.id == DistrictArea.subside.id) {
        codPercentage.value = state.user.codCharge.subside;
      } else if (selectedShop.value!.district.id == DistrictArea.subside.id &&
          selectedDistrict.value?.id == DistrictArea.inside.id) {
        codPercentage.value = state.user.codCharge.subside;
      } else if (selectedShop.value!.district.id ==
          selectedDistrict.value?.id) {
        codPercentage.value = state.user.codCharge.inside;
      } else {
        codPercentage.value = state.user.codCharge.outside;
      }
      log('codPercentage: $codPercentage');
    }

    ref.listen(parcelProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
      }
    });

    Future<void> setDistrict() async {
      final districts = await ref.read(parcelProvider.notifier).getDistrict();
      selectedDistrict.value = districts.lock
          .where((e) => e.id == parcel!.customerInfo.district.id)
          .firstOption
          .toNullable();
    }

    Future<void> setArea() async {
      final areas = await ref
          .read(parcelProvider.notifier)
          .getArea(parcel!.customerInfo.district.id);
      selectedArea.value = areas.lock
          .where((e) => e.id == parcel!.customerInfo.area.id)
          .firstOption
          .toNullable();
    }

    Future<void> setWeight() async {
      final weights = await ref.read(parcelProvider.notifier).getWeight();
      selectedWeight.value = weights.lock
          .where((e) => e.name == parcel!.regularParcelInfo.weight)
          .firstOption
          .toNullable();
    }

    Future<void> setCategory() async {
      final categories =
          await ref.read(parcelProvider.notifier).getParcelCategory();
      selectedParcelCategory.value = categories.lock
          .where((e) => e.name == parcel!.regularParcelInfo.category)
          .firstOption
          .toNullable();
    }

    Future<void> setShop() async {
      final shops = await ref.read(getMyShopsProvider.future);
      selectedShop.value = shops.firstOrNull;
    }

    useEffect(() {
      Future.delayed(const Duration(seconds: 4), () {
        log(parcel?.toJson() ?? "");
        log(selectedWeightCharge.toString());
      });
      parcel != null
          ? Future.wait(
              [
                setShop(),
                setDistrict(),
                setArea(),
                setWeight(),
                setCategory(),
              ],
            )
          : setShop();

      // on District Change
      selectedDistrict.addListener(getDeliveryCharge);
      selectedDistrict.addListener(getWeight);
      selectedDistrict.addListener(getCodCharge);
      selectedDistrict.addListener(calculateCod);
      // on Shop Change
      selectedShop.addListener(getDeliveryCharge);
      selectedShop.addListener(getWeight);
      selectedShop.addListener(getCodCharge);
      selectedShop.addListener(calculateCod);
      // selectedWeightCharge.addListener(getDeliveryCharge);
      cashController.addListener(calculateCod);
      selectedWeight.addListener(getWeight);

      return () {
        BotToast.closeAllLoading();

        selectedDistrict.removeListener(getDeliveryCharge);
        selectedDistrict.removeListener(getWeight);
        selectedDistrict.removeListener(getCodCharge);

        selectedShop.removeListener(getDeliveryCharge);
        selectedShop.removeListener(getWeight);
        selectedShop.removeListener(getCodCharge);

        selectedDistrict.removeListener(calculateCod);
        selectedShop.removeListener(calculateCod);
        cashController.removeListener(calculateCod);

        selectedWeight.removeListener(getWeight);
      };
    }, []);

    return Scaffold(
      key: scaffoldKey,
      appBar: KAppBar(
        titleText: parcel != null
            ? AppStrings.updateParcel
            : AppStrings.createNewParcel,
        actions: [Container()],
      ),
      endDrawer: CreateParcelEndDrawer(
        scaffoldKey: scaffoldKey,
        selectedShop: selectedShop.value,
        myShops: myShops.asData?.value ?? IList(),
        onTap: (shop) => selectedShop.value = shop,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: padding16,
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              // 'deliveryCharge: ${deliveryCharge.value}'.text.make(),
              // 'selectedWeightCharge: ${selectedWeightCharge.value}'.text.make(),
              // 'codPercentage: ${codPercentage.value}'.text.make(),
              // 'codCharge: ${codCharge.value}'.text.make(),
              // show warning for edit
              UpdateParcelWarningSection(isEditable: parcel == null),

              //  Merchant-------------------

              MerchantInfoSection(
                scaffoldKey: scaffoldKey,
                isEditable: parcel == null,
                myShops: myShops,
                selectedShop: selectedShop,
                merchantInfoController: merchantInfoController,
                nameFocus: nameFocus,
              ),

              gap16,

              //  Customer Information--------
              CustomerInfoSection(
                isEditable: parcel == null,
                nameController: nameController,
                nameFocus: nameFocus,
                phoneFocus: phoneFocus,
                phoneController: phoneController,
              ),

              gap16,

              //   address Information-----------
              AddressInfoSection(
                isEditable: parcel == null,
                selectedDistrict: selectedDistrict,
                selectedArea: selectedArea,
                addressController: addressController,
                addressFocus: addressFocus,
              ),

              gap16,

              //  delivery Information-----------
              DeliveryInfoSection(
                isEditable: parcel == null,
                invoiceController: invoiceController,
                invoiceFocus: invoiceFocus,
                productPriceFocus: productPriceFocus,
                selectedWeight: selectedWeight,
                selectedWeightText: selectedWeightText,
                productPriceController: productPriceController,
                cashFocus: cashFocus,
                selectedMaterialType: selectedMaterialType,
                selectedParcelCategory: selectedParcelCategory,
                cashController: cashController,
                descriptionFocus: descriptionFocus,
                descriptionController: descriptionController,
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
                      amount: (selectedWeightCharge.value ?? 0).toString(),
                    ),
                  ],
                ),
              ),
              gap16,

              //  Create Parcel Button----------

              Visibility(
                visible: parcel == null,
                replacement: KFilledButton(
                  text: AppStrings.updateParcel,
                  onPressed: () async {
                    final paymentInfo = RegularPaymentModel(
                      cashCollection:
                          double.tryParse(cashController.text) ?? 0.0,
                      deliveryCharge: deliveryCharge.value,
                      codCharge: codCharge.value,
                      weightCharge:
                          (selectedWeight.value?.insidePrice ?? 0).toDouble(),
                      totalCharge: deliveryCharge.value +
                          codCharge.value +
                          (selectedWeight.value?.insidePrice ?? 0).toDouble(),
                    );
                    await ref
                        .read(parcelProvider.notifier)
                        .updateParcel(
                            parcel!.id,
                            UpdateParcelBody(
                                customerPhone: phoneController.text,
                                regularPayment: paymentInfo))
                        .then((value) => value ? context.pop() : null);
                  },
                ),
                child: KFilledButton(
                  text: AppStrings.createParcel,
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.requestFocus();
                    if (selectedShop.value == null) {
                      showErrorToast("Please select a shop!");
                    } else if (formKey.currentState!.validate()) {
                      final paymentInfo = RegularPaymentModel(
                        cashCollection:
                            double.tryParse(cashController.text) ?? 0.0,
                        deliveryCharge: deliveryCharge.value,
                        codCharge: codCharge.value,
                        weightCharge:
                            (selectedWeight.value?.insidePrice ?? 0).toDouble(),
                        totalCharge: deliveryCharge.value +
                            codCharge.value +
                            (selectedWeight.value?.insidePrice ?? 0).toDouble(),
                      );

                      await ref
                          .read(parcelProvider.notifier)
                          .createParcel(
                            CreateParcelBody(
                              merchantInfo: MerchantInfoModel(
                                name: ref.watch(authProvider).user.name,
                                phone: ref.watch(authProvider).user.phone,
                                address: selectedShop.value?.address ?? "",
                                shopName: selectedShop.value?.shopName ?? "",
                                districtId: selectedDistrict.value?.id ?? '',
                                areaId: selectedArea.value?.id ?? '',
                                area: AreaModel.init(),
                                district: AreaModel.init(),
                              ),
                              customerInfo: CustomerInfoModel(
                                name: nameController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                                districtId: selectedDistrict.value?.id ?? "",
                                areaId: selectedArea.value?.id ?? "",
                                district: AreaModel.init(),
                                area: AreaModel.init(),
                              ),
                              regularParcelInfo: RegularParcelInfoModel(
                                invoiceId: invoiceController.text,
                                weight: selectedWeight.value?.name ?? "",
                                productPrice:
                                    int.tryParse(productPriceController.text) ??
                                        0,
                                materialType: selectedMaterialType.value,
                                category:
                                    selectedParcelCategory.value?.name ?? "",
                                details: descriptionController.text,
                                instruction: merchantInfoController.text,
                              ),
                              regularPayment: paymentInfo,
                            ),
                          )
                          .then((value) => value.isNotBlank
                              ? context.replace("${InvoiceScreen.route}/$value")
                              : null);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

bool? showSuccessDialog(
  BuildContext context, {
  required Function() onTapTruck,
  required Function() onTapCreate,
  required Function() onTapCancel,
}) {
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
              radius: 72.r,
              child: CircleAvatar(
                backgroundColor:
                    context.colors.primary.lighten().withOpacity(.4),
                radius: 62.r,
                child: CircleAvatar(
                  backgroundColor:
                      context.colors.primary.lighten().withOpacity(.6),
                  radius: 52.r,
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
            AppStrings.yourParcelHasBeenCreatedSuccessfully.text.lg.bold.center
                .make()
                .objectCenter(),
            gap6,
            AppStrings.youCanTruckYourParcel("5YE339XX19NINTXI")
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
                      text: AppStrings.createAnother,
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      foregroundColor: ColorPalate.secondary,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        onTapCreate.call();
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
                        onTapTruck.call();
                        cancelFunc.call();
                      },
                    ),
                  ),
                ],
              ),
            ),
            gap8,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: KFilledButton(
                text: AppStrings.cancel,
                isSecondary: true,
                foregroundColor: ColorPalate.black800,
                textStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorPalate.black,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {
                  onTapCancel.call();
                  cancelFunc.call();
                },
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
