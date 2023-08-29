import 'package:bot_toast/bot_toast.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_merchent_app/application/auth/auth_provider.dart';
import 'package:courier_merchent_app/domain/auth/add_shop_body.dart';
import 'package:courier_merchent_app/domain/auth/model/shop_model.dart';

import '../../../application/parcel/parcel_provider.dart';
import '../../../application/shop/shop_provider.dart';
import '../../../domain/auth/model/area_model.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class MyShopScreen extends HookConsumerWidget {
  static const route = '/my-shop';

  const MyShopScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getMyShopsProvider);

    final loading = useState(false);

    final refreshController = useMemoized(
        () => RefreshController(initialLoadStatus: LoadStatus.canLoading));

    ref.listen(authProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
        loading.value = true;
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
        loading.value = false;
      }
    });

    useEffect(() {
      // Future.microtask(() => ref.read(authProvider.notifier).getMyShop());

      return () => BotToast.closeAllLoading();
    }, const []);

    return CustomScaffold(
      appBar: const KAppBarBGTransparent(
        titleText: AppStrings.myShop,
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async {
          await ref
              .refresh(getMyShopsProvider.future)
              .then((_) => refreshController.refreshCompleted());
        },
        // header: const MaterialHeader(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 150.h),
          child: Column(
            children: [
              state.when(
                data: (data) => ContainerBGWhiteSlideFromRight(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Bootstrap.shop),
                          gap12,
                          "My Shops".text.lg.semiBold.make().objectCenterLeft(),
                        ],
                      ),
                      Visibility(
                        visible: data.isNotEmpty,
                        replacement: "No Shop added yet!"
                            .text
                            .caption(context)
                            .make()
                            .p24(),
                        child: KListViewSeparated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: padding0,
                          itemBuilder: (context, index) {
                            final shop = data[index];
                            return Column(
                              crossAxisAlignment: crossStart,
                              children: [
                                ListTile(
                                  title: shop.shopName.text.semiBold.make(),
                                  subtitle: shop.address.text.make(),
                                  dense: true,
                                  style: ListTileStyle.drawer,
                                  enableFeedback: true,
                                  tileColor: context.colors.primaryContainer,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16.w)
                                          .copyWith(bottom: 0),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: mainMin,
                                    children: [
                                      IconButton.outlined(
                                        onPressed: () =>
                                            kShowBarModalBottomSheet(
                                          context: context,
                                          child: ShopModifyWidget(model: shop),
                                        ),
                                        style: IconButton.styleFrom(
                                          side: const BorderSide(
                                            width: 1,
                                            color: ColorPalate.secondary,
                                          ),
                                          padding: EdgeInsets.zero,
                                        ),
                                        icon: const Icon(
                                          FontAwesome.pen_to_square,
                                        ).iconSize(16.sp).iconColor(
                                            context.colors.secondary),
                                      ),
                                      // IconButton.filledTonal(
                                      //   onPressed: () => ref
                                      //       .read(getMyShopsProvider.notifier)
                                      //       .deleteShop(shop.id),
                                      //   icon: const Icon(EvaIcons.close)
                                      //       .iconSize(22.sp)
                                      //       .iconColor(Colors.white),
                                      // ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: shop
                                          .area.name.isNotEmptyAndNotNull ||
                                      shop.district.name.isNotEmptyAndNotNull,
                                  child: Padding(
                                    padding: paddingLeft18,
                                    child: Row(
                                      children: [
                                        shop.area.name.text.make(),
                                        Visibility(
                                          visible: shop
                                              .area.name.isNotEmptyAndNotNull,
                                          child: ", ".text.make(),
                                        ),
                                        shop.district.name.text.make()
                                      ],
                                    ),
                                  ),
                                ),
                                gap12,
                              ],
                            );
                          },
                          itemCount: data.length,
                          separator: KDivider(
                            color: ColorPalate.black200,
                            thickness: 2.h,
                          ),
                        ),
                      ),
                      KOutlinedButton(
                        text: "Add Shop",
                        isSecondary: false,
                        onPressed: () {
                          kShowBarModalBottomSheet(
                            context: context,
                            child: const ShopModifyWidget(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // data: (data) => const ShopShimmer(),
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => ShopShimmer(length: state.value?.length ?? 3),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShopModifyWidget extends HookConsumerWidget {
  const ShopModifyWidget({
    super.key,
    this.model,
  });

  final MyShopModel? model;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController(text: model?.shopName);
    final addressController = useTextEditingController(text: model?.address);

    final selectedDistrict =
        useState<AreaModel?>(model?.district ?? AreaModel.init());
    final selectedArea = useState<AreaModel?>(model?.area ?? AreaModel.init());

    final nameFocus = useFocusNode();
    final addressFocus = useFocusNode();

    final loading = useState(false);

    void close() {
      Navigator.pop(context);
    }

    return Column(
      mainAxisSize: mainMin,
      children: [
        gap28,
        KTextFormField2(
          hintText: "Shop Name",
          controller: nameController,
          focusNode: nameFocus,
          fillColor: Colors.white,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (p0) => addressFocus.requestFocus(),
        ),
        gap24,
        KTextFormField2(
          hintText: "Shop Address",
          controller: addressController,
          focusNode: addressFocus,
          fillColor: Colors.white,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (p0) =>
              FocusManager.instance.primaryFocus?.unfocus(),
        ),
        gap24,
        KDropDownSearchWidget<AreaModel>(
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
          asyncItems: (p0) => ref.read(parcelProvider.notifier).getDistrict(),
          itemAsString: (p0) => p0.name,
          compareFn: (p0, p1) => p0.id == p0.id,
          contentPadding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
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
        gap24,
        KDropDownSearchWidget<AreaModel?>(
          hintText: AppStrings.selectArea,
          selectedItem: selectedArea.value ?? AreaModel.init(),
          popupProps: const PopupProps.dialog(
            showSearchBox: true,
            searchDelay: Duration(milliseconds: 400),
            fit: FlexFit.loose,
            dialogProps: DialogProps(
              backgroundColor: ColorPalate.bg200,
            ),
          ),
          enabled: selectedDistrict.value != null &&
              selectedDistrict.value!.id.isNotBlank,
          asyncItems: (p0) => ref
              .read(parcelProvider.notifier)
              .getArea(selectedDistrict.value?.id ?? ''),
          itemAsString: (p0) => p0?.name ?? '',
          compareFn: (p0, p1) => identical(p0?.name ?? "", p0?.name ?? ""),
          contentPadding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
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
        gap24,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: KFilledButton(
            text: model == null ? "Add" : "Update",
            isSecondary: false,
            loading: loading.value,
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              loading.value = true;
              if (model == null) {
                await ref.read(getMyShopsProvider.notifier).addMyShop(
                      AddShopBody(
                        shopName: nameController.text,
                        address: addressController.text,
                        areaId: selectedArea.value?.id ?? "",
                        districtId: selectedDistrict.value?.id ?? "",
                      ),
                    );
              } else {
                await ref.read(getMyShopsProvider.notifier).updateShop(
                    model: AddShopBody(
                      shopName: nameController.text,
                      address: addressController.text,
                      areaId: selectedArea.value!.id,
                      districtId: selectedDistrict.value!.id,
                    ),
                    id: model!.id);
              }
              loading.value = false;

              close();
              // cancelFun.call();
            },
          ),
        ),
        gap28,
      ],
    );
  }
}

class ShopShimmer extends StatelessWidget {
  const ShopShimmer({
    Key? key,
    this.length = 3,
  }) : super(key: key);

  final int length;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.only(top: 8.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: padding20,
            child: Column(
              children: [
                Row(
                  children: [
                    KShimmerContainer(
                      height: 40.h,
                      width: 40.w,
                    ),
                    gap12,
                    KShimmerContainer(
                      height: 40.h,
                    ).flexible(),
                  ],
                ),
                ...List.generate(
                  length,
                  (index) => Padding(
                    padding: padding16,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const KShimmerContainer(
                              height: 40,
                            ).flexible(),
                            gap12,
                            const CircleAvatar(),
                            // gap12,
                            // const CircleAvatar(),
                          ],
                        ),
                        gap6,
                        Padding(
                          padding: EdgeInsets.only(right: 78.w),
                          child: KShimmerContainer(height: 20.h),
                        ),
                        gap16,
                      ],
                    ),
                  ),
                ),
                const KOutlinedButton(
                  text: "Add Shop",
                  // foregroundColor: ColorPalate.black,
                  onPressed: null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
