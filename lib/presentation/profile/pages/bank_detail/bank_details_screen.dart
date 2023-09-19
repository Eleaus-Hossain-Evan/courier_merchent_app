import 'package:bot_toast/bot_toast.dart';
import 'package:courier_merchent_app/domain/auth/model/other_account_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pinput/pinput.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../application/auth/auth_provider.dart';
import '../../../../application/auth/auth_state.dart';
import '../../../../domain/auth/model/bank_account_model.dart';
import '../../../../domain/auth/payment_update_body.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../../widgets/otp_check.dart';

enum DefaultPayment { bank, bkash, nagad, rocket, cod }

enum PaymentStyle { perRequest, daily, weekly }

class BankDetailsScreen extends HookConsumerWidget {
  static const route = "/bank-details";
  const BankDetailsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    final bankDetail = state.user.bankAccount;

    final accHolder = useTextEditingController(text: bankDetail.accName);
    final bankName = useTextEditingController(text: bankDetail.bankName);
    final branchName = useTextEditingController(text: bankDetail.branch);
    final routingNum = useTextEditingController(text: bankDetail.routingNum);
    final accNumber = useTextEditingController(text: bankDetail.accNum);

    final otherAcc = ref.watch(authProvider).user.othersAccount;
    final bkash = useTextEditingController(text: otherAcc.bkashNum);
    final nagad = useTextEditingController(text: otherAcc.nagadNum);

    final newBankDetail = useState(bankDetail);

    final isUpdate = useState(false);

    final refreshController = useMemoized(
        () => RefreshController(initialLoadStatus: LoadStatus.canLoading));

    ref.listen<AuthState>(
      authProvider,
      (previous, next) {
        if (previous!.loading == false && next.loading) {
          BotToast.showLoading();
        } else {
          BotToast.closeAllLoading();
        }
      },
    );

