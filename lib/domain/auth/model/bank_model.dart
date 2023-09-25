import 'dart:convert';

import 'package:equatable/equatable.dart';

class BankModel extends Equatable {
  final String id;
  final String name;
  final String createdAt;
  final String updatedAt;

  const BankModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BankModel.init() =>
      const BankModel(id: '', name: '', createdAt: '', updatedAt: '');

  BankModel copyWith({
    String? id,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) {
    return BankModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory BankModel.fromMap(Map<String, dynamic> map) {
    return BankModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BankModel.fromJson(String source) =>
      BankModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BankModel(_id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props => [id, name, createdAt, updatedAt];
}
