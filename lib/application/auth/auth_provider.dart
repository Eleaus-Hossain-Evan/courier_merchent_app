import 'dart:async';
import 'dart:io';

import 'package:courier_merchent_app/domain/auth/model/bank_model.dart';
import 'package:courier_merchent_app/domain/auth/payment_update_body.dart';
import 'package:courier_merchent_app/route/go_router.dart';
import 'package:courier_merchent_app/utils/network_util/network_handler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/auth/login_body.dart';
import '../../domain/auth/model/user_model.dart';
import '../../domain/auth/password_update_body.dart';
import '../../domain/auth/profile_update_body.dart';
import '../../domain/auth/signUp_body.dart';
import '../../infrastructure/auth_repository.dart';
import '../global.dart';
import 'auth_state.dart';
import 'loggedin_provider.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthRepo(), ref);
}, name: 'authProvider');

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepo repo;
  final Ref ref;

  AuthNotifier(this.repo, this.ref) : super(AuthState.init());

  void setUser(UserModel user) {
    state = state.copyWith(user: user);
  }

  Future<bool> signUp(SignUpBody body) async {
    bool success = false;
    state = state.copyWith(loading: true);

    final res = await repo.signUp(body);

    state = res.fold(
      (l) {
        showErrorToast(l.error.message);
        return state.copyWith(failure: l, loading: false);
      },
      (r) {
        showToast(r.message);
        success = r.success;
        return state.copyWith(loading: false);
      },
    );

    return success;
  }

  Future<void> verifySignUp(String otp) async {
    state = state.copyWith(loading: true);

    final result = await repo.verifySignUp(otp);

    state = result.fold(
      (l) {
        showErrorToast(l.error.message);
        return state = state.copyWith(failure: l, loading: false);
      },
      (r) {
        showToast(r.message);
        ref.read(routerProvider).pop();
        return state = state.copyWith(user: r.data, loading: false);
      },
    );
  }

  void login(LoginBody body) async {
    state = state.copyWith(loading: true);

    final result = await repo.login(body);

    state = result.fold(
      (l) {
        showErrorToast(l.error.message);
        return state = state.copyWith(failure: l, loading: false);
      },
      (r) {
        showToast(r.message);
        ref
            .read(loggedInProvider.notifier)
            .updateAuthCache(token: r.data.token, user: r.data);
        NetworkHandler.instance.setToken(r.data.token);
        return state = state.copyWith(user: r.data, loading: false);
      },
    );
  }

  void logout() {
    state = state.copyWith(user: UserModel.init());

    ref.read(loggedInProvider.notifier).deleteAuthCache();
    NetworkHandler.instance.setToken("");

    // _ref.read(loggedInProvider.notifier).isLoggedIn();

    showToast('${state.user.name} logging out');
  }

  Future<bool> passwordUpdate(PasswordUpdateBody body) async {
    bool success = false;
    state = state.copyWith(loading: true);

    repo.passwordUpdate(body).then((result) {
      state = result.fold(
        (l) {
          showErrorToast(l.error.message);
          return state = state.copyWith(failure: l, loading: false);
        },
        (r) {
          success = r.success;
          showToast(r.message);
          ref.read(routerProvider).pop();
          return state = state.copyWith(user: r.data, loading: false);
        },
      );
    });

    return success;
  }

  Future<bool> profileView() async {
    bool success = false;
    // state = state.copyWith(loading: true);
    final result = await repo.profileView();

    state = result.fold(
      (l) {
        showErrorToast(l.error.message);
        return state = state.copyWith(failure: l, loading: false);
      },
      (r) {
        success = r.success;
        // ref.read(loggedInProvider).changeSavedUser(r.data);
        return state.copyWith(user: r.data, loading: false);
      },
    );

    return success;
  }

  Future<bool> profileUpdate(ProfileUpdateBody updateUser, File? image) async {
    bool success = false;

    // state = state.copyWith(loading: true);

    if (image != null) {
      uploadImage(image);
    }

    final result = await repo.profileUpdate(updateUser);

    state = result.fold(
      (l) {
        showErrorToast(l.error.message);
        return state = state.copyWith(failure: l, loading: false);
      },
      (r) {
        success = r.success;
        showToast(r.message);
        return state.copyWith(user: r.data, loading: false);
      },
    );

    return success;
  }

  Future<bool> updatePayment(PaymentUpdateBody body) async {
    bool success = false;
    state = state.copyWith(loading: true);
    final result = await repo.paymentUpdate(body);

    state = result.fold(
      (l) {
        showErrorToast(l.error.message);
        return state = state.copyWith(failure: l, loading: false);
      },
      (r) {
        success = r.success;
        // ref.read(loggedInProvider).changeSavedUser(r.data);
        return state.copyWith(loading: false);
      },
    );

    return success;
  }

  Future<bool> uploadImage(File file) async {
    bool success = false;
    state = state.copyWith(loading: true);
    final result = await repo.imageUpload(file);

    state = result.fold(
      (l) {
        showErrorToast(l.error.message);
        return state = state.copyWith(failure: l, loading: false);
      },
      (r) {
        success = true;
        final user = state.user.copyWith(
          updatedAt: r.data.updatedAt,
          image: r.data.image,
        );
        return state.copyWith(user: user, loading: false);
      },
    );

    return success;
  }

  Future<bool> checkOtp(String otp) async {
    bool success = false;
    state = state.copyWith(loading: true);
    await repo.checkOtpForPayment(otp).then((result) {
      state = result.fold(
        (l) {
          showErrorToast(l.error.message);
          return state = state.copyWith(failure: l, loading: false);
        },
        (r) {
          showToast(r.message);
          // ref.read(routerProvider).pop();
          success = r.success;
          return state = state.copyWith(
            // user: r.data,
            loading: false,
          );
        },
      );
    });
    return success;
  }

  Future<bool> forgotPassword(String phone) async {
    bool success = false;

    state = state.copyWith(loading: true);
    final result = await repo.forgotPasswordPhone(phone);

    state = result.fold(
      (l) {
        showErrorToast(l.error.message);
        return state = state.copyWith(failure: l, loading: false);
      },
      (r) {
        showToast(r.message);
        success = r.success;
        return state = state.copyWith(loading: false);
      },
    );

    return success;
  }

  Future<String> verifyOtp(String otp) async {
    String token = '';

    state = state.copyWith(loading: true);
    final result = await repo.forgotPasswordVerifyOtp(otp);

    state = result.fold(
      (l) {
        showErrorToast(l.error.message);
        return state = state.copyWith(failure: l, loading: false);
      },
      (r) {
        showToast(r.message);
        token = r.token;
        return state = state.copyWith(loading: false);
      },
    );

    return token;
  }

  Future<void> resetPassword(String password, String token) async {
    state = state.copyWith(loading: true);
    final result = await repo.resetPassword(password, token);

    state = result.fold(
      (l) {
        showErrorToast(l.error.message);
        return state = state.copyWith(failure: l, loading: false);
      },
      (r) {
        showToast(r.message);
        ref.read(routerProvider).pop();
        return state = state.copyWith(loading: false);
      },
    );
  }
}

final authRepoProvider = Provider<AuthRepo>((ref) {
  return AuthRepo();
});

final fetchAllBankProvider = FutureProvider<List<BankModel>>((ref) async {
  final result = await ref.watch(authRepoProvider).fetchAllBank();

  return result.fold((l) {
    showErrorToast(l.error.message);
    return [];
  }, (r) => r.data);
});
