import 'package:courier_merchent_app/application/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import 'pages/send_otp.dart';
import 'pages/verify_otp.dart';

class ResetPasswordScreen extends HookConsumerWidget {
  static String route = "/resetPassword";
  const ResetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);

    final phoneController = useTextEditingController(text: "01956945283");

    final token = useState('');

    final pageController = usePageController();

    final currentPasswordController = useTextEditingController();
    final newPasswordController = useTextEditingController();
    final reNewPasswordController = useTextEditingController();

    final reNewPasswordFocus = useFocusNode();
    final newPasswordFocus = useFocusNode();

    final formKey = useMemoized(GlobalKey<FormState>.new);

    ref.listen(authProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        // BotToast.showLoading();
        loading.value = true;
      }
      if (previous.loading == true && next.loading == false) {
        // BotToast.closeAllLoading();
        loading.value = false;
      }
    });

    void pageChange() {
      if (token.value.isNotBlank) {
        pageController.nextPage(
            duration: 500.milliseconds, curve: Curves.bounceIn);
      } else {
        pageController.previousPage(
            duration: 500.milliseconds, curve: Curves.bounceIn);
      }
    }

    useEffect(() {
      token.addListener(pageChange);
      return () => token.removeListener(pageChange);
    }, const []);

    return Scaffold(
      appBar: const KAppBar(),
      body: Column(
        crossAxisAlignment: crossStart,
        children: [
          // Gap(40.h),
          const AppLogoWidget(),
          gap36,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              AppStrings.forgotPassword.toTitleCase(),
              style: CustomTextStyle.textStyle30w700,
            ),
          ),
          gap8,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              AppStrings.forgotBelowText,
              style: CustomTextStyle.textStyle16w400Black900,
            ),
          ),
          gap40,
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // 1st page

                SendOTP(
                    phoneController: phoneController,
                    token: token,
                    pageController: pageController),

                // 2nd page
                VerifyOTP(
                    formKey: formKey,
                    newPasswordController: newPasswordController,
                    newPasswordFocus: newPasswordFocus,
                    currentPasswordController: currentPasswordController,
                    reNewPasswordFocus: reNewPasswordFocus,
                    reNewPasswordController: reNewPasswordController,
                    loading: loading,
                    token: token),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
