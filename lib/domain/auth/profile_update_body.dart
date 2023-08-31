import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProfileUpdateBody extends Equatable {
  final String name;
  final String address;
  final String pickupStyle;
  final String defaultPayment;
  final String paymentStyle;
  const ProfileUpdateBody({
    required this.name,
    required this.address,
    required this.pickupStyle,
    required this.defaultPayment,
    required this.paymentStyle,
  });

  ProfileUpdateBody copyWith({
    String? name,
    String? address,
    String? pickupStyle,
    String? defaultPayment,
    String? paymentStyle,
  }) {
    return ProfileUpdateBody(
      name: name ?? this.name,
      address: address ?? this.address,
      pickupStyle: pickupStyle ?? this.pickupStyle,
      defaultPayment: defaultPayment ?? this.defaultPayment,
      paymentStyle: paymentStyle ?? this.paymentStyle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'pickupStyle': pickupStyle,
      'defaultPayment': defaultPayment,
      'paymentStyle': paymentStyle,
    };
  }

  factory ProfileUpdateBody.fromMap(Map<String, dynamic> map) {
    return ProfileUpdateBody(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      pickupStyle: map['pickupStyle'] ?? '',
      defaultPayment: map['defaultPayment'] ?? '',
      paymentStyle: map['paymentStyle'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileUpdateBody.fromJson(String source) =>
      ProfileUpdateBody.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProfileUpdateBody(name: $name, address: $address, pickupStyle: $pickupStyle, defaultPayment: $defaultPayment, paymentStyle: $paymentStyle)';
  }

  @override
  List<Object> get props {
    return [
      name,
      address,
      pickupStyle,
      defaultPayment,
      paymentStyle,
    ];
  }
}
