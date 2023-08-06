import 'package:courier_merchent_app/domain/parcel/weight_model_response.dart';

import '../domain/parcel/get_area_model_response.dart';
import '../domain/parcel/parcel_category_model_reponse.dart';
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
}
