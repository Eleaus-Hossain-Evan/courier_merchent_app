import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProfileUpdateBody extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String pickUpStyle;

  const ProfileUpdateBody({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.pickUpStyle,
  });

  ProfileUpdateBody copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? pickUpStyle,
  }) {
    return ProfileUpdateBody(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      pickUpStyle: pickUpStyle ?? this.pickUpStyle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'pickUpStyle': pickUpStyle,
    };
  }

  factory ProfileUpdateBody.fromMap(Map<String, dynamic> map) {
    return ProfileUpdateBody(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      pickUpStyle: map['pickUpStyle'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileUpdateBody.fromJson(String source) =>
      ProfileUpdateBody.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProfileUpdateBody(name: $name, email: $email, phone: $phone, address: $address, pickUpStyle: $pickUpStyle)';
  }

  @override
  List<Object> get props {
    return [
      name,
      email,
      phone,
      address,
      pickUpStyle,
    ];
  }
}
