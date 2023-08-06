import 'dart:developer';

import 'package:courier_merchent_app/application/auth/auth_provider.dart';
import 'package:courier_merchent_app/domain/auth/add_shop_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class MyShopScreen extends HookConsumerWidget {
  static const route = '/my-shop';

  const MyShopScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    final nameController = useTextEditingController();
    final addressController = useTextEditingController();

    final nameFocus = useFocusNode();
    final addressFocus = useFocusNode();

    final isUpdate = useState(false);

    useEffect(() {
      Future.microtask(() => ref.read(authProvider.notifier).getMyShop());
      return null;
    }, const []);

    return CustomScaffold(
      appBar: KAppBarBGTransparent(
        titleText: AppStrings.myShop,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 150.h),
        child: Column(
          children: [
            ContainerBGWhite(
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
                    visible: state.user.myShops.isNotEmpty,
                    replacement:
                        "No Shop added yet!".text.caption(context).make().p24(),
                    child: KListViewSeparated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: padding0,
                      itemBuilder: (context, index) {
                        final shop = state.user.myShops[index];
                        return ListTile(
                          onTap: () {
                            log("tap");
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
                  KFilledButton(
                    text: "Add Shop",
                    isSecondary: true,
                    onPressed: () {
                      kShowbarModalBottomSheet(
                        context: context,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            mainAxisSize: mainMin,
                            children: [
                              gap28,
                              KTextFormField2(
                                hintText: "Shop Name",
                                controller: nameController,
                                focusNode: nameFocus,
                              ),
                              gap24,
                              KTextFormField2(
                                hintText: "Shop Name",
                                controller: addressController,
                                focusNode: addressFocus,
                              ),
                              gap24,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: KOutlinedButton(
                                  text: "Add",
                                  isSecondary: false,
                                  onPressed: () {
                                    ref.read(authProvider.notifier).addMyShop(
                                          AddShopBody(
                                            shopName: nameController.text,
                                            address: addressController.text,
                                          ),
                                        );
                                    nameController.clear();
                                    addressController.clear();
                                    Navigator.pop(context);
                                    log(state.user.myShops.toString());
                                  },
                                ),
                              ),
                              gap28,
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
