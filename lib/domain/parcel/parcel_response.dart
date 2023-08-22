import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'model/parcel_model.dart';

class ParcelResponse extends Equatable {
  final ParcelModel data;
  final String message;
  final bool success;

  const ParcelResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  ParcelResponse copyWith({
    ParcelModel? data,
    String? message,
    bool? success,
  }) {
    return ParcelResponse(
      data: data ?? this.data,
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
      'message': message,
      'success': success,
    };
  }

  factory ParcelResponse.fromMap(Map<String, dynamic> map) {
    return ParcelResponse(
      data: ParcelModel.fromMap(map['data']),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParcelResponse.fromJson(String source) =>
      ParcelResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'CreateParcelResponse(data: $data, message: $message, success: $success)';

  @override
  List<Object> get props => [data, message, success];
}
