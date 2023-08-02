import 'package:bot_toast/bot_toast.dart';
import 'package:courier_merchent_app/application/auth/auth_provider.dart';
import 'package:courier_merchent_app/presentation/widgets/k_user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../application/home/home_provider.dart';
import '../../utils/utils.dart';
import 'widgets/search_delivery.dart';

class HomeScreen extends HookConsumerWidget {
  static String route = "/home";
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    ref.listen(homeProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
      }
    });

    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: CustomScrollView(
          slivers: [
            const CustomSliverAppBar(),
            // SliverGap(12.h),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 0.25.sh,
                child: Image.asset(
                  Images.homeBanner,
                  fit: BoxFit.contain,
                ),
              )
                  .p16()
                  .box
                  // .color(ColorPalate.primary.darken())
                  .bottomRounded(value: 28.r)
                  .make(),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSliverAppBar extends HookConsumerWidget {
  const CustomSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(authProvider);
    return SliverAppBar(
      pinned: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: context.colors.primary,
      toolbarHeight: kToolbarHeight + 40.h,
      title: Column(
        crossAxisAlignment: crossStart,
        children: [
          gap12,
          Row(
            children: [
              DateTime.now()
                  .toIso8601String()
                  .toDateString()
                  .text
                  .caption(context)
                  .semiBold
                  .color(ColorPalate.bg200)
                  .make(),
              const Icon(BoxIcons.bx_chevron_down)
            ],
          ),
          gap4,
          state.user.name.text.bold.xl2.make(),
        ],
      ),
      actions: [
        Column(
          mainAxisAlignment: mainCenter,
          children: [
            gap16,
            const KUserAvatar(
              enableBorder: true,
              bgColor: ColorPalate.bg200,
            ),
          ],
        ).pOnly(right: 12.w),
      ],
      bottom: const SearchDelivery()
          .p16()
          .box
          .colorPrimary(context)
          .bottomRounded()
          .make()
          .preferredSize(
            const Size.fromHeight(kToolbarHeight),
          ),
    ).darkTheme();
  }
}
