import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:courier_merchent_app/domain/auth/model/bank_account_model.dart';
import 'package:courier_merchent_app/domain/auth/model/charge_model.dart';
import 'package:courier_merchent_app/domain/auth/model/hub_model.dart';
import 'package:courier_merchent_app/domain/auth/model/other_account_model.dart';
import 'package:courier_merchent_app/domain/auth/model/shop_model.dart';

class UserModel extends Equatable {
  final ChargeModel regularCharge;
  final ChargeModel returnCharge;
  final BankAccountModel bankAccount;
  final OthersAccountModel othersAccount;
  final BankAccountModel pendingBankAccount;
  final OthersAccountModel pendingOthersAccount;
  final String serialId;
  final String address;
  final String image;
  final List<MyShopModel> myShops;
  final HubModel hub;
  final String pickupStyle;
  final String defaultPayment;
  final String paymentStyle;
  final ChargeModel codCharge;
  final bool isPaymentUpdatePending;
  final bool isPaymentUpdate;
  final bool isApproved;
  final bool isDisabled;
  final String createdBy;
  final String role;
  final String id;
  final String name;
  final String email;
  final String phone;
  final String createdAt;
  final String updatedAt;
  final String token;

  const UserModel({
    required this.regularCharge,
    required this.returnCharge,
    required this.bankAccount,
    required this.othersAccount,
    required this.pendingBankAccount,
    required this.pendingOthersAccount,
    required this.serialId,
    required this.address,
    required this.image,
    required this.myShops,
    required this.hub,
    required this.pickupStyle,
    required this.defaultPayment,
    required this.paymentStyle,
    required this.codCharge,
    required this.isPaymentUpdatePending,
    required this.isPaymentUpdate,
    required this.isApproved,
    required this.isDisabled,
    required this.createdBy,
    required this.role,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
  });

  factory UserModel.init() => UserModel(
      regularCharge: ChargeModel.init(),
      returnCharge: ChargeModel.init(),
      bankAccount: BankAccountModel.init(),
      othersAccount: OthersAccountModel.init(),
      pendingBankAccount: BankAccountModel.init(),
      pendingOthersAccount: OthersAccountModel.init(),
      serialId: '',
      address: '',
      image: '',
      myShops: const [],
      hub: HubModel.init(),
      pickupStyle: '',
      defaultPayment: '',
      paymentStyle: '',
      codCharge: ChargeModel.init(),
      isPaymentUpdatePending: false,
      isPaymentUpdate: false,
      isApproved: false,
      isDisabled: false,
      createdBy: '',
      role: '',
      id: '',
      name: '',
      email: '',
      phone: '',
      createdAt: '',
      updatedAt: '',
      token: '');

