import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'model/bank_model.dart';

class FetchAllBankResponse extends Equatable {
  final List<BankModel> data;
  final String message;
  final bool success;
  const FetchAllBankResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  FetchAllBankResponse copyWith({
    List<BankModel>? data,
    String? message,
    bool? success,
  }) {
    return FetchAllBankResponse(
      data: data ?? this.data,
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
      'message': message,
      'success': success,
    };
  }

  factory FetchAllBankResponse.fromMap(Map<String, dynamic> map) {
    return FetchAllBankResponse(
      data: List<BankModel>.from(
          map['data']?.map((x) => BankModel.fromMap(x)) ?? const []),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchAllBankResponse.fromJson(String source) =>
      FetchAllBankResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'FetchAllBankResponse(data: $data, message: $message, success: $success)';

  @override
  List<Object> get props => [data, message, success];
}
