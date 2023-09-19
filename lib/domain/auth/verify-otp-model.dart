import 'dart:convert';

import 'package:equatable/equatable.dart';

class VerifyOTPModel extends Equatable {
  final String token;
  final bool success;
  final String message;
  const VerifyOTPModel({
    required this.token,
    required this.success,
    required this.message,
  });

  VerifyOTPModel copyWith({
    String? token,
    bool? success,
    String? message,
  }) {
    return VerifyOTPModel(
      token: token ?? this.token,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'success': success,
      'message': message,
    };
  }

  factory VerifyOTPModel.fromMap(Map<String, dynamic> map) {
    return VerifyOTPModel(
      token: map['token'] ?? '',
      success: map['success'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyOTPModel.fromJson(String source) =>
      VerifyOTPModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'VerifyOTPModel(token: $token, success: $success, message: $message)';

  @override
  List<Object> get props => [token, success, message];
}
