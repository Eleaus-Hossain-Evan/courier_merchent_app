import 'dart:convert';
import 'dart:io';

import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:http/http.dart';

import '../domain/auth/login_body.dart';
import '../domain/auth/auth_response.dart';
import '../domain/auth/profile_update_body.dart';
import '../domain/auth/signUp_body.dart';
import '../domain/simple_response.dart';
import '../utils/api_routes.dart';
import '../utils/network_util/network_handler.dart';

class AuthRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, AuthResponse>> login(LoginBody body) async {
    final data = await api.post(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.LOGIN,
      body: body.toMap(),
      withToken: false,
    );

    return data;
  }

  Future<Either<CleanFailure, SimpleResponse>> setDeviceToken(
      String dToken) async {
    final data = await api.put(
      fromData: (json) => SimpleResponse.fromMap(json),
      endPoint: APIRoute.DEVICE_TOKEN,
      body: {
        "deviceToken": dToken,
      },
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> signUp(SignUpBody body) async {
    final data = await api.post(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.SIGN_UP,
      body: body.toMap(),
      withToken: false,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> profileView() async {
    final data = await api.get(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.PROFILE_VIEW,
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> profileUpdate(
      ProfileUpdateBody body) async {
    final data = await api.put(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.PROFILE_UPDATE,
      body: body.toMap(),
      withToken: true,
    );

    return data;
  }

  Future<String> imageUpload(File image) async {
    var request = MultipartRequest(
        'POST', Uri.parse(APIRoute.BASE_URL + APIRoute.IMAGE_UPLOAD));

    request.files.add(
      MultipartFile.fromBytes(
        'image',
        File(image.path).readAsBytesSync(),
        filename: image.path,
      ),
    );
    final res = await request.send();
    final response = await Response.fromStream(res);
    Logger.v(res);
    Logger.v(response.body);
    final Map<String, dynamic> data = jsonDecode(response.body);
    Logger.v(data['data']['Location']);
    return data['data']['Location'];
  }
}
