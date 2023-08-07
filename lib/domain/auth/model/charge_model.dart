import 'dart:convert';

import 'package:equatable/equatable.dart';

class ChargeModel extends Equatable {
  final double inside;
  final double outside;
  final double subside;

  const ChargeModel({
    required this.inside,
    required this.outside,
    required this.subside,
  });

  factory ChargeModel.init() =>
      const ChargeModel(inside: 0, outside: 0, subside: 0);

  ChargeModel copyWith({
    double? inside,
    double? outside,
    double? subside,
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
      inside: map['inside']?.toDouble() ?? 0.0,
      outside: map['outside']?.toDouble() ?? 0.0,
      subside: map['subside']?.toDouble() ?? 0.0,
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
