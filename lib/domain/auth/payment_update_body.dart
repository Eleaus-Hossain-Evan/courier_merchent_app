import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:courier_merchent_app/domain/auth/model/bank_account_model.dart';
import 'package:courier_merchent_app/domain/auth/model/other_account_model.dart';

class PaymentUpdateBody extends Equatable {
  final BankAccountModel bankAccount;
  final OthersAccountModel othersAccount;
  const PaymentUpdateBody({
    required this.bankAccount,
    required this.othersAccount,
  });

  PaymentUpdateBody copyWith({
    BankAccountModel? bankAccount,
    OthersAccountModel? othersAccount,
  }) {
    return PaymentUpdateBody(
      bankAccount: bankAccount ?? this.bankAccount,
      othersAccount: othersAccount ?? this.othersAccount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bankAccount': bankAccount.toMap(),
      'othersAccount': othersAccount.toMap(),
    };
  }

  factory PaymentUpdateBody.fromMap(Map<String, dynamic> map) {
    return PaymentUpdateBody(
      bankAccount: BankAccountModel.fromMap(map['bankAccount']),
      othersAccount: OthersAccountModel.fromMap(map['othersAccount']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentUpdateBody.fromJson(String source) =>
      PaymentUpdateBody.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaymentUpdateBody(bankAccount: $bankAccount, othersAccount: $othersAccount)';

  @override
  List<Object> get props => [bankAccount, othersAccount];
}
