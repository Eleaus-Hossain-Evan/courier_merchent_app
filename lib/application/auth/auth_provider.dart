import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/auth/login_body.dart';
import '../../domain/auth/model/user_model.dart';
import '../../domain/auth/profile_update_body.dart';
import '../../domain/auth/signUp_body.dart';
import '../../infrastructure/auth_repository.dart';
import '../../route/go_router.dart';
import '../../utils/utils.dart';
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

  void signUp(SignUpBody body) async {
    state = state.copyWith(loading: true);

    final res = await repo.signUp(body);

    state = res.fold(
      (l) {
        showErrorToast(l.error.message);
        return state.copyWith(failure: l, loading: false);
      },
      (r) {
        showToast(r.message);
        ref
            .read(loggedInProvider.notifier)
            .updateAuthCache(token: r.data.token, user: r.data);
        return state.copyWith(user: r.data, loading: false);
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
        return state = state.copyWith(user: r.data, loading: false);
      },
    );
  }

  void logout() {
    state = state.copyWith(user: UserModel.init());

    ref.read(loggedInProvider.notifier).deleteAuthCache();

    // _ref.read(loggedInProvider.notifier).isLoggedIn();

    showToast('${state.user.name} logging out');
  }

  void profileView() async {
    state = state.copyWith(loading: true);
    final result = await repo.profileView();

    state = result.fold(
      (l) {
        BotToast.showText(
            text: l.error.message, contentColor: ColorPalate.error);
        return state = state.copyWith(failure: l, loading: false);
      },
      (r) {
        return state.copyWith(user: r.data, loading: false);
      },
    );
  }

  void profileUpdate(ProfileUpdateBody updateUser, File? image) async {
    state = state.copyWith(loading: true);

    // if (image != null) {
    //   await uploadImage(image);
    // }

    final result = await repo.profileUpdate(state.user.copyWith(
      name: updateUser.name,
      email: updateUser.email,
      phone: updateUser.phone,
      address: updateUser.address,
    ));

    state = result.fold(
      (l) {
        showErrorToast(l.error.message);
        return state = state.copyWith(failure: l, loading: false);
      },
      (r) {
        ref.read(routerProvider).pop();
        return state.copyWith(user: r.data, loading: false);
      },
    );
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
        return state.copyWith(user: r.data, loading: false);
      },
    );

    return success;
  }
}
