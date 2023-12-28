import 'package:bot_toast/bot_toast.dart';
import 'package:courier_merchent_app/application/parcel/parcel_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../application/home/home_provider.dart';
import '../../utils/utils.dart';
import 'widgets/dashboard_section.dart';
import 'widgets/recent_parcel_section.dart';
import 'widgets/search_delivery.dart';
import 'widgets/service_section.dart';

class HomeScreen extends HookConsumerWidget {
  static String route = "/home";
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshController = useMemoized(
        () => RefreshController(initialLoadStatus: LoadStatus.canLoading));

    final isDashboard = useState(false);
    final isDashboardVisible = useState(false);

    ref.listen(homeProvider, (previous, next) {
      if (previous!.isLoading == false && next.isLoading) {
        BotToast.showLoading();
      }
      if (previous.isLoading == true && next.isLoading == false) {
        BotToast.closeAllLoading();
      }
    });

    useEffect(() {
      Logger.w("${context.screenWidth}, ${context.screenHeight}");
      // Future.microtask(() => ref.read(authProvider.notifier).profileView());
      return () => BotToast.closeAllLoading();
    }, const []);

    isDashboard.addListener(() {
      if (isDashboard.value == false) {
        isDashboardVisible.value = false;
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {
          isDashboardVisible.value = true;
        });
      }
    });

    return Scaffold(
      // appBar: const HomeAppBar(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Images.iconObjectScan.assetSvg(
      //     width: 24.w,
      //     height: 24.h,
      //     color: Colors.white,
      //   ),
      // ),
      body: SafeArea(
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: SmartRefresher(
            controller: refreshController,

            onRefresh: () => ref
                .refresh(recentParcelProvider.future)
                .then((value) => refreshController.refreshCompleted()),

            // header: const MaterialHeader(),
            child: SingleChildScrollView(
              padding: padding16,
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  DashboardSection(
                    isDashboard: isDashboard,
                    isDashboardVisible: isDashboardVisible,
                  ),
                  gap16,
                  SearchDelivery(
                    isDashboard: isDashboard,
                    onTapDashboard: () =>
                        isDashboard.value = !isDashboard.value,
                  ),

                  gap32,

                  //?  Services section ---------------------

                  "Our Services".text.lg.bold.make(),
                  gap16,
                  const ServiceSection(),
                  gap32,

                  //?  recent parcel section ----------------
                  "Recent Parcels".text.lg.bold.make(),
                  gap16,
                  const RecentParcelSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
