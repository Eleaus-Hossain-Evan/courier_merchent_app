import 'dart:convert';

class BankAccountModel {
  final String bankName;
  final String branch;
  final String routingNum;
  final String accName;
  final String accNum;

  BankAccountModel({
    required this.bankName,
    required this.branch,
    required this.routingNum,
    required this.accName,
    required this.accNum,
  });

  factory BankAccountModel.init() {
    return BankAccountModel(
      bankName: '',
      branch: '',
      routingNum: '',
      accName: '',
      accNum: '',
    );
  }

  BankAccountModel copyWith({
    String? bankName,
    String? branch,
    String? routingNum,
    String? accName,
    String? accNum,
  }) {
    return BankAccountModel(
      bankName: bankName ?? this.bankName,
      branch: branch ?? this.branch,
      routingNum: routingNum ?? this.routingNum,
      accName: accName ?? this.accName,
      accNum: accNum ?? this.accNum,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bankName': bankName,
      'branch': branch,
      'routingNum': routingNum,
      'accName': accName,
      'accNum': accNum,
    };
  }

  factory BankAccountModel.fromMap(Map<String, dynamic> map) {
    return BankAccountModel(
      bankName: map['bankName'] ?? '',
      branch: map['branch'] ?? '',
      routingNum: map['routingNum'] ?? '',
      accName: map['accName'] ?? '',
      accNum: map['accNum'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BankAccountModel.fromJson(String source) =>
      BankAccountModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BankAccount(bankName: $bankName, branch: $branch, routingNum: $routingNum, accName: $accName, accNum: $accNum)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BankAccountModel &&
        other.bankName == bankName &&
        other.branch == branch &&
        other.routingNum == routingNum &&
        other.accName == accName &&
        other.accNum == accNum;
  }

  @override
  int get hashCode {
    return bankName.hashCode ^
        branch.hashCode ^
        routingNum.hashCode ^
        accName.hashCode ^
        accNum.hashCode;
  }
}
