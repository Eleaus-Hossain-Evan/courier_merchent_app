import 'package:courier_merchent_app/application/parcel/parcel_provider.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/home_repo.dart';
import '../global.dart';
import 'home_state.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(HomeRepo(), ref);
}, name: "homeProvider");

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeRepo repo;
  final Ref ref;

  HomeNotifier(this.repo, this.ref) : super(HomeState.init());

  void getHomeData() async {
    state = state.copyWith(loading: true);
    final result = await repo.getHomeDate();

    Logger.d("result: $result");
    result.fold(
      (l) {
        showErrorToast(l.error.message);
        return state = state.copyWith(loading: false);
      },
      (r) => state = state.copyWith(homeData: r.data, loading: false),
    );
  }

  Future<void> getRecentParcelList() async {
    state = state.copyWith(loading: true);
    final result = await ref.read(parcelProvider.notifier).getParcelList();

    Logger.i(result);

    state = state.copyWith(parcelList: result, loading: false);
  }
}
