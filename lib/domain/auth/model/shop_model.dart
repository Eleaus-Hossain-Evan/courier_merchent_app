import 'dart:convert';

import 'package:equatable/equatable.dart';

class MyShopModel extends Equatable {
  final String id;
  final String shopName;
  final String address;

  const MyShopModel({
    required this.id,
    required this.shopName,
    required this.address,
  });

  MyShopModel copyWith({
    String? id,
    String? shopName,
    String? address,
  }) {
    return MyShopModel(
      id: id ?? this.id,
      shopName: shopName ?? this.shopName,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'shopName': shopName,
      'address': address,
    };
  }

  factory MyShopModel.fromMap(Map<String, dynamic> map) {
    return MyShopModel(
      id: map['_id'] ?? '',
      shopName: map['shopName'] ?? '',
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MyShopModel.fromJson(String source) =>
      MyShopModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'MyShop(_id: $id, shopName: $shopName, address: $address)';

  @override
  List<Object> get props => [id, shopName, address];
}
