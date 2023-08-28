import 'package:courier_merchent_app/domain/parcel/create_parcel_body.dart';
import 'package:courier_merchent_app/domain/parcel/fetch_all_parcel_response.dart';
import 'package:courier_merchent_app/domain/parcel/weight_model_response.dart';

import '../domain/parcel/parcel_response.dart';
import '../domain/parcel/get_area_model_response.dart';
import '../domain/parcel/model/parcel_model.dart';
import '../domain/parcel/parcel_category_model_response.dart';
import '../domain/parcel/update_parcel_body.dart';
import '../utils/utils.dart';

class ParcelRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, GetAreaModelResponse>> allDistrict() async {
    final data = await api.get(
      fromData: (json) => GetAreaModelResponse.fromMap(json),
      endPoint: APIRoute.ALL_DISTRICT,
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, GetAreaModelResponse>> allAreaByDistrict(
      String id) async {
    final data = await api.get(
      fromData: (json) => GetAreaModelResponse.fromMap(json),
      endPoint: APIRoute.ALL_AREA_BY_DISTRICT + id,
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, WeightModelResponse>> getWeight() async {
    final data = await api.get(
      fromData: (json) => WeightModelResponse.fromMap(json),
      endPoint: APIRoute.WEIGHT_CHARGE,
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, ParcelCategoryModelResponse>>
      getParcelCategory() async {
    final data = await api.get(
      fromData: (json) => ParcelCategoryModelResponse.fromMap(json),
      endPoint: APIRoute.PARCEL_CATEGORY,
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, ParcelResponse>> createParcel(
      CreateParcelBody body) async {
    final data = await api.post(
      body: body.toUpdateMap(),
      fromData: (json) => ParcelResponse.fromMap(json),
      endPoint: APIRoute.PARCEL_CREATE,
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, ParcelResponse>> updateParcel(
      String parcelId, UpdateParcelBody body) async {
    final data = await api.patch(
      body: body.toMap(),
      fromData: (json) => ParcelResponse.fromMap(json),
      endPoint: APIRoute.PARCEL_UPDATE + parcelId,
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, FetchAllParcelResponse>> fetchParcelList({
    ParcelRegularStatus type = ParcelRegularStatus.all,
    int page = 1,
    int limit = 10,
  }) async {
    final data = await api.post(
      body: {"status": type.value},
      fromData: (json) => FetchAllParcelResponse.fromMap(json),
      endPoint: "${APIRoute.FETCH_ALL_PARCEL}page=$page&limit=$limit",
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, ParcelResponse>> fetchSingleParcel(
      String id) async {
    final data = await api.get(
      fromData: (json) => ParcelResponse.fromMap(json),
      endPoint: APIRoute.SINGLE_PARCEL + id,
      withToken: true,
    );

    return data;
  }
}
