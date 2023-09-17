import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'model/payment_history_model.dart';

class SingleHistoryPaymentResponse extends Equatable {
  final HistoryPaymentModel data;
  final bool success;
  final String message;

  const SingleHistoryPaymentResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  factory SingleHistoryPaymentResponse.init() => SingleHistoryPaymentResponse(
        data: HistoryPaymentModel.init(),
        success: false,
        message: '',
      );

  SingleHistoryPaymentResponse copyWith({
    HistoryPaymentModel? data,
    bool? success,
    String? message,
  }) {
    return SingleHistoryPaymentResponse(
      data: data ?? this.data,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
      'success': success,
      'message': message,
    };
  }

  factory SingleHistoryPaymentResponse.fromMap(Map<String, dynamic> map) {
    return SingleHistoryPaymentResponse(
      data: HistoryPaymentModel.fromMap(map['data']),
      success: map['success'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleHistoryPaymentResponse.fromJson(String source) =>
      SingleHistoryPaymentResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'SingleHistoryPaymentResponse(data: $data, success: $success, message: $message)';

  @override
  List<Object> get props => [data, success, message];
}
