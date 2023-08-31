import 'dart:convert';

import 'package:equatable/equatable.dart';

class OthersAccountModel extends Equatable {
  final String bkashNum;
  final String nagadNum;

  const OthersAccountModel({
    required this.bkashNum,
    required this.nagadNum,
  });

  factory OthersAccountModel.init() =>
      const OthersAccountModel(bkashNum: '', nagadNum: '');

  OthersAccountModel copyWith({
    String? bkashNum,
    String? nagadNum,
  }) {
    return OthersAccountModel(
      bkashNum: bkashNum ?? this.bkashNum,
      nagadNum: nagadNum ?? this.nagadNum,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bkashNum': bkashNum,
      'nagadNum': nagadNum,
    };
  }

  factory OthersAccountModel.fromMap(Map<String, dynamic> map) {
    return OthersAccountModel(
      bkashNum: map['bkashNum'] ?? '',
      nagadNum: map['nagadNum'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OthersAccountModel.fromJson(String source) =>
      OthersAccountModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'OthersAccountModel(bkashNum: $bkashNum, nagadNum: $nagadNum)';

  @override
  List<Object> get props => [bkashNum, nagadNum];
}
