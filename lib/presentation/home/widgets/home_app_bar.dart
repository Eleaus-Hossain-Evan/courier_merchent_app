import 'package:courier_merchent_app/application/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../application/home/home_provider.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class HomeAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(homeProvider);
    final authState = ref.watch(authProvider);

    return KAppBar(
      // backgroundColor: Colors.blue,
      title: Column(
        crossAxisAlignment: crossStart,
        mainAxisAlignment: mainEnd,
        children: [
          gap10,
          Row(
            children: [
              "${DateTime.now()}".toDateString().text.caption(context).make(),
              const Icon(BoxIcons.bx_chevron_down)
            ],
          ),
          gap4,
          "HI, ${authState.user.name}!".text.bold.make(),
        ],
      ),
      // leading: Padding(
      //   padding: EdgeInsets.all(4.w),
      //   child: KUserAvatar(
      //     imgUrl: ref.watch(authProvider).user.image,
      //     enableBorder: true,
      //     radius: 20.r,
      //   ),
      // ),
      centerTitle: false,
      actions: [
        // IconButton(
        //   onPressed: () {
        //     GoRouter.of(context).push(NotificationScreen.route);
        //   },
        //   icon: Badge(
        //     isLabelVisible: state.notification,
        //     child: const Icon(Icons.notifications_outlined),
        //   ),
        // ),
        Column(
          mainAxisAlignment: mainCenter,
          children: [
            gap10,
            KUserAvatar(imgUrl: authState.user.image),
          ],
        ),
        gap12,
      ],
    ).box.red400.make();
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 30.h);
}