  UserModel copyWith({
    ChargeModel? regularCharge,
    ChargeModel? returnCharge,
    BankAccountModel? bankAccount,
    OthersAccountModel? othersAccount,
    BankAccountModel? pendingBankAccount,
    OthersAccountModel? pendingOthersAccount,
    String? serialId,
    String? address,
    String? image,
    List<MyShopModel>? myShops,
    HubModel? hub,
    String? pickupStyle,
    String? defaultPayment,
    String? paymentStyle,
    ChargeModel? codCharge,
    bool? isPaymentUpdatePending,
    bool? isPaymentUpdate,
    bool? isApproved,
    bool? isDisabled,
    String? createdBy,
    String? role,
    String? id,
    String? name,
    String? email,
    String? phone,
    String? createdAt,
    String? updatedAt,
    String? token,
  }) {
    return UserModel(
      regularCharge: regularCharge ?? this.regularCharge,
      returnCharge: returnCharge ?? this.returnCharge,
      bankAccount: bankAccount ?? this.bankAccount,
      othersAccount: othersAccount ?? this.othersAccount,
      pendingBankAccount: pendingBankAccount ?? this.pendingBankAccount,
      pendingOthersAccount: pendingOthersAccount ?? this.pendingOthersAccount,
      serialId: serialId ?? this.serialId,
      address: address ?? this.address,
      image: image ?? this.image,
      myShops: myShops ?? this.myShops,
      hub: hub ?? this.hub,
      pickupStyle: pickupStyle ?? this.pickupStyle,
      defaultPayment: defaultPayment ?? this.defaultPayment,
      paymentStyle: paymentStyle ?? this.paymentStyle,
      codCharge: codCharge ?? this.codCharge,
      isPaymentUpdatePending:
          isPaymentUpdatePending ?? this.isPaymentUpdatePending,
      isPaymentUpdate: isPaymentUpdate ?? this.isPaymentUpdate,
      isApproved: isApproved ?? this.isApproved,
      isDisabled: isDisabled ?? this.isDisabled,
      createdBy: createdBy ?? this.createdBy,
      role: role ?? this.role,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'regularCharge': regularCharge.toMap(),
      'returnCharge': returnCharge.toMap(),
      'bankAccount': bankAccount.toMap(),
      'othersAccount': othersAccount.toMap(),
      'pendingBankAccount': pendingBankAccount.toMap(),
      'pendingOthersAccount': pendingOthersAccount.toMap(),
      'serialId': serialId,
      'address': address,
      'image': image,
      'myShops': myShops.map((x) => x.toMap()).toList(),
      'hub': hub.toMap(),
      'pickupStyle': pickupStyle,
      'defaultPayment': defaultPayment,
      'paymentStyle': paymentStyle,
      'codCharge': codCharge.toMap(),
      'isPaymentUpdatePending': isPaymentUpdatePending,
      'isPaymentUpdate': isPaymentUpdate,
      'isApproved': isApproved,
      'isDisabled': isDisabled,
      'createdBy': createdBy,
      'role': role,
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      regularCharge: map['regularCharge'] != null
          ? ChargeModel.fromMap(map['regularCharge'])
          : ChargeModel.init(),
      returnCharge: map['returnCharge'] != null
          ? ChargeModel.fromMap(map['returnCharge'])
          : ChargeModel.init(),
      bankAccount: map['bankAccount'] != null
          ? BankAccountModel.fromMap(map['bankAccount'])
          : BankAccountModel.init(),
      othersAccount: map['othersAccount'] != null
          ? OthersAccountModel.fromMap(map['othersAccount'])
          : OthersAccountModel.init(),
      pendingBankAccount: map['pendingBankAccount'] != null
          ? BankAccountModel.fromMap(map['pendingBankAccount'])
          : BankAccountModel.init(),
      pendingOthersAccount: map['pendingOthersAccount'] != null
          ? OthersAccountModel.fromMap(map['pendingOthersAccount'])
          : OthersAccountModel.init(),
      serialId: map['serialId'] ?? '',
      address: map['address'] ?? '',
      image: map['image'] ?? '',
      myShops: map['myShops'] is List<Map<String, dynamic>>
          ? List<MyShopModel>.from(
              map['myShops']?.map((x) => MyShopModel.fromMap(x)) ?? const [])
          : [],
      hub: map['hub'] != null ? HubModel.fromMap(map['hub']) : HubModel.init(),
      pickupStyle: map['pickupStyle'] ?? '',
      defaultPayment: map['defaultPayment'] ?? '',
      paymentStyle: map['paymentStyle'] ?? '',
      codCharge: map['codCharge'] != null
          ? ChargeModel.fromMap(map['codCharge'])
          : ChargeModel.init(),
      isPaymentUpdatePending: map['isPaymentUpdatePending'] ?? false,
      isPaymentUpdate: map['isPaymentUpdate'] ?? false,
      isApproved: map['isApproved'] ?? false,
      isDisabled: map['isDisabled'] ?? false,
      createdBy: map['createdBy'] ?? '',
      role: map['role'] ?? '',
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(regularCharge: $regularCharge, returnCharge: $returnCharge, bankAccount: $bankAccount, othersAccount: $othersAccount, pendingBankAccount: $pendingBankAccount, pendingOthersAccount: $pendingOthersAccount, serialId: $serialId, address: $address, image: $image, myShops: $myShops, hub: $hub,pickupStyle: $pickupStyle, defaultPayment: $defaultPayment, paymentStyle: $paymentStyle, codCharge: $codCharge, isPaymentUpdatePending: $isPaymentUpdatePending, isPaymentUpdate: $isPaymentUpdate, isApproved: $isApproved, isDisabled: $isDisabled, createdBy: $createdBy, role: $role, id: $id, name: $name, email: $email, phone: $phone, createdAt: $createdAt, updatedAt: $updatedAt, token: $token)';
  }

  @override
  List<Object> get props {
    return [
      regularCharge,
      returnCharge,
      bankAccount,
      othersAccount,
      pendingBankAccount,
      pendingOthersAccount,
      serialId,
      address,
      image,
      myShops,
      hub,
      pickupStyle,
      defaultPayment,
      paymentStyle,
      codCharge,
      isPaymentUpdatePending,
      isPaymentUpdate,
      isApproved,
      isDisabled,
      createdBy,
      role,
      id,
      name,
      email,
      phone,
      createdAt,
      updatedAt,
      token,
    ];
  }
}
