import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_merchent_app/application/auth/auth_provider.dart';
import 'package:courier_merchent_app/presentation/home/widgets/home_app_bar.dart';
import 'package:courier_merchent_app/presentation/home/widgets/search_delivery.dart';
import 'package:courier_merchent_app/utils/utils.dart';

import '../../application/home/home_provider.dart';
import '../widgets/widgets.dart';
import 'widgets/service_section.dart';

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
      appBar: const HomeAppBar(),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          padding: padding16,
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
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
              KListViewSeparated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gap: 16,
                padding: padding0,
                itemBuilder: (context, index) {
                  return const DeliveryListTile(
                    customerName: "Evan Hossain",
                    address:
                        "169/B, North Konipara, Tejgoan, Dhaka, Bangladesh",
                    distance: "3 kms",
                  );
                },
                itemCount: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
