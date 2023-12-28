import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_merchent_app/application/auth/auth_provider.dart';

import '../../../domain/auth/model/charge_model.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ChargeScreen extends HookConsumerWidget {
  static const route = '/change';

  const ChargeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);
    return CustomScaffold(
      appBar: const KAppBarBGTransparent(
        titleText: 'Charge',
      ),
      body: SingleChildScrollView(
        padding: paddingH16.copyWith(top: 100.h),
        child: Column(
          children: [
            SizedBox(
              height: 80.h,
              child: WarningSection(
                text: Text.rich(
                  'For update the '
                      .textSpan
                      .withChildren([
                        'CHARGE'.textSpan.bold.italic.make(),
                        ' contact with admin.'.textSpan.make(),
                      ])
                      .color(ColorPalate.warning)
                      .titleSmall(context)
                      .make(),
                ),
              ),
            ),
            gap16,
            ContainerBGWhiteSlideFromRight(
              child: Column(
                children: [
                  ChargeSection(
                    title: "Regular Charge",
                    charge: state.user.regularCharge,
                  ),
                  gap16,
                  ChargeSection(
                    title: "Return Charge",
                    charge: state.user.returnCharge,
                  ),
                  gap16,
                  ChargeSection(
                    title: "COD Charge",
                    charge: state.user.codCharge,
                  ),
                  gap16,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChargeSection extends StatelessWidget {
  const ChargeSection({
    Key? key,
    required this.title,
    required this.charge,
  }) : super(key: key);

  final String title;
  final ChargeModel charge;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title.text.lg.semiBold.make().objectCenterLeft(),
        gap16,
        ChargeTable(
          inside: charge.inside,
          outside: charge.outside,
          subside: charge.subside,
        ),
      ],
    );
  }
}

class ChargeTable extends StatelessWidget {
  const ChargeTable({
    Key? key,
    required this.inside,
    required this.subside,
    required this.outside,
  }) : super(key: key);

  final double inside;
  final double subside;
  final double outside;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: const BoxDecoration(color: ColorPalate.bg200),
          children: [
            "Inside".text.bold.makeCentered(),
            "Subside".text.bold.makeCentered(),
            "Outside".text.bold.makeCentered(),
          ],
        ),
        TableRow(
          children: [
            inside.text.makeCentered(),
            subside.text.makeCentered(),
            outside.text.makeCentered(),
          ],
        ),
      ],
    );
  }
}
