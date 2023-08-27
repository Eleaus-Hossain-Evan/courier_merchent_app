import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddShopBody extends Equatable {
  final String shopName;
  final String address;
  final String districtId;
  final String areaId;

  const AddShopBody({
    required this.shopName,
    required this.address,
    required this.districtId,
    required this.areaId,
  });

  AddShopBody copyWith({
    String? shopName,
    String? address,
    String? districtId,
    String? areaId,
  }) {
    return AddShopBody(
      shopName: shopName ?? this.shopName,
      address: address ?? this.address,
      districtId: districtId ?? this.districtId,
      areaId: areaId ?? this.areaId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopName': shopName,
      'address': address,
      'districtId': districtId,
      'areaId': areaId,
    };
  }

  factory AddShopBody.fromMap(Map<String, dynamic> map) {
    return AddShopBody(
      shopName: map['shopName'] ?? '',
      address: map['address'] ?? '',
      districtId: map['districtId'] ?? '',
      areaId: map['areaId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddShopBody.fromJson(String source) =>
      AddShopBody.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddShopBody(shopName: $shopName, address: $address, districtId: $districtId, areaId: $areaId)';
  }

  @override
  List<Object> get props => [shopName, address, districtId, areaId];
}
