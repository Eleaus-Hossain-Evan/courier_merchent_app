import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/home/home_provider.dart';
import '../../domain/profile/get_area_model_response.dart';
import '../../utils/utils.dart';
import 'widgets/home_app_bar.dart';

class HomeScreen extends HookConsumerWidget {
  static String route = "/home";
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final selectedDistrict = useState<AreaModel?>(null);
    final areaEnable = useState(false);
    final selectedArea = useState<AreaModel?>(null);

    selectedDistrict.addListener(() {
      log(selectedDistrict.value!.name);
    });
    selectedArea.addListener(() {
      log(selectedArea.value!.name);
    });
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
          controller: scrollController,
          padding: padding16,
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              SizedBox(height: 20.h),
              const Text(
                "Welcome to",
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              gap24,
              // KDropDownSelectWidget(
              //     exampleData: exampleData3, selectedC: selectedC),
              // gap16,
            ],
          ),
        ),
      ),
    );
  }
}
