import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application/home/home_provider.dart';
import '../../application/parcel/parcel_state.dart';
import '../../domain/parcel/parcel_category_model_response.dart';
import '../../domain/parcel/update_parcel_body.dart';
import '../../domain/parcel/weight_model_response.dart';
import '../../infrastructure/parcel_repo.dart';

import '../../domain/auth/model/area_model.dart';
import '../../domain/parcel/create_parcel_body.dart';
import '../../domain/parcel/fetch_all_parcel_response.dart';
import '../../domain/parcel/model/parcel_model.dart';
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

    ref.read(homeProvider.notifier).getRecentParcelList();

    return result.fold((l) {
      showErrorToast(l.error.message);
      state = state.copyWith(loading: false);
      return '';
    }, (r) {
      state = state.copyWith(loading: false);
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

  void fetchCategorizedParcel(
      {ParcelRegularStatus type = ParcelRegularStatus.all,
      int page = 1}) async {
    state = state.copyWith(loading: true);

    final result = await fetchParcelList(type: type, page: page);

    result.fold(
      (l) {
        showErrorToast(l.error.message);
        state = state.copyWith(loading: false);
      },
      (r) {
        switch (type) {
          case ParcelRegularStatus.all:
            state = state.copyWith(allParcel: r.data.lock, loading: false);
            break;
          case ParcelRegularStatus.pending:
            state = state.copyWith(pendingParcel: r.data.lock, loading: false);
            break;
          case ParcelRegularStatus.pickup:
            state = state.copyWith(pickupParcel: r.data.lock, loading: false);
            break;
          case ParcelRegularStatus.shipping:
            state = state.copyWith(shippingParcel: r.data.lock, loading: false);
            break;
          case ParcelRegularStatus.shipped:
            state = state.copyWith(shippedParcel: r.data.lock, loading: false);
            break;
          case ParcelRegularStatus.dropoff:
            state = state.copyWith(dropoffParcel: r.data.lock, loading: false);
            break;
          case ParcelRegularStatus.returns:
            state = state.copyWith(returnParcel: r.data.lock, loading: false);
            break;
          case ParcelRegularStatus.cancel:
            state = state.copyWith(cancelParcel: r.data.lock, loading: false);
            break;
          default:
            state = state.copyWith(allParcel: r.data.lock, loading: false);
        }
      },
    );
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
