import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:courier_merchent_app/domain/auth/model/area_model.dart';

class CustomerInfoModel extends Equatable {
  final String name;
  final String phone;
  final String address;
  final String districtId;
  final String areaId;
  final AreaModel district;
  final AreaModel area;

  const CustomerInfoModel({
    required this.name,
    required this.phone,
    required this.address,
    required this.districtId,
    required this.areaId,
    required this.district,
    required this.area,
  });

  factory CustomerInfoModel.init() => CustomerInfoModel(
        name: '',
        phone: '',
        address: '',
        districtId: '',
        areaId: '',
        area: AreaModel.init(),
        district: AreaModel.init(),
      );

  CustomerInfoModel copyWith({
    String? name,
    String? phone,
    String? address,
    String? districtId,
    String? areaId,
    AreaModel? district,
    AreaModel? area,
  }) {
    return CustomerInfoModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      districtId: districtId ?? this.districtId,
      areaId: areaId ?? this.areaId,
      district: district ?? this.district,
      area: area ?? this.area,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
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
      'address': address,
      'districtId': districtId,
      'areaId': areaId,
    };
  }

  factory CustomerInfoModel.fromMap(Map<String, dynamic> map) {
    return CustomerInfoModel(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
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

  factory CustomerInfoModel.fromJson(String source) =>
      CustomerInfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerInfoModel(name: $name, phone: $phone, address: $address, districtId: $districtId, areaId: $areaId, district: $district, area: $area)';
  }

  @override
  List<Object> get props {
    return [
      name,
      phone,
      address,
      districtId,
      areaId,
    ];
  }
}
