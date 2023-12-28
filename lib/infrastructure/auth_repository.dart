import 'dart:io';

import 'package:courier_merchent_app/domain/auth/add_shop_body.dart';
import 'package:courier_merchent_app/domain/auth/password_update_body.dart';
import 'package:courier_merchent_app/domain/auth/payment_update_body.dart';
import 'package:courier_merchent_app/domain/auth/verify-otp-model.dart';
import 'package:courier_merchent_app/domain/simple_response.dart';

import '../domain/auth/auth_response.dart';
import '../domain/auth/fetch_all_bank_response.dart';
import '../domain/auth/get_all_shop_response.dart';
import '../domain/auth/image_update_response.dart';
import '../domain/auth/login_body.dart';
import '../domain/auth/profile_update_body.dart';
import '../domain/auth/shop_update_response.dart';
import '../domain/auth/signUp_body.dart';
import '../utils/constant/api_routes.dart';
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

  Future<Either<CleanFailure, SimpleResponse>> signUp(SignUpBody body) async {
    final data = await api.post(
      fromData: (json) => SimpleResponse.fromMap(json),
      endPoint: APIRoute.SIGN_UP,
      body: body.toMap(),
      withToken: false,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> verifySignUp(String otp) async {
    final data = await api.post(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.VERIFY_SIGN_UP,
      body: {"otpCode": otp},
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
    final data = await api.patch(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.PROFILE_UPDATE,
      body: body.toMap(),
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, ImageUpdateResponse>> imageUpload(
      File image) async {
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
      fromData: (json) => ImageUpdateResponse.fromMap(json),
      endPoint: APIRoute.IMAGE_UPLOAD,
      body: {"image": imageString},
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, ShopResponse>> addMyShop(AddShopBody body) async {
    final data = await api.post(
      body: body.toMap(),
      fromData: (json) => ShopResponse.fromMap(json),
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

  Future<Either<CleanFailure, ShopResponse>> updateShop(
      AddShopBody body, String id) async {
    final data = await api.patch(
      body: body.toMap(),
      fromData: (json) => ShopResponse.fromMap(json),
      endPoint: APIRoute.UPDATE_SHOP + id,
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

  Future<Either<CleanFailure, AuthResponse>> paymentUpdate(
      PaymentUpdateBody body) async {
    final data = await api.patch(
      body: body.toMap(),
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.PAYMENT_UPDATE,
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, FetchAllBankResponse>> fetchAllBank() async {
    final data = await api.get(
      fromData: (json) => FetchAllBankResponse.fromMap(json),
      endPoint: APIRoute.BANK_ALL,
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> checkOtpForPayment(
      String otp) async {
    return await api.post(
      body: {"otpCode": otp},
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.CHECK_OTP,
      withToken: true,
    );
  }

  Future<Either<CleanFailure, SimpleResponse>> forgotPasswordPhone(
      String phone) async {
    final data = await api.post(
      body: {"phone": phone},
      fromData: (json) => SimpleResponse.fromMap(json),
      endPoint: APIRoute.FORGOT_PASSWORD_GET_OTP,
    );

    return data;
  }

  Future<Either<CleanFailure, VerifyOTPModel>> forgotPasswordVerifyOtp(
      String otp) async {
    final data = await api.post(
      body: {"otpCode": otp},
      fromData: (json) => VerifyOTPModel.fromMap(json),
      endPoint: APIRoute.FORGOT_PASSWORD_VERIFY_OTP,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> resetPassword(
      String password, String token) async {
    final data = await api.post(
      body: {"password": password, "token": token},
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.RESET_PASSWORD,
    );

    return data;
  }
}
