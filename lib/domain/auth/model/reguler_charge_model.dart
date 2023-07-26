import 'dart:convert';

class RegularChargeModel {
  final double inside;
  final double outside;
  final double subside;

  RegularChargeModel({
    required this.inside,
    required this.outside,
    required this.subside,
  });

  factory RegularChargeModel.init() =>
      RegularChargeModel(inside: 0, outside: 0, subside: 0);

  RegularChargeModel copyWith({
    double? inside,
    double? outside,
    double? subside,
  }) {
    return RegularChargeModel(
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

  factory RegularChargeModel.fromMap(Map<String, dynamic> map) {
    return RegularChargeModel(
      inside: map['inside']?.toDouble() ?? 0.0,
      outside: map['outside']?.toDouble() ?? 0.0,
      subside: map['subside']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegularChargeModel.fromJson(String source) =>
      RegularChargeModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'RegularChargeModel(inside: $inside, outside: $outside, subside: $subside)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegularChargeModel &&
        other.inside == inside &&
        other.outside == outside &&
        other.subside == subside;
  }

  @override
  int get hashCode => inside.hashCode ^ outside.hashCode ^ subside.hashCode;
}
