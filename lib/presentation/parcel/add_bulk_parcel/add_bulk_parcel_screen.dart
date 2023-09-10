import 'package:courier_merchent_app/application/home/home_provider.dart';
import 'package:courier_merchent_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/widgets.dart';

class AddBulkParcelScreen extends HookConsumerWidget {
  static const route = '/add-bulk-parcel';

  const AddBulkParcelScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const KAppBar(
        titleText: 'Create Multiple Parcel',
      ),
      body: SingleChildScrollView(
        padding: padding16,
        child: Column(
          children: [
            ContainerBGWhiteSlideFromRight(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: Row(
                children: [
                  Logo(
                    Logos.microsoft_excel,
                    size: 16.sp,
                  ),
                  gap8,
                  "Download Sample Format...".text.blue600.lg.make().expand(),
                  SizedBox(
                    width: 62.w,
                    child: KTextButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(APIRoute.BASE_URL +
                            ref.read(homeProvider).value!.data.bulkExcel);

                        if (await canLaunchUrl(url)) {
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        }

                        // final inLunch = await canLaunchUrl(url);
                        // Logger.i('inLunch: $inLunch');
                      },
                      child: const Icon(Bootstrap.cloud_download_fill),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
