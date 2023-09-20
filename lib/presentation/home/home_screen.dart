import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_merchent_app/application/parcel/parcel_provider.dart';

import '../../application/home/home_provider.dart';
import '../../utils/utils.dart';
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

    return Scaffold(
      // appBar: const HomeAppBar(),
      body: SafeArea(
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: SmartRefresher(
            controller: refreshController,
            // enablePullUp: true,
            // onRefresh: () => ref
            //     .refresh(homeProvider.notifier)
            //     .getRecentParcelList()
            //     .then((value) =>
            //         refreshController.refreshCompleted(resetFooterState: true)),
            onRefresh: () => ref
                .refresh(recentParcelProvider.future)
                .then((value) => refreshController.refreshCompleted()),

            // header: const MaterialHeader(),
            child: SingleChildScrollView(
              padding: padding16,
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  gap16,
                  const SearchDelivery(),
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
