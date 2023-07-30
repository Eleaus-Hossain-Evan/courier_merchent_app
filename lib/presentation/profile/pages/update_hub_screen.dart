import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class UpdateHubScreen extends HookConsumerWidget {
  static const route = '/update-hub';

  const UpdateHubScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUpdate = useState(false);
    return CustomScaffold(
      appBar: KAppBarBGTransparent(
        title: "Hub Update".text.make(),
        actions: [
          Visibility(
            // visible: !isUpdate.value,
            child: IconButton(
                onPressed: () => isUpdate.value = !isUpdate.value,
                icon: const Icon(FontAwesome.pen_to_square)
                    .iconColor(ColorPalate.white)
                    .iconSize(18.sp)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: paddingH16,
        child: Padding(
          padding: EdgeInsets.only(top: 160.h),
          child: Column(
            children: [
              ContainerBGWhite(
                padding: paddingV20,
                child: const Column(
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
