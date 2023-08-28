import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'model/regular_charge_model.dart';

class UpdateParcelBody extends Equatable {
  final String customerPhone;
  final RegularPaymentModel regularPayment;
  const UpdateParcelBody({
    required this.customerPhone,
    required this.regularPayment,
  });

  UpdateParcelBody copyWith({
    String? customerPhone,
    RegularPaymentModel? regularPayment,
  }) {
    return UpdateParcelBody(
      customerPhone: customerPhone ?? this.customerPhone,
      regularPayment: regularPayment ?? this.regularPayment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerPhone': customerPhone,
      'regularPayment': regularPayment.toMap(),
    };
  }

  factory UpdateParcelBody.fromMap(Map<String, dynamic> map) {
    return UpdateParcelBody(
      customerPhone: map['customerPhone'] ?? '',
      regularPayment: RegularPaymentModel.fromMap(map['regularPayment']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateParcelBody.fromJson(String source) =>
      UpdateParcelBody.fromMap(json.decode(source));

  @override
  String toString() =>
      'UpdateParcelBody(customerPhone: $customerPhone, regularPayment: $regularPayment)';

  @override
  List<Object> get props => [customerPhone, regularPayment];
}
