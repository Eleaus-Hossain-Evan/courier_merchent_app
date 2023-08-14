import 'package:courier_merchent_app/application/home/home_provider.dart';
import 'package:courier_merchent_app/application/parcel/parcel_state.dart';
import 'package:courier_merchent_app/domain/parcel/parcel_category_model_response.dart';
import 'package:courier_merchent_app/domain/parcel/weight_model_response.dart';
import 'package:courier_merchent_app/infrastructure/parcel_repo.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/auth/model/area_model.dart';
import '../../domain/parcel/create_parcel_body.dart';
import '../../domain/parcel/fetch_all_parcel_reponse.dart';
import '../../presentation/parcel/parcel_list_screen.dart';
import '../../utils/utils.dart';
import '../global.dart';

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

  Future<bool> createParcel(CreateParcelBody body) async {
    bool success = false;
    state = state.copyWith(loading: true);

    final result = await repo.createParcel(body);

    ref.read(homeProvider.notifier).getRecentParcelList();

    result.fold((l) {
      showErrorToast(l.error.message);
      state = state.copyWith(loading: false);
    }, (r) {
      success = r.success;
      state = state.copyWith(loading: false);
    });

    return success;
  }

  Future<bool> updateParcel(String parcelId, CreateParcelBody body) async {
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
    ParcelListType type = ParcelListType.all,
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
      {ParcelListType type = ParcelListType.all, int page = 1}) async {
    state = state.copyWith(loading: true);

    final result = await fetchParcelList(type: type, page: page);

    result.fold(
      (l) {
        showErrorToast(l.error.message);
        state = state.copyWith(loading: false);
      },
      (r) {
        switch (type) {
          case ParcelListType.all:
            state = state.copyWith(allParcel: r.data.lock, loading: false);
            break;
          case ParcelListType.pending:
            state = state.copyWith(pendingParcel: r.data.lock, loading: false);
            break;
          case ParcelListType.pickup:
            state = state.copyWith(pickupParcel: r.data.lock, loading: false);
            break;
          case ParcelListType.shipping:
            state = state.copyWith(shippingParcel: r.data.lock, loading: false);
            break;
          case ParcelListType.shipped:
            state = state.copyWith(shippedParcel: r.data.lock, loading: false);
            break;
          case ParcelListType.dropoff:
            state = state.copyWith(dropoffParcel: r.data.lock, loading: false);
            break;
          case ParcelListType.returns:
            state = state.copyWith(returnParcel: r.data.lock, loading: false);
            break;
          case ParcelListType.cancel:
            state = state.copyWith(cancelParcel: r.data.lock, loading: false);
            break;
          default:
            state = state.copyWith(allParcel: r.data.lock, loading: false);
        }
      },
    );
  }
}
