import '../domain/profile/get_area_model_response.dart';
import '../utils/utils.dart';

class ProfileRepo {
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
}
