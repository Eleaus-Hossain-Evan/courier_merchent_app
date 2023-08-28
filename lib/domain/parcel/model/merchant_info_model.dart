import 'dart:convert';

import 'package:equatable/equatable.dart';

class MerchantInfoModel extends Equatable {
  final String address;
  final String name;
  final String phone;
  final String shopName;
  final String districtId;
  final String areaId;

  const MerchantInfoModel({
    required this.address,
    required this.name,
    required this.phone,
    required this.shopName,
    required this.districtId,
    required this.areaId,
  });

  factory MerchantInfoModel.init() => const MerchantInfoModel(
        address: '',
        name: '',
        phone: '',
        shopName: '',
        districtId: '',
        areaId: '',
      );

  MerchantInfoModel copyWith({
    String? address,
    String? name,
    String? phone,
    String? shopName,
    String? districtId,
    String? areaId,
  }) {
    return MerchantInfoModel(
      address: address ?? this.address,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      shopName: shopName ?? this.shopName,
      districtId: districtId ?? this.districtId,
      areaId: areaId ?? this.areaId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'name': name,
      'phone': phone,
      'shopName': shopName,
      'districtId': districtId,
      'areaId': areaId,
    };
  }

  factory MerchantInfoModel.fromMap(Map<String, dynamic> map) {
    return MerchantInfoModel(
      address: map['address'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      shopName: map['shopName'] ?? '',
      districtId: map['districtId'] ?? '',
      areaId: map['areaId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MerchantInfoModel.fromJson(String source) =>
      MerchantInfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MerchantInfoModel(address: $address, name: $name, phone: $phone, shopName: $shopName, districtId: $districtId, areaId: $areaId)';
  }

  @override
  List<Object> get props {
    return [
      address,
      name,
      phone,
      shopName,
      districtId,
      areaId,
    ];
  }
}