    return CustomScaffold(
      appBar: KAppBarBGTransparent(
        title: AppStrings.bankDetails.text.make(),
        actions: [
          Visibility(
            visible: !isUpdate.value,
            child: IconButton(
                onPressed: () => isUpdate.value = !isUpdate.value,
                icon: const Icon(FontAwesome.pen_to_square)
                    .iconColor(ColorPalate.white)
                    .iconSize(18.sp)),
          )
        ],
      ),
      body: SafeArea(
        child: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          onRefresh: () => ref
              .refresh(authProvider.notifier)
              .profileView()
              .then((_) => refreshController.refreshCompleted()),
          child: SingleChildScrollView(
            padding: paddingH16.copyWith(top: 0.h),
            child: Column(
              children: [
                // show warning for edit
                SizedBox(
                  height: 70.h,
                  child: WarningSection(
                    text: Text.rich(
                      'Payment Update is '
                          .textSpan
                          .withChildren([
                            'Pending'.textSpan.bold.italic.make(),
                            ' now!'.textSpan.make(),
                          ])
                          .color(ColorPalate.warning)
                          .subtitle2(context)
                          .make(),
                    ),
                    isVisible: state.user.isPaymentUpdate,
                  ),
                ),
                AppStrings.bankDetails.text.lg.make().objectCenterLeft(),
                gap8,
                ContainerBGWhiteSlideFromRight(
                  padding: paddingV20,
                  child: Column(
                    children: [
                      KTextFormField2(
                        controller: accHolder,
                        hintText: AppStrings.accountHolder,
                        enabled: isUpdate.value,
                        onChanged: (value) =>
                            newBankDetail.value.copyWith(accName: value),
                      ),
                      gap16,
                      KTextFormField2(
                        controller: bankName,
                        hintText: AppStrings.bankName,
                        enabled: isUpdate.value,
                        onChanged: (value) =>
                            newBankDetail.value.copyWith(bankName: value),
                      ),
                      gap16,
                      KTextFormField2(
                        controller: branchName,
                        hintText: AppStrings.branchCode,
                        enabled: isUpdate.value,
                        onChanged: (value) =>
                            newBankDetail.value.copyWith(branch: value),
                      ),
                      gap16,
                      KTextFormField2(
                        controller: routingNum,
                        hintText: AppStrings.routingNumber,
                        enabled: isUpdate.value,
                        onChanged: (value) =>
                            newBankDetail.value.copyWith(routingNum: value),
                      ),
                      gap16,
                      KTextFormField2(
                        controller: accNumber,
                        hintText: AppStrings.accountNumber,
                        enabled: isUpdate.value,
                        onChanged: (value) =>
                            newBankDetail.value.copyWith(accNum: value),
                      ),
                    ],
                  ),
                ),
                gap24,
                AppStrings.otherPaymentMethod.text.lg.make().objectCenterLeft(),
                gap8,
                ContainerBGWhiteSlideFromRight(
                  padding: paddingV20,
                  child: Column(
                    children: [
                      OtherPaymentSection(
                        isUpdate: isUpdate,
                        title: "BKash",
                        image: Images.bkashLogo,
                        number: otherAcc.bkashNum,
                        controller: bkash,
                      ),
                      gap16,
                      OtherPaymentSection(
                        isUpdate: isUpdate,
                        title: "Nagad",
                        image: Images.nagadLogo,
                        number: otherAcc.nagadNum,
                        controller: nagad,
                      ),
                    ],
                  ),
                ),
                gap20,
                Visibility(
                  visible: !state.user.isPaymentUpdate,
                  replacement: KElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        barrierLabel: "Barrier",
                        useSafeArea: true,
                        builder: (context) => OtpCheckWidget(
                          onTapOtpCheck: (otp) {
                            ref.read(authProvider.notifier).checkOtp(otp);
                          },
                        ),
                      );
                    },
                    text: 'Confirm OTP',
                    isSecondary: false,
                  ),
                  child: Visibility(
                    visible: isUpdate.value,
                    child: KFilledButton(
                      text: "Send Update Request",
                      onPressed: isUpdate.value
                          ? () {
                              ref
                                  .read(authProvider.notifier)
                                  .updatePayment(
                                    PaymentUpdateBody(
                                      bankAccount: BankAccountModel(
                                        accName: accNumber.text,
                                        accNum: accNumber.text,
                                        bankName: bankName.text,
                                        branch: branchName.text,
                                        routingNum: routingNum.text,
                                      ),
                                      othersAccount: OthersAccountModel(
                                        bkashNum: bkash.text,
                                        nagadNum: nagad.text,
                                      ),
                                    ),
                                  )
                                  .then((value) {
                                return value ? isUpdate.value = !value : null;
                              });
                            }
                          : null,
                    ),
                  ),
                ),
                gap36,
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAnimatedDialog(BuildContext context, {required Widget child}) =>
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'barrierLabel',
        pageBuilder: (context, animation, secondaryAnimation) {
          return Container();
        },
        // transitionDuration: const Duration(milliseconds: 600),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: .5, end: 1).animate(animation),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(animation),
              child: child,
            ),
          );
        },
      );
}

class OtherPaymentSection extends StatelessWidget {
  const OtherPaymentSection({
    Key? key,
    required this.isUpdate,
    required this.number,
    required this.image,
    required this.title,
    required this.controller,
  }) : super(key: key);

  final ValueNotifier<bool> isUpdate;
  final String number;
  final String image;
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isUpdate.value,
      replacement: Row(
        children: [
          gap16,
          image.assetImage(height: 30.h),
          gap16,
          number.isNotBlank
              ? number.text.make()
              : "not yet added!".text.caption(context).make(),
        ],
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            image.assetImage(height: 30.h),
            gap16,
            title.text.base.make(),
          ],
        ),
        shape: Border.all(color: Colors.transparent),
        children: [
          KTextFormField2(
            controller: controller,
            hintText: "$title Number",
            enabled: isUpdate.value,
          ),
        ],
      ),
    );
  }
}
