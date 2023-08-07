import 'dart:convert';

import 'package:equatable/equatable.dart';

class AreaModel extends Equatable {
  final String id;
  final String name;

  const AreaModel({
    required this.id,
    required this.name,
  });

  factory AreaModel.init() => const AreaModel(id: '', name: '');

  AreaModel copyWith({
    String? id,
    String? name,
  }) {
    return AreaModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
    };
  }

  factory AreaModel.fromMap(Map<String, dynamic> map) {
    return AreaModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AreaModel.fromJson(String source) =>
      AreaModel.fromMap(json.decode(source));

  @override
  String toString() => 'Data(_id: $id, name: $name)';

  @override
  List<Object> get props => [id, name];
}
