import '../../utils/network_util/network_handler.dart';

import '../domain/home/home_response.dart';
import '../utils/constant/api_routes.dart';

class HomeRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, HomeResponse>> getHomeDate() async {
    return await api.get(
      fromData: (json) => HomeResponse.fromMap(json),
      endPoint: APIRoute.HOME,
      withToken: false,
    );
  }
}
