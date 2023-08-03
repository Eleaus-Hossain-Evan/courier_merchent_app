import 'package:courier_merchent_app/application/auth/auth_provider.dart';
import 'package:courier_merchent_app/presentation/widgets/k_cached_network_image.dart';
import 'package:courier_merchent_app/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(authProvider);

    return SafeArea(
      child: SizedBox(
        width: 1.sw,
        child: Row(
          crossAxisAlignment: crossEnd,
          children: [
            const Icon(BoxIcons.bxs_map)
                .iconColor(context.colors.primary)
                .p12()
                .box
                .rounded
                .color(context.colors.primary.withOpacity(.1))
                .make(),
            gap16,
            Expanded(
              child: Column(
                crossAxisAlignment: crossStart,
                mainAxisAlignment: mainEnd,
                children: [
                  "Your Location".text.caption(context).make(),
                  "authState.user.address, nikujo 1, road 7, Khilkhet, Dhaka."
                      .text
                      .bold
                      .xl
                      .ellipsis
                      .make(),
                ],
              ),
            ),
            gap18,
            Container(
              width: 52.w,
              height: 52.w,
              padding: padding2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: context.colors.primary,
                ),
              ),
              child: KCachedNetworkImageWdLoading(
                imageUrl: authState.user.image,
                borderRadius: BorderRadius.circular(16.r),
              ),
            )
          ],
        ),
      ),
    ).px16();
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 18.h);
}
