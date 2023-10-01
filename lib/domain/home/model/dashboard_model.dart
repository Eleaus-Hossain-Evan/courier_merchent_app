import 'dart:convert';

import 'package:equatable/equatable.dart';

class DashboardModel extends Equatable {
  final ParcelList parcelList;
  final ParcelPay parcelPay;
  const DashboardModel({
    required this.parcelList,
    required this.parcelPay,
  });

  factory DashboardModel.init() => DashboardModel(
        parcelList: ParcelList.init(),
        parcelPay: ParcelPay.init(),
      );

  DashboardModel copyWith({
    ParcelList? parcelList,
    ParcelPay? parcelPay,
  }) {
    return DashboardModel(
      parcelList: parcelList ?? this.parcelList,
      parcelPay: parcelPay ?? this.parcelPay,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'parcelList': parcelList.toMap(),
      'parcelPay': parcelPay.toMap(),
    };
  }

  factory DashboardModel.fromMap(Map<String, dynamic> map) {
    return DashboardModel(
      parcelList: ParcelList.fromMap(map['parcelList']),
      parcelPay: ParcelPay.fromMap(map['parcelPay']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardModel.fromJson(String source) =>
      DashboardModel.fromMap(json.decode(source));

  @override
  String toString() => 'Data(parcelList: $parcelList, parcelPay: $parcelPay)';

  @override
  List<Object> get props => [parcelList, parcelPay];
}

class ParcelList extends Equatable {
  final int tParcel;
  final int tPending;
  final int tHold;
  final int tPickup;
  final int tShipping;
  final int tShipped;
  final int tDropoff;
  final int tPartial;
  final int tReturnEnd;
  final int tCancel;
  const ParcelList({
    required this.tParcel,
    required this.tPending,
    required this.tHold,
    required this.tPickup,
    required this.tShipping,
    required this.tShipped,
    required this.tDropoff,
    required this.tPartial,
    required this.tReturnEnd,
    required this.tCancel,
  });

  factory ParcelList.init() => const ParcelList(
        tParcel: 0,
        tPending: 0,
        tHold: 0,
        tPickup: 0,
        tShipping: 0,
        tShipped: 0,
        tDropoff: 0,
        tPartial: 0,
        tReturnEnd: 0,
        tCancel: 0,
      );

  ParcelList copyWith({
    int? tParcel,
    int? tPending,
    int? tHold,
    int? tPickup,
    int? tShipping,
    int? tShipped,
    int? tDropoff,
    int? tPartial,
    int? tReturnEnd,
    int? tCancel,
  }) {
    return ParcelList(
      tParcel: tParcel ?? this.tParcel,
      tPending: tPending ?? this.tPending,
      tHold: tHold ?? this.tHold,
      tPickup: tPickup ?? this.tPickup,
      tShipping: tShipping ?? this.tShipping,
      tShipped: tShipped ?? this.tShipped,
      tDropoff: tDropoff ?? this.tDropoff,
      tPartial: tPartial ?? this.tPartial,
      tReturnEnd: tReturnEnd ?? this.tReturnEnd,
      tCancel: tCancel ?? this.tCancel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tParcel': tParcel,
      'tPending': tPending,
      'tHold': tHold,
      'tPickup': tPickup,
      'tShipping': tShipping,
      'tShipped': tShipped,
      'tDropoff': tDropoff,
      'tPartial': tPartial,
      'tReturnEnd': tReturnEnd,
      'tCancel': tCancel,
    };
  }

  factory ParcelList.fromMap(Map<String, dynamic> map) {
    return ParcelList(
      tParcel: map['tParcel']?.toInt() ?? 0,
      tPending: map['tPending']?.toInt() ?? 0,
      tHold: map['tHold']?.toInt() ?? 0,
      tPickup: map['tPickup']?.toInt() ?? 0,
      tShipping: map['tShipping']?.toInt() ?? 0,
      tShipped: map['tShipped']?.toInt() ?? 0,
      tDropoff: map['tDropoff']?.toInt() ?? 0,
      tPartial: map['tPartial']?.toInt() ?? 0,
      tReturnEnd: map['tReturnEnd']?.toInt() ?? 0,
      tCancel: map['tCancel']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParcelList.fromJson(String source) =>
      ParcelList.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParcelList(tParcel: $tParcel, tPending: $tPending, tHold: $tHold, tPickup: $tPickup, tShipping: $tShipping, tShipped: $tShipped, tDropoff: $tDropoff, tPartial: $tPartial, tReturnEnd: $tReturnEnd, tCancel: $tCancel)';
  }

  @override
  List<Object> get props {
    return [
      tParcel,
      tPending,
      tHold,
      tPickup,
      tShipping,
      tShipped,
      tDropoff,
      tPartial,
      tReturnEnd,
      tCancel,
    ];
  }
}

class ParcelPay extends Equatable {
  final int tPayCollection;
  final int tPayPending;
  final int tPayProcessing;
  final int tPayDeliveryCharge;
  final double tPayWithdraw;
  const ParcelPay({
    required this.tPayCollection,
    required this.tPayPending,
    required this.tPayProcessing,
    required this.tPayDeliveryCharge,
    required this.tPayWithdraw,
  });

  factory ParcelPay.init() => const ParcelPay(
        tPayCollection: 0,
        tPayPending: 0,
        tPayProcessing: 0,
        tPayDeliveryCharge: 0,
        tPayWithdraw: 0.0,
      );

  ParcelPay copyWith({
    int? tPayCollection,
    int? tPayPending,
    int? tPayProcessing,
    int? tPayDeliveryCharge,
    double? tPayWithdraw,
  }) {
    return ParcelPay(
      tPayCollection: tPayCollection ?? this.tPayCollection,
      tPayPending: tPayPending ?? this.tPayPending,
      tPayProcessing: tPayProcessing ?? this.tPayProcessing,
      tPayDeliveryCharge: tPayDeliveryCharge ?? this.tPayDeliveryCharge,
      tPayWithdraw: tPayWithdraw ?? this.tPayWithdraw,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tPayCollection': tPayCollection,
      'tPayPending': tPayPending,
      'tPayProcessing': tPayProcessing,
      'tPayDeliveryCharge': tPayDeliveryCharge,
      'tPayWithdraw': tPayWithdraw,
    };
  }

  factory ParcelPay.fromMap(Map<String, dynamic> map) {
    return ParcelPay(
      tPayCollection: map['tPayCollection']?.toInt() ?? 0,
      tPayPending: map['tPayPending']?.toInt() ?? 0,
      tPayProcessing: map['tPayProcessing']?.toInt() ?? 0,
      tPayDeliveryCharge: map['tPayDeliveryCharge']?.toInt() ?? 0,
      tPayWithdraw: map['tPayWithdraw']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParcelPay.fromJson(String source) =>
      ParcelPay.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParcelPay(tPayCollection: $tPayCollection, tPayPending: $tPayPending, tPayProcessing: $tPayProcessing, tPayDeliveryCharge: $tPayDeliveryCharge, tPayWithdraw: $tPayWithdraw)';
  }

  @override
  List<Object> get props {
    return [
      tPayCollection,
      tPayPending,
      tPayProcessing,
      tPayDeliveryCharge,
      tPayWithdraw,
    ];
  }
}
