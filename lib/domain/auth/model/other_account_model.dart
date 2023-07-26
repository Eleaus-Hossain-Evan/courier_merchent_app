import 'dart:convert';

class OthersAccountModel {
  final String bkashNum;
  final String rocketNum;
  final String nagadNum;

  OthersAccountModel({
    required this.bkashNum,
    required this.rocketNum,
    required this.nagadNum,
  });

  factory OthersAccountModel.init() =>
      OthersAccountModel(bkashNum: '', rocketNum: '', nagadNum: '');

  OthersAccountModel copyWith({
    String? bkashNum,
    String? rocketNum,
    String? nagadNum,
  }) {
    return OthersAccountModel(
      bkashNum: bkashNum ?? this.bkashNum,
      rocketNum: rocketNum ?? this.rocketNum,
      nagadNum: nagadNum ?? this.nagadNum,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bkashNum': bkashNum,
      'rocketNum': rocketNum,
      'nagadNum': nagadNum,
    };
  }

  factory OthersAccountModel.fromMap(Map<String, dynamic> map) {
    return OthersAccountModel(
      bkashNum: map['bkashNum'] ?? '',
      rocketNum: map['rocketNum'] ?? '',
      nagadNum: map['nagadNum'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OthersAccountModel.fromJson(String source) =>
      OthersAccountModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'OthersAccount(bkashNum: $bkashNum, rocketNum: $rocketNum, nagadNum: $nagadNum)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OthersAccountModel &&
        other.bkashNum == bkashNum &&
        other.rocketNum == rocketNum &&
        other.nagadNum == nagadNum;
  }

  @override
  int get hashCode =>
      bkashNum.hashCode ^ rocketNum.hashCode ^ nagadNum.hashCode;
}
