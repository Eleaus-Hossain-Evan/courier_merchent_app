import 'dart:convert';

import 'package:equatable/equatable.dart';

class ShopResponse extends Equatable {
  final Data data;
  final bool success;
  final String message;
  const ShopResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  ShopResponse copyWith({
    Data? data,
    bool? success,
    String? message,
  }) {
    return ShopResponse(
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

  factory ShopResponse.fromMap(Map<String, dynamic> map) {
    return ShopResponse(
      data: Data.fromMap(map['data']),
      success: map['success'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopResponse.fromJson(String source) =>
      ShopResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'ShopUpdateResponse(data: $data, success: $success, message: $message)';

  @override
  List<Object> get props => [data, success, message];
}

class Data extends Equatable {
  final String id;
  final String shopName;
  final String districtId;
  final String areaId;
  final String address;
  final String merchantId;
  final String createdAt;
  final String updatedAt;

  const Data({
    required this.id,
    required this.shopName,
    required this.districtId,
    required this.areaId,
    required this.address,
    required this.merchantId,
    required this.createdAt,
    required this.updatedAt,
  });

  Data copyWith({
    String? id,
    String? shopName,
    String? districtId,
    String? areaId,
    String? address,
    String? merchantId,
    String? createdAt,
    String? updatedAt,
  }) {
    return Data(
      id: id ?? this.id,
      shopName: shopName ?? this.shopName,
      districtId: districtId ?? this.districtId,
      areaId: areaId ?? this.areaId,
      address: address ?? this.address,
      merchantId: merchantId ?? this.merchantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'shopName': shopName,
      'districtId': districtId,
      'areaId': areaId,
      'address': address,
      'merchantId': merchantId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['_id'] ?? '',
      shopName: map['shopName'] ?? '',
      districtId: map['districtId'] ?? '',
      areaId: map['areaId'] ?? '',
      address: map['address'] ?? '',
      merchantId: map['merchantId'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(_id: $id, shopName: $shopName, districtId: $districtId, areaId: $areaId, address: $address, merchantId: $merchantId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      shopName,
      districtId,
      areaId,
      address,
      merchantId,
      createdAt,
      updatedAt,
    ];
  }
}
