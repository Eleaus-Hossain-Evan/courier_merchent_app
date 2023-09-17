import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../meta_data_model.dart';
import 'model/payment_history_model.dart';

class HistoryPaymentListResponse extends Equatable {
  final MetaDataModel metaData;
  final List<HistoryPaymentModel> data;
  final bool success;
  final String message;
  const HistoryPaymentListResponse({
    required this.metaData,
    required this.data,
    required this.success,
    required this.message,
  });

  factory HistoryPaymentListResponse.init() => HistoryPaymentListResponse(
        metaData: MetaDataModel.init(),
        data: const [],
        success: false,
        message: '',
      );

  HistoryPaymentListResponse copyWith({
    MetaDataModel? metaData,
    List<HistoryPaymentModel>? data,
    bool? success,
    String? message,
  }) {
    return HistoryPaymentListResponse(
      metaData: metaData ?? this.metaData,
      data: data ?? this.data,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metaData': metaData.toMap(),
      'data': data.map((x) => x.toMap()).toList(),
      'success': success,
      'message': message,
    };
  }

  factory HistoryPaymentListResponse.fromMap(Map<String, dynamic> map) {
    return HistoryPaymentListResponse(
      metaData: MetaDataModel.fromMap(map['metaData']),
      data: List<HistoryPaymentModel>.from(
          map['data']?.map((x) => HistoryPaymentModel.fromMap(x)) ?? const []),
      success: map['success'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryPaymentListResponse.fromJson(String source) =>
      HistoryPaymentListResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HistoryPaymentResponse(metaData: $metaData, data: $data, success: $success, message: $message)';
  }

  @override
  List<Object> get props => [metaData, data, success, message];
}
