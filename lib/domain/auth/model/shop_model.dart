import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'area_model.dart';

class MyShopModel extends Equatable {
  final String id;
  final String shopName;
  final String address;
  final String createdAt;
  final AreaModel district;
  final AreaModel area;
  const MyShopModel({
    required this.id,
    required this.shopName,
    required this.address,
    required this.createdAt,
    required this.district,
    required this.area,
  });

  factory MyShopModel.init() => MyShopModel(
        id: '',
        shopName: '',
        address: '',
        createdAt: '',
        district: AreaModel.init(),
        area: AreaModel.init(),
      );

  MyShopModel copyWith({
    String? id,
    String? shopName,
    String? address,
    String? createdAt,
    AreaModel? district,
    AreaModel? area,
  }) {
    return MyShopModel(
      id: id ?? this.id,
      shopName: shopName ?? this.shopName,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      district: district ?? this.district,
      area: area ?? this.area,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'shopName': shopName,
      'address': address,
      'createdAt': createdAt,
      'district': district.toMap(),
      'area': area.toMap(),
    };
  }

  factory MyShopModel.fromMap(Map<String, dynamic> map) {
    return MyShopModel(
      id: map['_id'] ?? '',
      shopName: map['shopName'] ?? '',
      address: map['address'] ?? '',
      createdAt: map['createdAt'] ?? '',
      district: map['district'] != null
          ? AreaModel.fromMap(map['district'])
          : AreaModel.init(),
      area: map['area'] != null
          ? AreaModel.fromMap(map['area'])
          : AreaModel.init(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyShopModel.fromJson(String source) =>
      MyShopModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyShopModel(_id: $id, shopName: $shopName, address: $address, createdAt: $createdAt, district: $district, area: $area)';
  }

  @override
  List<Object> get props {
    return [
      id,
      shopName,
      address,
      createdAt,
      district,
      area,
    ];
  }
}
