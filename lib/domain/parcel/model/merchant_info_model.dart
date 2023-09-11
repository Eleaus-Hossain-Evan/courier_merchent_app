import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:courier_merchent_app/domain/auth/model/area_model.dart';

class MerchantInfoModel extends Equatable {
  final String address;
  final String name;
  final String phone;
  final String shopName;
  final String districtId;
  final String areaId;
  final AreaModel district;
  final AreaModel area;

  const MerchantInfoModel({
    required this.address,
    required this.name,
    required this.phone,
    required this.shopName,
    required this.districtId,
    required this.areaId,
    required this.district,
    required this.area,
  });

  factory MerchantInfoModel.init() => MerchantInfoModel(
      address: '',
      name: '',
      phone: '',
      shopName: '',
      districtId: '',
      areaId: '',
      area: AreaModel.init(),
      district: AreaModel.init());

  MerchantInfoModel copyWith({
    String? address,
    String? name,
    String? phone,
    String? shopName,
    String? districtId,
    String? areaId,
    AreaModel? district,
    AreaModel? area,
  }) {
    return MerchantInfoModel(
      address: address ?? this.address,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      shopName: shopName ?? this.shopName,
      districtId: districtId ?? this.districtId,
      areaId: areaId ?? this.areaId,
      district: district ?? this.district,
      area: area ?? this.area,
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
      'district': district.toMap(),
      'area': area.toMap(),
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'name': name,
      'phone': phone,
      'shopName': shopName,
      'address': address,
      'districtId': districtId,
      'areaId': areaId,
    };
  }

  factory MerchantInfoModel.fromMap(Map<String, dynamic> map) {
    return MerchantInfoModel(
      shopName: map['shopName'] ?? '',
      address: map['address'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      districtId: map['districtId'] ?? '',
      areaId: map['areaId'] ?? '',
      district: map['district'] != null
          ? AreaModel.fromMap(map['district'])
          : AreaModel.init(),
      area: map['area'] != null
          ? AreaModel.fromMap(map['area'])
          : AreaModel.init(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MerchantInfoModel.fromJson(String source) =>
      MerchantInfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MerchantInfoModel(address: $address, name: $name, phone: $phone, shopName: $shopName, districtId: $districtId, areaId: $areaId, district: $district, area: $area)';
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
      district,
      area,
    ];
  }
}
