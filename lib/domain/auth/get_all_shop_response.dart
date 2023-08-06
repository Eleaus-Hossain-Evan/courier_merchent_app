import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:courier_merchent_app/domain/auth/model/shop_model.dart';

class GetAllShopResponse extends Equatable {
  final List<MyShopModel> data;
  final bool success;
  final String message;

  const GetAllShopResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  GetAllShopResponse copyWith({
    List<MyShopModel>? data,
    bool? success,
    String? message,
  }) {
    return GetAllShopResponse(
      data: data ?? this.data,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
      'success': success,
      'message': message,
    };
  }

  factory GetAllShopResponse.fromMap(Map<String, dynamic> map) {
    return GetAllShopResponse(
      data: List<MyShopModel>.from(
          map['data']?.map((x) => MyShopModel.fromMap(x)) ?? const []),
      success: map['success'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllShopResponse.fromJson(String source) =>
      GetAllShopResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetAllShopResponse(data: $data, success: $success, message: $message)';

  @override
  List<Object> get props => [data, success, message];
}
