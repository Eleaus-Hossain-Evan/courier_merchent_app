import 'package:courier_merchent_app/domain/home/home_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../infrastructure/home_repo.dart';
import '../global.dart';

part 'home_provider.g.dart';
// final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
//   return HomeNotifier(HomeRepo(), ref);
// }, name: "homeProvider");

// class HomeNotifier extends StateNotifier<HomeState> {
//   final HomeRepo repo;
//   final Ref ref;

//   HomeNotifier(this.repo, this.ref) : super(HomeState.init());

//   void getHomeData() async {
//     state = state.copyWith(loading: true);
//     final result = await repo.getHomeDate();

//     Logger.d("result: $result");
//     result.fold(
//       (l) {
//         showErrorToast(l.error.message);
//         return state = state.copyWith(loading: false);
//       },
//       (r) => state = state.copyWith(homeData: r.data, loading: false),
//     );
//   }

// }

@riverpod
class Home extends _$Home {
  final repo = HomeRepo();

  Future<HomeResponse> _fetch() async {
    final result = await repo.getHomeDate();

    return result.fold((l) {
      showErrorToast(l.error.message);
      return HomeResponse.init();
    }, (r) => r);
  }

  @override
  FutureOr<HomeResponse> build() {
    return _fetch();
  }
}
