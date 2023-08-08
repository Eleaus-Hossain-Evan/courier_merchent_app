import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_merchent_app/application/auth/auth_provider.dart';
import 'package:courier_merchent_app/domain/auth/add_shop_body.dart';
import 'package:courier_merchent_app/domain/auth/model/shop_model.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class MyShopScreen extends HookConsumerWidget {
  static const route = '/my-shop';

  const MyShopScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    final loading = useState(false);

    ref.listen(authProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        // BotToast.showLoading();
        loading.value = true;
      }
      if (previous.loading == true && next.loading == false) {
        // BotToast.closeAllLoading();
        loading.value = false;
      }
    });

    useEffect(() {
      Future.microtask(() => ref.read(authProvider.notifier).getMyShop());

      return () => BotToast.closeAllLoading();
    }, const []);

    return CustomScaffold(
      appBar: const KAppBarBGTransparent(
        titleText: AppStrings.myShop,
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
                          title: shop.shopName.text.semiBold.make(),
                          subtitle: shop.address.text.make(),
                          dense: true,
                          style: ListTileStyle.drawer,
                          enableFeedback: true,
                          tileColor: context.colors.primaryContainer,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          trailing: Row(
                            mainAxisSize: mainMin,
                            children: [
                              IconButton.outlined(
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) =>
                                      ShopModifyWidget(model: shop),
                                ),
                                icon: const Icon(FontAwesome.pen_to_square)
                                    .iconSize(16.sp),
                              ),
                              IconButton.filledTonal(
                                onPressed: () => ref
                                    .read(authProvider.notifier)
                                    .deleteShop(shop.id),
                                icon: const Icon(EvaIcons.close)
                                    .iconSize(22.sp)
                                    .iconColor(Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: state.user.myShops.length,
                    ),
                  ),
                  KOutlinedButton(
                    text: "Add Shop",
                    // foregroundColor: ColorPalate.black,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (cancelFun) => const ShopModifyWidget(),
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

    final nameFocus = useFocusNode();
    final addressFocus = useFocusNode();

    final loading = useState(false);

    void close() {
      Navigator.pop(context);
    }

    return Dialog(
      backgroundColor: Colors.white,
      child: Column(
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: KFilledButton(
              text: model == null ? "Add" : "Update",
              isSecondary: false,
              loading: loading.value,
              onPressed: () async {
                loading.value = true;
                if (model == null) {
                  await ref.read(authProvider.notifier).addMyShop(
                        AddShopBody(
                          shopName: nameController.text,
                          address: addressController.text,
                        ),
                      );
                } else {
                  await ref.read(authProvider.notifier).updateShop(model!
                      .copyWith(
                          shopName: nameController.text,
                          address: addressController.text));
                }
                loading.value = false;

                close();
                // cancelFun.call();
              },
            ),
          ),
          gap28,
        ],
      ),
    );
  }
}
