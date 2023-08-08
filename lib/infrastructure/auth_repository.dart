import 'dart:io';

import 'package:courier_merchent_app/domain/auth/add_shop_body.dart';
import 'package:courier_merchent_app/domain/auth/model/shop_model.dart';
import 'package:courier_merchent_app/domain/auth/password_update_body.dart';

import '../domain/auth/get_all_shop_response.dart';
import '../domain/auth/login_body.dart';
import '../domain/auth/auth_response.dart';
import '../domain/auth/model/user_model.dart';
import '../domain/auth/signUp_body.dart';
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
      UserModel body) async {
    final data = await api.patch(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.PROFILE_UPDATE,
      body: body.toUpdateMap(),
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> imageUpload(File image) async {
    // var request = MultipartRequest(
    //     'PATCH', Uri.parse(APIRoute.BASE_URL + APIRoute.IMAGE_UPLOAD));

    // request.files.add(
    //   MultipartFile.fromBytes(
    //     'image',
    //     File(image.path).readAsBytesSync(),
    //     filename: image.path,
    //   ),
    // );
    // final res = await request.send();
    // final response = await Response.fromStream(res);
    // Logger.v(res);
    // Logger.v(response.body);
    // final Map<String, dynamic> data = jsonDecode(response.body);
    // Logger.v(data['data']['Location']);
    // return data['data']['Location'];
    final bytes = image.readAsBytesSync();
    final imageString = Uri.dataFromBytes(
      bytes,
      mimeType: 'image/png',
    ).toString();

    final data = await api.patch(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.IMAGE_UPLOAD,
      body: {"image": imageString},
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> addMyShop(AddShopBody body) async {
    final data = await api.post(
      body: body.toMap(),
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.ADD_SHOP,
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, GetAllShopResponse>> getMyShop() async {
    final data = await api.get(
      fromData: (json) => GetAllShopResponse.fromMap(json),
      endPoint: APIRoute.FETCH_ALL_SHOP,
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> updateShop(
      MyShopModel body) async {
    final data = await api.patch(
      body: body.toUpdateMap(),
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.UPDATE_SHOP + body.id,
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> deleteShop(String id) async {
    final data = await api.delete(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.DELETE_SHOP + id,
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> passwordUpdate(
      PasswordUpdateBody body) async {
    final data = await api.patch(
      body: body.toMap(),
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.PASSWORD_UPDATE,
      withToken: true,
    );

    return data;
  }
}
