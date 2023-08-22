import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'area_model.dart';

class HubModel extends Equatable {
  final String id;
  final String address;
  final String name;
  final String serialId;
  final AreaModel district;

  const HubModel({
    required this.id,
    required this.address,
    required this.name,
    required this.district,
    required this.serialId,
  });

  factory HubModel.init() => HubModel(
      id: '', address: '', name: '', district: AreaModel.init(), serialId: '');

  HubModel copyWith({
    String? id,
    String? address,
    String? name,
    String? serialId,
    AreaModel? district,
  }) {
    return HubModel(
      id: id ?? this.id,
      address: address ?? this.address,
      name: name ?? this.name,
      serialId: serialId ?? this.serialId,
      district: district ?? this.district,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'address': address,
      'name': name,
      'serialId': serialId,
      'district': district.toMap(),
    };
  }

  factory HubModel.fromMap(Map<String, dynamic> map) {
    return HubModel(
      id: map['_id'] ?? '',
      address: map['address'] ?? '',
      name: map['name'] ?? '',
      serialId: map['serialId'] ?? '',
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
    return 'HubModel(_id: $id, address: $address, name: $name, serialId: $serialId, district: $district)';
  }

  @override
  List<Object> get props {
    return [
      id,
      address,
      name,
      serialId,
      district,
    ];
  }
}
