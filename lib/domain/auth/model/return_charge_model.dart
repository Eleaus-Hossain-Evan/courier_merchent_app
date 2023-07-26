import 'dart:convert';

class ReturnChargeModel {
  final double inside;
  final double outside;
  final double subside;

  ReturnChargeModel({
    required this.inside,
    required this.outside,
    required this.subside,
  });

  factory ReturnChargeModel.init() =>
      ReturnChargeModel(inside: 0, outside: 0, subside: 0);
  ReturnChargeModel copyWith({
    double? inside,
    double? outside,
    double? subside,
  }) {
    return ReturnChargeModel(
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

  factory ReturnChargeModel.fromMap(Map<String, dynamic> map) {
    return ReturnChargeModel(
      inside: map['inside']?.toDouble() ?? 0.0,
      outside: map['outside']?.toDouble() ?? 0.0,
      subside: map['subside']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReturnChargeModel.fromJson(String source) =>
      ReturnChargeModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ReturnChargeModel(inside: $inside, outside: $outside, subside: $subside)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReturnChargeModel &&
        other.inside == inside &&
        other.outside == outside &&
        other.subside == subside;
  }

  @override
  int get hashCode => inside.hashCode ^ outside.hashCode ^ subside.hashCode;
}
