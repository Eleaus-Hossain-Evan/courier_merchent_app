import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:courier_merchent_app/domain/parcel/model/parcel_model.dart';

import '../meta_data_model.dart';

class PendingPaymentResponse extends Equatable {
  final PaymentDetails paymentDetails;
  final MetaDataModel metaData;
  final List<ParcelModel> data;
  final bool success;
  final String message;

  const PendingPaymentResponse({
    required this.paymentDetails,
    required this.metaData,
    required this.data,
    required this.success,
    required this.message,
  });

  factory PendingPaymentResponse.init() => PendingPaymentResponse(
        paymentDetails: PaymentDetails.init(),
        metaData: MetaDataModel.init(),
        data: const [],
        success: false,
        message: '',
      );

  PendingPaymentResponse copyWith({
    PaymentDetails? paymentDetails,
    MetaDataModel? metaData,
    List<ParcelModel>? data,
    bool? success,
    String? message,
  }) {
    return PendingPaymentResponse(
      paymentDetails: paymentDetails ?? this.paymentDetails,
      metaData: metaData ?? this.metaData,
      data: data ?? this.data,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paymentDetails': paymentDetails.toMap(),
      'metaData': metaData.toMap(),
      'data': data.map((x) => x.toMap()).toList(),
      'success': success,
      'message': message,
    };
  }

  factory PendingPaymentResponse.fromMap(Map<String, dynamic> map) {
    return PendingPaymentResponse(
      paymentDetails: PaymentDetails.fromMap(map['paymentDetails']),
      metaData: MetaDataModel.fromMap(map['metaData']),
      data: List<ParcelModel>.from(
          map['data']?.map((x) => ParcelModel.fromMap(x)) ?? const []),
      success: map['success'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PendingPaymentResponse.fromJson(String source) =>
      PendingPaymentResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PendingPaymentResponse(paymentDetails: $paymentDetails, metaData: $metaData, data: $data, success: $success, message: $message)';
  }

  @override
  List<Object> get props {
    return [
      paymentDetails,
      metaData,
      data,
      success,
      message,
    ];
  }
}

class PaymentDetails extends Equatable {
  final int totalParcel;
  final int totalDeliveryCharge;
  final int totalCollectionCharge;
  final int merchantDue;
  const PaymentDetails({
    required this.totalParcel,
    required this.totalDeliveryCharge,
    required this.totalCollectionCharge,
    required this.merchantDue,
  });

  factory PaymentDetails.init() => const PaymentDetails(
      totalParcel: 0,
      totalDeliveryCharge: 0,
      totalCollectionCharge: 0,
      merchantDue: 0);

  PaymentDetails copyWith({
    int? totalParcel,
    int? totalDeliveryCharge,
    int? totalCollectionCharge,
    int? merchantDue,
  }) {
    return PaymentDetails(
      totalParcel: totalParcel ?? this.totalParcel,
      totalDeliveryCharge: totalDeliveryCharge ?? this.totalDeliveryCharge,
      totalCollectionCharge:
          totalCollectionCharge ?? this.totalCollectionCharge,
      merchantDue: merchantDue ?? this.merchantDue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalParcel': totalParcel,
      'totalDeliveryCharge': totalDeliveryCharge,
      'totalCollectionCharge': totalCollectionCharge,
      'merchantDue': merchantDue,
    };
  }

  factory PaymentDetails.fromMap(Map<String, dynamic> map) {
    return PaymentDetails(
      totalParcel: map['totalParcel']?.toInt() ?? 0,
      totalDeliveryCharge: map['totalDeliveryCharge']?.toInt() ?? 0,
      totalCollectionCharge: map['totalCollectionCharge']?.toInt() ?? 0,
      merchantDue: map['merchantDue']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentDetails.fromJson(String source) =>
      PaymentDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaymentDetails(totalParcel: $totalParcel, totalDeliveryCharge: $totalDeliveryCharge, totalCollectionCharge: $totalCollectionCharge, merchantDue: $merchantDue)';
  }

  @override
  List<Object> get props =>
      [totalParcel, totalDeliveryCharge, totalCollectionCharge, merchantDue];
}

class MetaData extends Equatable {
  final int totalData;
  final int page;
  final int limit;
  final int totalPage;
  const MetaData({
    required this.totalData,
    required this.page,
    required this.limit,
    required this.totalPage,
  });

  MetaData copyWith({
    int? totalData,
    int? page,
    int? limit,
    int? totalPage,
  }) {
    return MetaData(
      totalData: totalData ?? this.totalData,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalData': totalData,
      'page': page,
      'limit': limit,
      'totalPage': totalPage,
    };
  }

  factory MetaData.fromMap(Map<String, dynamic> map) {
    return MetaData(
      totalData: map['totalData']?.toInt() ?? 0,
      page: map['page']?.toInt() ?? 0,
      limit: map['limit']?.toInt() ?? 0,
      totalPage: map['totalPage']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MetaData.fromJson(String source) =>
      MetaData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MetaData(totalData: $totalData, page: $page, limit: $limit, totalPage: $totalPage)';
  }

  @override
  List<Object> get props => [totalData, page, limit, totalPage];
}
