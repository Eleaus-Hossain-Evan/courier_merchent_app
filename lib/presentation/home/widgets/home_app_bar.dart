import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../application/home/home_provider.dart';
import '../../../utils/utils.dart';
import '../../notification/notification_screen.dart';
import '../../widgets/widgets.dart';

class HomeAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(homeProvider);

    return KAppBar(
      title: Column(
        crossAxisAlignment: crossStart,
        children: [
          Text(
            "Evan",
            style: CustomTextStyle.textStyle14w600B600.copyWith(
              color: ColorPalate.secondary200,
            ),
          ),
          Text(
            AppStrings.welcome(""),
            style: CustomTextStyle.textStyle18w600HG1000,
          ),
        ],
      ),
      leading: Padding(
        padding: EdgeInsets.all(4.w),
        child: KCircleAvatar(
          imgUrl: "https://i.pravatar.cc/300",
          enableBorder: true,
          radius: 20.r,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).push(NotificationScreen.route);
          },
          icon: Badge(
            isLabelVisible: state.notification,
            child: const Icon(Icons.notifications_outlined),
          ),
        ),
        gap12,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
