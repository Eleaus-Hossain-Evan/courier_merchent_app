import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'bank_account_model.dart';
import 'charge_model.dart';
import 'hub_model.dart';
import 'other_account_model.dart';
import 'shop_model.dart';

class UserModel extends Equatable {
  final String id;
  final String serialId;
  final String address;
  final String image;
  final String pickupStyle;
  final String defaultPayment;
  final String paymentStyle;
  final bool isDisabled;
  final String role;
  final String name;
  final String email;
  final String phone;
  final BankAccountModel bankAccount;
  final OthersAccountModel othersAccount;
  final List<MyShopModel> myShops;
  final String createdAt;
  final String updatedAt;
  final bool isApproved;
  final HubModel hub;
  final ChargeModel regularCharge;
  final ChargeModel returnCharge;
  final String token;

  const UserModel({
    required this.id,
    required this.serialId,
    required this.address,
    required this.image,
    required this.pickupStyle,
    required this.defaultPayment,
    required this.paymentStyle,
    required this.isDisabled,
    required this.role,
    required this.name,
    required this.email,
    required this.phone,
    required this.bankAccount,
    required this.othersAccount,
    required this.myShops,
    required this.createdAt,
    required this.updatedAt,
    required this.isApproved,
    required this.hub,
    required this.regularCharge,
    required this.returnCharge,
    required this.token,
  });

  factory UserModel.init() => UserModel(
        id: '',
        serialId: '',
        address: '',
        image: '',
        pickupStyle: '',
        defaultPayment: '',
        paymentStyle: '',
        isDisabled: false,
        role: '',
        name: '',
        email: '',
        phone: '',
        bankAccount: BankAccountModel.init(),
        othersAccount: OthersAccountModel.init(),
        myShops: const [],
        createdAt: '',
        updatedAt: '',
        isApproved: false,
        hub: HubModel.init(),
        regularCharge: ChargeModel.init(),
        returnCharge: ChargeModel.init(),
        token: '',
      );

  UserModel copyWith({
    String? id,
    String? serialId,
    String? address,
    String? image,
    String? pickupStyle,
    String? defaultPayment,
    String? paymentStyle,
    bool? isDisabled,
    String? role,
    String? name,
    String? email,
    String? phone,
    BankAccountModel? bankAccount,
    OthersAccountModel? othersAccount,
    List<MyShopModel>? myShops,
    String? createdAt,
    String? updatedAt,
    bool? isApproved,
    HubModel? hub,
    ChargeModel? regularCharge,
    ChargeModel? returnCharge,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      serialId: serialId ?? this.serialId,
      address: address ?? this.address,
      image: image ?? this.image,
      pickupStyle: pickupStyle ?? this.pickupStyle,
      defaultPayment: defaultPayment ?? this.defaultPayment,
      paymentStyle: paymentStyle ?? this.paymentStyle,
      isDisabled: isDisabled ?? this.isDisabled,
      role: role ?? this.role,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bankAccount: bankAccount ?? this.bankAccount,
      othersAccount: othersAccount ?? this.othersAccount,
      myShops: myShops ?? this.myShops,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isApproved: isApproved ?? this.isApproved,
      hub: hub ?? this.hub,
      regularCharge: regularCharge ?? this.regularCharge,
      returnCharge: returnCharge ?? this.returnCharge,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'serialId': serialId,
      'address': address,
      'image': image,
      'pickupStyle': pickupStyle,
      'defaultPayment': defaultPayment,
      'paymentStyle': paymentStyle,
      'isDisabled': isDisabled,
      'role': role,
      'name': name,
      'email': email,
      'phone': phone,
      'bankAccount': bankAccount.toMap(),
      'othersAccount': othersAccount.toMap(),
      'myShops': myShops.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isApproved': isApproved,
      'hub': hub.toMap(),
      'regularCharge': regularCharge.toMap(),
      'returnCharge': returnCharge.toMap(),
      'token': token,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      "name": name,
      "address": address,
      "hubId": "",
      "pickupStyle": pickupStyle,
      "defaultPayment": defaultPayment,
      "paymentStyle": paymentStyle,
      "bankAccount": bankAccount.toMap(),
      "othersAccount": othersAccount.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      serialId: map['serialId'] ?? '',
      address: map['address'] ?? '',
      image: map['image'] ?? '',
      pickupStyle: map['pickupStyle'] ?? '',
      defaultPayment: map['defaultPayment'] ?? '',
      paymentStyle: map['paymentStyle'] ?? '',
      isDisabled: map['isDisabled'] ?? false,
      role: map['role'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      bankAccount: map['bankAccount'] != null
          ? BankAccountModel.fromMap(map['bankAccount'])
          : BankAccountModel.init(),
      othersAccount: map['othersAccount'] != null
          ? OthersAccountModel.fromMap(map['othersAccount'])
          : OthersAccountModel.init(),
      myShops: List<MyShopModel>.from(
          map['myShops']?.map((x) => MyShopModel.fromMap(x)) ?? const []),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      isApproved: map['isApproved'] ?? false,
      hub: map['hub'] != null ? HubModel.fromMap(map['hub']) : HubModel.init(),
      regularCharge: map['regularCharge'] != null
          ? ChargeModel.fromMap(map['regularCharge'])
          : ChargeModel.init(),
      returnCharge: map['returnCharge'] != null
          ? ChargeModel.fromMap(map['returnCharge'])
          : ChargeModel.init(),
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(_id: $id, serialId: $serialId, address: $address, image: $image, pickupStyle: $pickupStyle, defaultPayment: $defaultPayment, paymentStyle: $paymentStyle, isDisabled: $isDisabled, role: $role, name: $name, email: $email, phone: $phone, bankAccount: $bankAccount, othersAccount: $othersAccount, myShops: $myShops, createdAt: $createdAt, updatedAt: $updatedAt, isApproved: $isApproved, hub: $hub, regularCharge: $regularCharge, returnCharge: $returnCharge, token: $token)';
  }

  @override
  List<Object> get props {
    return [
      id,
      serialId,
      address,
      image,
      pickupStyle,
      defaultPayment,
      paymentStyle,
      isDisabled,
      role,
      name,
      email,
      phone,
      bankAccount,
      othersAccount,
      myShops,
      createdAt,
      updatedAt,
      isApproved,
      hub,
      regularCharge,
      returnCharge,
      token,
    ];
  }
}
