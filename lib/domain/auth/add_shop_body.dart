import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddShopBody extends Equatable {
  final String shopName;
  final String address;

  const AddShopBody({
    required this.shopName,
    required this.address,
  });

  AddShopBody copyWith({
    String? shopName,
    String? address,
  }) {
    return AddShopBody(
      shopName: shopName ?? this.shopName,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopName': shopName,
      'address': address,
    };
  }

  factory AddShopBody.fromMap(Map<String, dynamic> map) {
    return AddShopBody(
      shopName: map['shopName'] ?? '',
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddShopBody.fromJson(String source) => AddShopBody.fromMap(json.decode(source));

  @override
  String toString() => 'AddParcelBody(shopName: $shopName, address: $address)';

  @override
  List<Object> get props => [shopName, address];
}