import 'dart:async';

import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application/parcel/parcel_state.dart';
import '../../domain/auth/model/area_model.dart';
import '../../domain/parcel/create_parcel_body.dart';
import '../../domain/parcel/fetch_all_parcel_response.dart';
import '../../domain/parcel/model/merchant_info_model.dart';
import '../../domain/parcel/model/parcel_model.dart';
import '../../domain/parcel/parcel_category_model_response.dart';
import '../../domain/parcel/update_parcel_body.dart';
import '../../domain/parcel/weight_model_response.dart';
import '../../infrastructure/parcel_repo.dart';
import '../../utils/utils.dart';
import '../global.dart';

part 'parcel_provider.g.dart';

final parcelProvider =
    StateNotifierProvider<ParcelNotifier, ParcelState>((ref) {
  return ParcelNotifier(ref, ParcelRepo());
}, name: "parcelProvider");

class ParcelNotifier extends StateNotifier<ParcelState> {
  final Ref ref;
  final ParcelRepo repo;
  ParcelNotifier(this.ref, this.repo) : super(ParcelState.init());

  Future<List<AreaModel>> getDistrict() async {
    final data = await repo.allDistrict();

    return data.fold(
      (l) {
        showErrorToast(l.error.message);
        return [];
      },
      (r) => (r.data),
    );
  }

  Future<List<AreaModel>> getArea(String id) async {
    final data = await repo.allAreaByDistrict(id);

    return data.fold(
      (l) {
        showErrorToast(l.error.message);
        return [];
      },
      (r) => (r.data),
    );
  }

  Future<List<WeightModel>> getWeight() async {
    final data = await repo.getWeight();

    return data.fold(
      (l) {
        showErrorToast(l.error.message);
        return [];
      },
      (r) => (r.data),
    );
  }

  Future<List<ParcelCategoryModel>> getParcelCategory() async {
    final data = await repo.getParcelCategory();

    return data.fold(
      (l) {
        showErrorToast(l.error.message);
        return [];
      },
      (r) => (r.data),
    );
  }

  Future<String> createParcel(CreateParcelBody body) async {
    state = state.copyWith(loading: true);

    final result = await repo.createParcel(body);

    return result.fold((l) {
      showErrorToast(l.error.message);
      state = state.copyWith(loading: false);
      return '';
    }, (r) {
      state = state.copyWith(loading: false);
      ref.invalidate(recentParcelProvider);
      return r.data.serialId;
    });
  }

  Future<bool> updateParcel(String parcelId, UpdateParcelBody body) async {
    bool success = false;
    state = state.copyWith(loading: true);

    final result = await repo.updateParcel(parcelId, body);

    result.fold((l) {
      showErrorToast(l.error.message);
      state = state.copyWith(loading: false);
    }, (r) {
      success = r.success;
      state = state.copyWith(loading: false);
    });

    return success;
  }

  Future<Either<CleanFailure, FetchAllParcelResponse>> fetchParcelList({
    ParcelRegularStatus type = ParcelRegularStatus.all,
    int page = 1,
    int limit = 10,
  }) async {
    final result = await repo.fetchParcelList(
      page: page,
      limit: limit,
      type: type,
    );

    return result;
  }
}

@riverpod
class SingleParcel extends _$SingleParcel {
  final repo = ParcelRepo();

  Future<ParcelModel> _fetch(String id) async {
    final data = await repo.fetchSingleParcel(id);
    return data.fold((l) {
      showErrorToast(l.error.message);
      return ParcelModel.init();
    }, (r) => r.data);
  }

  @override
  Future<ParcelModel> build(String id) {
    return _fetch(id);
  }
}

@riverpod
FutureOr<FetchAllParcelResponse> recentParcel(RecentParcelRef ref) async {
  final result = await ref.read(parcelProvider.notifier).fetchParcelList();
  return result.fold((l) {
    showErrorToast(l.error.message);
    return FetchAllParcelResponse.init();
  }, (r) => r);
}

@riverpod
FutureOr<FetchAllParcelResponse> createBulkParcel(CreateBulkParcelRef ref,
    {required MerchantInfoModel merchant, required String data}) async {
  final result = await ParcelRepo().createBulkParcel(merchant, data);
  return result.fold((l) {
    showErrorToast(l.error.message);
    return FetchAllParcelResponse.init();
  }, (r) => r);

  // log(merchant.toJson());
  // return FetchAllParcelResponse.init();
}

@riverpod
class FetchAllTypeParcel extends _$FetchAllTypeParcel {
  @override
  Future<FetchAllParcelResponse> build(
      {ParcelRegularStatus type = ParcelRegularStatus.all,
      int page = 1,
      int limit = 10}) async {
    // final data = await http.post(
    //   Uri.parse(
    //       "https://api.courier.b2gsoft.xyz/api/v1/parcel/fetch-all-parcel-by-merchant?page=$page&limit=$limit"),
    //   // uri,
    //   body: {"status": type.value},
    // );

    // Logger.i(data.body);
    // return FetchAllParcelResponse.fromJson(data.body);

    final result = await ParcelRepo()
        .fetchParcelList(type: type, limit: limit, page: page);

    Logger.i(result);

    return result.fold((l) {
      showErrorToast(l.error.message);
      return FetchAllParcelResponse.init();
    }, (r) => r);
  }
}
