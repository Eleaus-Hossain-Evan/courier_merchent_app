import 'package:courier_merchent_app/domain/parcel/model/parcel_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';
import '../widgets/widgets.dart';
import 'widgets/pdf_widget.dart';

class InvoiceScreen extends HookConsumerWidget {
  static const route = '/invoice';

  const InvoiceScreen({
    super.key,
    required this.parcelModel,
  });

  final ParcelModel parcelModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const KAppBar(
        titleText: 'Invoice',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            gap16,
            Row(
              mainAxisAlignment: mainCenter,
              children: [
                Icon(
                  Icons.check,
                  color: context.theme.scaffoldBackgroundColor,
                  size: 16.sp,
                ).circle(
                  backgroundColor: context.colors.primary,
                  radius: 28.r,
                ),
                gap4,
                "Your parcel request successfully placed".text.bold.lg.make(),
              ],
            ),
            gap16,
            Text.rich(
              TextSpan(
                children: [
                  "Parcel ID ".textSpan.make(),
                  parcelModel.serialId.textSpan.semiBold.make(),
                  "will be picked up by our deliveryman soon!".textSpan.make()
                ],
              ),
            ).px16(),
            gap8,
            "Download the label below and paste on the top of your parcel"
                .text
                .italic
                .center
                .blue500
                .make()
                .px16(),
            gap16,
            SizedBox(height: 600, child: PDFWidget(parcel: parcelModel)),
          ],
        ),
      ),
    );
  }
}
