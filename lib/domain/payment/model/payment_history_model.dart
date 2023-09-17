import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../parcel/model/merchant_info_model.dart';
import '../../parcel/model/parcel_model.dart';

class HistoryPaymentModel extends Equatable {
  final String id;
  final List<String> parcelIds;
  final int totalCashCollection;
  final int totalDeliverCharge;
  final int prevMerchantDue;
  final String details;
  final List<String> files;
  final String serialId;

  final MerchantInfoModel merchant;
  final List<ParcelModel> parcels;

  const HistoryPaymentModel({
    required this.id,
    required this.parcelIds,
    required this.totalCashCollection,
    required this.totalDeliverCharge,
    required this.prevMerchantDue,
    required this.details,
    required this.files,
    required this.serialId,
    required this.merchant,
    required this.parcels,
  });

  factory HistoryPaymentModel.init() => HistoryPaymentModel(
        id: '',
        parcelIds: const [],
        totalCashCollection: 0,
        totalDeliverCharge: 0,
        prevMerchantDue: 0,
        details: '',
        files: const [],
        serialId: '',
        merchant: MerchantInfoModel.init(),
        parcels: const [],
      );

  HistoryPaymentModel copyWith({
    String? id,
    List<String>? parcelIds,
    int? totalCashCollection,
    int? totalDeliverCharge,
    int? prevMerchantDue,
    String? details,
    List<String>? files,
    String? serialId,
    MerchantInfoModel? merchant,
    List<ParcelModel>? parcels,
  }) {
    return HistoryPaymentModel(
      id: id ?? this.id,
      parcelIds: parcelIds ?? this.parcelIds,
      totalCashCollection: totalCashCollection ?? this.totalCashCollection,
      totalDeliverCharge: totalDeliverCharge ?? this.totalDeliverCharge,
      prevMerchantDue: prevMerchantDue ?? this.prevMerchantDue,
      details: details ?? this.details,
      files: files ?? this.files,
      serialId: serialId ?? this.serialId,
      merchant: merchant ?? this.merchant,
      parcels: parcels ?? this.parcels,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'parcelIds': parcelIds,
      'totalCashCollection': totalCashCollection,
      'totalDeliverCharge': totalDeliverCharge,
      'prevMerchantDue': prevMerchantDue,
      'details': details,
      'files': files,
      'serialId': serialId,
      'merchant': merchant.toMap(),
      'parcels': parcels.map((x) => x.toMap()).toList(),
    };
  }

  factory HistoryPaymentModel.fromMap(Map<String, dynamic> map) {
    return HistoryPaymentModel(
      id: map['_id'] ?? '',
      parcelIds: List<String>.from(map['parcelIds'] ?? const []),
      totalCashCollection: map['totalCashCollection']?.toInt() ?? 0,
      totalDeliverCharge: map['totalDeliverCharge']?.toInt() ?? 0,
      prevMerchantDue: map['prevMerchantDue']?.toInt() ?? 0,
      details: map['details'] ?? '',
      files: List<String>.from(map['files'] ?? const []),
      serialId: map['serialId'] ?? '',
      merchant: map['merchant'] != null
          ? MerchantInfoModel.fromMap(map['merchant'])
          : MerchantInfoModel.init(),
      parcels: List<ParcelModel>.from(
          map['parcels']?.map((x) => ParcelModel.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryPaymentModel.fromJson(String source) =>
      HistoryPaymentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HistoryPaymentListModel(id: $id, parcelIds: $parcelIds, totalCashCollection: $totalCashCollection, totalDeliverCharge: $totalDeliverCharge, prevMerchantDue: $prevMerchantDue, details: $details, files: $files, serialId: $serialId, merchant: $merchant, parcels: $parcels)';
  }

  @override
  List<Object> get props {
    return [
      id,
      parcelIds,
      totalCashCollection,
      totalDeliverCharge,
      prevMerchantDue,
      details,
      files,
      serialId,
      merchant,
      parcels,
    ];
  }
}
