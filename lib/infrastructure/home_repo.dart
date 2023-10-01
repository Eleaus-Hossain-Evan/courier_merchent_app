import '../../utils/network_util/network_handler.dart';

import '../domain/home/dashboard_response.dart';
import '../domain/home/home_response.dart';
import '../utils/constant/api_routes.dart';

class HomeRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, HomeResponse>> getHomeDate() async {
    return await api.get(
      fromData: (json) => HomeResponse.fromMap(json),
      endPoint: APIRoute.HOME,
      withToken: true,
    );
  }

  Future<Either<CleanFailure, DashboardResponse>> fetchDashboard(
      {String startTime = '', String endTime = ''}) async {
    final data = await api.post(
      body: {"startTime": startTime, "endTime": endTime},
      fromData: (json) => DashboardResponse.fromMap(json),
      endPoint: APIRoute.DASHBOARD,
      withToken: true,
    );

    return data;
  }
}
