import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'area_model.dart';

class HubModel extends Equatable {
  final String id;
  final String address;
  final String name;
  final AreaModel district;

  const HubModel({
    required this.id,
    required this.address,
    required this.name,
    required this.district,
  });

  factory HubModel.init() =>
      HubModel(id: '', address: '', name: '', district: AreaModel.init());

  HubModel copyWith({
    String? id,
    String? address,
    String? name,
    AreaModel? district,
  }) {
    return HubModel(
      id: id ?? this.id,
      address: address ?? this.address,
      name: name ?? this.name,
      district: district ?? this.district,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'name': name,
      'district': district.toMap(),
    };
  }

  factory HubModel.fromMap(Map<String, dynamic> map) {
    return HubModel(
      id: map['id'] ?? '',
      address: map['address'] ?? '',
      name: map['name'] ?? '',
      district: map['district'] != null
          ? AreaModel.fromMap(map['district'])
          : AreaModel.init(),
    );
  }

  String toJson() => json.encode(toMap());

  factory HubModel.fromJson(String source) =>
      HubModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HubModel(id: $id, address: $address, name: $name, district: $district)';
  }

  @override
  List<Object> get props => [id, address, name, district];
}
