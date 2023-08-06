import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateParcelBody extends Equatable {
  final MerchantInfo merchantInfo;
  final CustomerInfo customerInfo;
  final RegularParcelInfo regularParcelInfo;
  final RegularPayment regularPayment;
  const CreateParcelBody({
    required this.merchantInfo,
    required this.customerInfo,
    required this.regularParcelInfo,
    required this.regularPayment,
  });

  CreateParcelBody copyWith({
    MerchantInfo? merchantInfo,
    CustomerInfo? customerInfo,
    RegularParcelInfo? regularParcelInfo,
    RegularPayment? regularPayment,
  }) {
    return CreateParcelBody(
      merchantInfo: merchantInfo ?? this.merchantInfo,
      customerInfo: customerInfo ?? this.customerInfo,
      regularParcelInfo: regularParcelInfo ?? this.regularParcelInfo,
      regularPayment: regularPayment ?? this.regularPayment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'merchantInfo': merchantInfo.toMap(),
      'customerInfo': customerInfo.toMap(),
      'regularParcelInfo': regularParcelInfo.toMap(),
      'regularPayment': regularPayment.toMap(),
    };
  }

  factory CreateParcelBody.fromMap(Map<String, dynamic> map) {
    return CreateParcelBody(
      merchantInfo: MerchantInfo.fromMap(map['merchantInfo']),
      customerInfo: CustomerInfo.fromMap(map['customerInfo']),
      regularParcelInfo: RegularParcelInfo.fromMap(map['regularParcelInfo']),
      regularPayment: RegularPayment.fromMap(map['regularPayment']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateParcelBody.fromJson(String source) =>
      CreateParcelBody.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateParcelBody(merchantInfo: $merchantInfo, customerInfo: $customerInfo, regularParcelInfo: $regularParcelInfo, regularPayment: $regularPayment)';
  }

  @override
  List<Object> get props =>
      [merchantInfo, customerInfo, regularParcelInfo, regularPayment];
}

class MerchantInfo extends Equatable {
  final String name;
  final String phone;
  final String address;
  final String shopName;
  final String shopAddress;
  const MerchantInfo({
    required this.name,
    required this.phone,
    required this.address,
    required this.shopName,
    required this.shopAddress,
  });

  MerchantInfo copyWith({
    String? name,
    String? phone,
    String? address,
    String? shopName,
    String? shopAddress,
  }) {
    return MerchantInfo(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      shopName: shopName ?? this.shopName,
      shopAddress: shopAddress ?? this.shopAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'shopName': shopName,
      'shopAddress': shopAddress,
    };
  }

  factory MerchantInfo.fromMap(Map<String, dynamic> map) {
    return MerchantInfo(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      shopName: map['shopName'] ?? '',
      shopAddress: map['shopAddress'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MerchantInfo.fromJson(String source) =>
      MerchantInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MerchantInfo(name: $name, phone: $phone, address: $address, shopName: $shopName, shopAddress: $shopAddress)';
  }

  @override
  List<Object> get props {
    return [
      name,
      phone,
      address,
      shopName,
      shopAddress,
    ];
  }
}

class CustomerInfo extends Equatable {
  final String name;
  final String phone;
  final String address;
  final String districtId;
  final String areaId;
  const CustomerInfo({
    required this.name,
    required this.phone,
    required this.address,
    required this.districtId,
    required this.areaId,
  });

  CustomerInfo copyWith({
    String? name,
    String? phone,
    String? address,
    String? districtId,
    String? areaId,
  }) {
    return CustomerInfo(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      districtId: districtId ?? this.districtId,
      areaId: areaId ?? this.areaId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'districtId': districtId,
      'areaId': areaId,
    };
  }

  factory CustomerInfo.fromMap(Map<String, dynamic> map) {
    return CustomerInfo(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      districtId: map['districtId'] ?? '',
      areaId: map['areaId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerInfo.fromJson(String source) =>
      CustomerInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerInfo(name: $name, phone: $phone, address: $address, districtId: $districtId, areaId: $areaId)';
  }

  @override
  List<Object> get props {
    return [
      name,
      phone,
      address,
      districtId,
      areaId,
    ];
  }
}

class RegularParcelInfo extends Equatable {
  final String invoiceId;
  final String weight;
  final int productPrice;
  final String materialType;
  final String category;
  final String details;
  const RegularParcelInfo({
    required this.invoiceId,
    required this.weight,
    required this.productPrice,
    required this.materialType,
    required this.category,
    required this.details,
  });

  RegularParcelInfo copyWith({
    String? invoiceId,
    String? weight,
    int? productPrice,
    String? materialType,
    String? category,
    String? details,
  }) {
    return RegularParcelInfo(
      invoiceId: invoiceId ?? this.invoiceId,
      weight: weight ?? this.weight,
      productPrice: productPrice ?? this.productPrice,
      materialType: materialType ?? this.materialType,
      category: category ?? this.category,
      details: details ?? this.details,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'invoiceId': invoiceId,
      'weight': weight,
      'productPrice': productPrice,
      'materialType': materialType,
      'category': category,
      'details': details,
    };
  }

  factory RegularParcelInfo.fromMap(Map<String, dynamic> map) {
    return RegularParcelInfo(
      invoiceId: map['invoiceId'] ?? '',
      weight: map['weight'] ?? '',
      productPrice: map['productPrice']?.toInt() ?? 0,
      materialType: map['materialType'] ?? '',
      category: map['category'] ?? '',
      details: map['details'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegularParcelInfo.fromJson(String source) =>
      RegularParcelInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegularParcelInfo(invoiceId: $invoiceId, weight: $weight, productPrice: $productPrice, materialType: $materialType, category: $category, details: $details)';
  }

  @override
  List<Object> get props {
    return [
      invoiceId,
      weight,
      productPrice,
      materialType,
      category,
      details,
    ];
  }
}

class RegularPayment extends Equatable {
  final int cashCollection;
  final int deliveryCharge;
  final int codCharge;
  final int weightCharge;
  final int totalCharge;
  const RegularPayment({
    required this.cashCollection,
    required this.deliveryCharge,
    required this.codCharge,
    required this.weightCharge,
    required this.totalCharge,
  });

  RegularPayment copyWith({
    int? cashCollection,
    int? deliveryCharge,
    int? codCharge,
    int? weightCharge,
    int? totalCharge,
  }) {
    return RegularPayment(
      cashCollection: cashCollection ?? this.cashCollection,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      codCharge: codCharge ?? this.codCharge,
      weightCharge: weightCharge ?? this.weightCharge,
      totalCharge: totalCharge ?? this.totalCharge,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cashCollection': cashCollection,
      'deliveryCharge': deliveryCharge,
      'codCharge': codCharge,
      'weightCharge': weightCharge,
      'totalCharge': totalCharge,
    };
  }

  factory RegularPayment.fromMap(Map<String, dynamic> map) {
    return RegularPayment(
      cashCollection: map['cashCollection']?.toInt() ?? 0,
      deliveryCharge: map['deliveryCharge']?.toInt() ?? 0,
      codCharge: map['codCharge']?.toInt() ?? 0,
      weightCharge: map['weightCharge']?.toInt() ?? 0,
      totalCharge: map['totalCharge']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegularPayment.fromJson(String source) =>
      RegularPayment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegularPayment(cashCollection: $cashCollection, deliveryCharge: $deliveryCharge, codCharge: $codCharge, weightCharge: $weightCharge, totalCharge: $totalCharge)';
  }

  @override
  List<Object> get props {
    return [
      cashCollection,
      deliveryCharge,
      codCharge,
      weightCharge,
      totalCharge,
    ];
  }
}
