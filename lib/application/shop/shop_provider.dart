import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/auth/add_shop_body.dart';
import '../../domain/auth/model/shop_model.dart';
import '../../infrastructure/auth_repository.dart';
import '../global.dart';

part 'shop_provider.g.dart';

@riverpod
class GetMyShops extends _$GetMyShops {
  final repo = AuthRepo();
  Future<IList<MyShopModel>> _fetch() async {
    final result = await repo.getMyShop();
    return result.fold(
        (l) => showErrorToast(l.error.message), (r) => r.data.lock);
  }

  @override
  FutureOr<IList<MyShopModel>> build() {
    return _fetch();
  }

  Future<void> addMyShop(AddShopBody body) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repo.addMyShop(body);
      return _fetch();
    });
  }

  Future<void> deleteShop(String id) async {
    // state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repo.deleteShop(id);
      return _fetch();
    });
  }

  Future<void> updateShop(
      {required AddShopBody model, required String id}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repo.updateShop(model, id).then((value) => value.fold(
          (l) => showErrorToast(l.error.message), (r) => showToast(r.message)));
      return _fetch();
    });
  }
}
