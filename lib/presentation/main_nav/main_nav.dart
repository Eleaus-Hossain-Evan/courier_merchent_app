import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../application/auth/auth_provider.dart';
import '../../utils/utils.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

final bottomNavigatorKey = GlobalKey();

class MainNav extends HookConsumerWidget {
  static const route = '/main_nav';

  const MainNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navIndex = useState(0);
    final navWidget = [
      const HomeScreen(),
      const Text("page2"),
      const Text("page3"),
      const ProfileScreen(),
    ];

    useEffect(() {
      Future.microtask(() => ref.read(authProvider.notifier).profileView());

      return () => Logger.i("app exit");
    }, const []);

    return LayoutBuilder(
      builder: (context, constrain) {
        return Scaffold(
          body: navWidget[navIndex.value],
          bottomNavigationBar: NavigationBar(
            backgroundColor: ColorPalate.bg200,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            key: bottomNavigatorKey,
            selectedIndex: navIndex.value,
            onDestinationSelected: (index) {
              navIndex.value = index;
            },
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.home_filled,
                  color: navIndex.value == 0
                      ? context.colors.primary
                      : ColorPalate.black600,
                ),
                label: AppStrings.home,
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.delivery_dining,
                  color: navIndex.value == 1
                      ? context.colors.primary
                      : ColorPalate.black600,
                ),
                label: AppStrings.delivery,
              ),
              NavigationDestination(
                icon: const Icon(
                  Icons.notifications_active_outlined,
                  color: ColorPalate.black600,
                ),
                selectedIcon: Icon(
                  Icons.notifications_active_rounded,
                  color: context.colors.primary,
                ),
                label: AppStrings.notifications,
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.account_box_rounded,
                  color: navIndex.value == 3
                      ? context.colors.primary
                      : ColorPalate.black600,
                ),
                label: AppStrings.profile,
              ),
            ],
          ).box.shadowSm.make(),
        );
      },
    );
  }
}
