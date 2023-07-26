import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'bank_account_model.dart';
import 'other_account_model.dart';
import 'reguler_charge_model.dart';
import 'return_charge_model.dart';
import 'shop_model.dart';

class UserModel {
  final BankAccountModel bankAccount;
  final OthersAccountModel othersAccount;
  final RegularChargeModel regularCharge;
  final ReturnChargeModel returnCharge;
  final String serialId;
  final String address;
  final String image;
  final String hubId;
  final String pickupStyle;
  final String defaultPayment;
  final String paymentStyle;
  final bool isApproved;
  final bool isDisabled;
  final String createdBy;
  final String role;
  final String id;
  final String name;
  final String email;
  final String phone;
  final List<MyShopModel> myShops;
  final String createdAt;
  final String updatedAt;
  final List<dynamic> updateHistory;
  final String token;

  UserModel({
    required this.bankAccount,
    required this.othersAccount,
    required this.regularCharge,
    required this.returnCharge,
    required this.serialId,
    required this.address,
    required this.image,
    required this.hubId,
    required this.pickupStyle,
    required this.defaultPayment,
    required this.paymentStyle,
    required this.isApproved,
    required this.isDisabled,
    required this.createdBy,
    required this.role,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.myShops,
    required this.createdAt,
    required this.updatedAt,
    required this.updateHistory,
    required this.token,
  });

  factory UserModel.init() {
    return UserModel(
      bankAccount: BankAccountModel.init(),
      othersAccount: OthersAccountModel.init(),
      regularCharge: RegularChargeModel.init(),
      returnCharge: ReturnChargeModel.init(),
      serialId: '',
      address: '',
      image: '',
      hubId: '',
      pickupStyle: '',
      defaultPayment: '',
      paymentStyle: '',
      isApproved: false,
      isDisabled: false,
      createdBy: '',
      role: '',
      id: '',
      name: '',
      email: '',
      phone: '',
      myShops: [],
      createdAt: '',
      updatedAt: '',
      updateHistory: [],
      token: '',
    );
  }

  UserModel copyWith({
    BankAccountModel? bankAccount,
    OthersAccountModel? othersAccount,
    RegularChargeModel? regularCharge,
    ReturnChargeModel? returnCharge,
    String? serialId,
    String? address,
    String? image,
    String? hubId,
    String? pickupStyle,
    String? defaultPayment,
    String? paymentStyle,
    bool? isApproved,
    bool? isDisabled,
    String? createdBy,
    String? role,
    String? id,
    String? name,
    String? email,
    String? password,
    String? phone,
    List<MyShopModel>? myShops,
    String? createdAt,
    String? updatedAt,
    List<dynamic>? updateHistory,
    String? token,
  }) {
    return UserModel(
      bankAccount: bankAccount ?? this.bankAccount,
      othersAccount: othersAccount ?? this.othersAccount,
      regularCharge: regularCharge ?? this.regularCharge,
      returnCharge: returnCharge ?? this.returnCharge,
      serialId: serialId ?? this.serialId,
      address: address ?? this.address,
      image: image ?? this.image,
      hubId: hubId ?? this.hubId,
      pickupStyle: pickupStyle ?? this.pickupStyle,
      defaultPayment: defaultPayment ?? this.defaultPayment,
      paymentStyle: paymentStyle ?? this.paymentStyle,
      isApproved: isApproved ?? this.isApproved,
      isDisabled: isDisabled ?? this.isDisabled,
      createdBy: createdBy ?? this.createdBy,
      role: role ?? this.role,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      myShops: myShops ?? this.myShops,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      updateHistory: updateHistory ?? this.updateHistory,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bankAccount': bankAccount.toMap(),
      'othersAccount': othersAccount.toMap(),
      'regularCharge': regularCharge.toMap(),
      'returnCharge': returnCharge.toMap(),
      'serialId': serialId,
      'address': address,
      'image': image,
      'hubId': hubId,
      'pickupStyle': pickupStyle,
      'defaultPayment': defaultPayment,
      'paymentStyle': paymentStyle,
      'isApproved': isApproved,
      'isDisabled': isDisabled,
      'createdBy': createdBy,
      'role': role,
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'myShops': myShops.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'updateHistory': updateHistory,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      bankAccount: BankAccountModel.fromMap(map['bankAccount']),
      othersAccount: OthersAccountModel.fromMap(map['othersAccount']),
      regularCharge: RegularChargeModel.fromMap(map['regularCharge']),
      returnCharge: ReturnChargeModel.fromMap(map['returnCharge']),
      serialId: map['serialId'] ?? '',
      address: map['address'] ?? '',
      image: map['image'] ?? '',
      hubId: map['hubId'] ?? '',
      pickupStyle: map['pickupStyle'] ?? '',
      defaultPayment: map['defaultPayment'] ?? '',
      paymentStyle: map['paymentStyle'] ?? '',
      isApproved: map['isApproved'] ?? false,
      isDisabled: map['isDisabled'] ?? false,
      createdBy: map['createdBy'] ?? '',
      role: map['role'] ?? '',
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      myShops: List<MyShopModel>.from(
          map['myShops']?.map((x) => MyShopModel.fromMap(x))),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      updateHistory: List<dynamic>.from(map['updateHistory']),
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(bankAccount: $bankAccount, othersAccount: $othersAccount, regularCharge: $regularCharge, returnCharge: $returnCharge, serialId: $serialId, address: $address, image: $image, hubId: $hubId, pickupStyle: $pickupStyle, defaultPayment: $defaultPayment, paymentStyle: $paymentStyle, isApproved: $isApproved, isDisabled: $isDisabled, createdBy: $createdBy, role: $role, _id: $id, name: $name, email: $email, phone: $phone, myShops: $myShops, createdAt: $createdAt, updatedAt: $updatedAt, updateHistory: $updateHistory, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.bankAccount == bankAccount &&
        other.othersAccount == othersAccount &&
        other.regularCharge == regularCharge &&
        other.returnCharge == returnCharge &&
        other.serialId == serialId &&
        other.address == address &&
        other.image == image &&
        other.hubId == hubId &&
        other.pickupStyle == pickupStyle &&
        other.defaultPayment == defaultPayment &&
        other.paymentStyle == paymentStyle &&
        other.isApproved == isApproved &&
        other.isDisabled == isDisabled &&
        other.createdBy == createdBy &&
        other.role == role &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        listEquals(other.myShops, myShops) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.updateHistory, updateHistory) &&
        other.token == token;
  }

  @override
  int get hashCode {
    return bankAccount.hashCode ^
        othersAccount.hashCode ^
        regularCharge.hashCode ^
        returnCharge.hashCode ^
        serialId.hashCode ^
        address.hashCode ^
        image.hashCode ^
        hubId.hashCode ^
        pickupStyle.hashCode ^
        defaultPayment.hashCode ^
        paymentStyle.hashCode ^
        isApproved.hashCode ^
        isDisabled.hashCode ^
        createdBy.hashCode ^
        role.hashCode ^
        id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        myShops.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        updateHistory.hashCode ^
        token.hashCode;
  }
}
