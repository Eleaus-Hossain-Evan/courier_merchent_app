import 'dart:convert';

import 'package:equatable/equatable.dart';

class ChargeModel extends Equatable {
  final int inside;
  final int outside;
  final int subside;

  const ChargeModel({
    required this.inside,
    required this.outside,
    required this.subside,
  });

  factory ChargeModel.init() =>
      const ChargeModel(inside: 0, outside: 0, subside: 0);

  ChargeModel copyWith({
    int? inside,
    int? outside,
    int? subside,
  }) {
    return ChargeModel(
      inside: inside ?? this.inside,
      outside: outside ?? this.outside,
      subside: subside ?? this.subside,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'inside': inside,
      'outside': outside,
      'subside': subside,
    };
  }

  factory ChargeModel.fromMap(Map<String, dynamic> map) {
    return ChargeModel(
      inside: map['inside']?.toInt() ?? 0,
      outside: map['outside']?.toInt() ?? 0,
      subside: map['subside']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChargeModel.fromJson(String source) =>
      ChargeModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ChargeModel(inside: $inside, outside: $outside, subside: $subside)';

  @override
  List<Object> get props => [inside, outside, subside];
}
