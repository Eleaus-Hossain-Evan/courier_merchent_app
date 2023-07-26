import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrderBody extends Equatable {
  final List<String> orders;
  final String fullName;
  final String phone;
  // final AddressInfo addressInfo;
  final int paymentType;
  const OrderBody({
    required this.orders,
    required this.fullName,
    required this.phone,
    required this.paymentType,
  });

  OrderBody copyWith({
    List<String>? orders,
    String? fullName,
    String? phone,
    int? paymentType,
  }) {
    return OrderBody(
      orders: orders ?? this.orders,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      paymentType: paymentType ?? this.paymentType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orders': orders,
      'fullName': fullName,
      'phone': phone,
      'paymentType': paymentType,
    };
  }

  factory OrderBody.fromMap(Map<String, dynamic> map) {
    return OrderBody(
      orders: List<String>.from(map['orders'] ?? const []),
      fullName: map['fullName'] ?? '',
      phone: map['phone'] ?? '',
      paymentType: map['paymentType']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderBody.fromJson(String source) =>
      OrderBody.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderBody(orders: $orders, fullName: $fullName, phone: $phone, paymentType: $paymentType)';
  }

  @override
  List<Object> get props => [orders, fullName, phone, paymentType];
}
