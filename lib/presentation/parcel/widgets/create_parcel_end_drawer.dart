import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../application/auth/auth_provider.dart';
import '../../../domain/auth/model/shop_model.dart';
import '../../../utils/utils.dart';
import '../../profile/pages/my_shop_screen.dart';
import '../../widgets/widgets.dart';

class CreateParcelEndDrawer extends HookConsumerWidget {
  const CreateParcelEndDrawer({
    super.key,
    this.onTap,
    required this.scaffoldKey,
    this.selectedShop,
    required this.myShops,
  });

  final Function(MyShopModel)? onTap;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final MyShopModel? selectedShop;
  final IList<MyShopModel> myShops;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(authProvider);

    final nameController = useTextEditingController(text: state.user.name);
    final emailController = useTextEditingController(text: state.user.email);
    final phoneController = useTextEditingController(text: state.user.phone);

    return Drawer(
      child: ColoredBox(
        color: ColorPalate.bg200,
        child: Padding(
          padding: padding16.copyWith(top: 42.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                "Merchant Information".text.xl.semiBold.make(),
                gap32,
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
                              .objectCenterLeft()
                              .flexible(),
                          const KUserAvatar(),
                        ],
                      ),
                      gap28,
                      KTextFormField2(
                        hintText: AppStrings.name,
                        controller: nameController,
                        isLabel: true,
                        enabled: false,
                        containerPadding: EdgeInsets.zero,
                      ),
                      gap16,
                      KTextFormField2(
                        hintText: AppStrings.email,
                        controller: emailController,
                        isLabel: true,
                        readOnly: true,
                        enabled: false,
                        containerPadding: EdgeInsets.zero,
                      ),
                      gap16,
                      KTextFormField2(
                        hintText: AppStrings.phoneNumber,
                        controller: phoneController,
                        isLabel: true,
                        readOnly: true,
                        enabled: false,
                        containerPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                gap16,
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
                          "My Shops"
                              .text
                              .lg
                              .semiBold
                              .make()
                              .objectCenterLeft()
                              .flexible(),
                          KInkWell(
                            onTap: () => context.push(MyShopScreen.route),
                            child: "Go to Shop"
                                .text
                                .caption(context)
                                .make()
                                .p8()
                                .box
                                .roundedSM
                                .border(color: context.colors.secondary)
                                .make(),
                          )
                        ],
                      ),
                      Visibility(
                        visible: myShops.isNotEmpty,
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
                            final shop = myShops[index];
                            final isSelected = shop == selectedShop;
                            return ListTile(
                              selected: isSelected,
                              onTap: () {
                                onTap?.call(shop);
                                scaffoldKey.currentState!.closeEndDrawer();
                              },
                              title: shop.shopName.text.semiBold.make(),
                              subtitle: Text.rich(
                                TextSpan(
                                  children: [
                                    shop.address.textSpan.make(),
                                    ", ".textSpan.make(),
                                    shop.area.name.textSpan.make(),
                                    shop.area.name.isNotEmptyAndNotNull
                                        ? ", ".textSpan.make()
                                        : const WidgetSpan(
                                            child: SizedBox.shrink()),
                                    shop.district.name.textSpan.make(),
                                  ],
                                ),
                              ),
                              // dense: true,
                              style: ListTileStyle.list,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          },
                          itemCount: myShops.length,
                        ),
                      ),
                    ],
                  ),
                ),
                gap16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
