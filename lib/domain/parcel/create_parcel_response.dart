import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'model/regular_charge_model.dart';

class CreateParcelResponse extends Equatable {
  final CreateParcelModel data;
  final String message;
  final bool success;

  const CreateParcelResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  CreateParcelResponse copyWith({
    CreateParcelModel? data,
    String? message,
    bool? success,
  }) {
    return CreateParcelResponse(
      data: data ?? this.data,
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
      'message': message,
      'success': success,
    };
  }

  factory CreateParcelResponse.fromMap(Map<String, dynamic> map) {
    return CreateParcelResponse(
      data: CreateParcelModel.fromMap(map['data']),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateParcelResponse.fromJson(String source) =>
      CreateParcelResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'CreateParcelResponse(data: $data, message: $message, success: $success)';

  @override
  List<Object> get props => [data, message, success];
}

class CreateParcelModel extends Equatable {
  final MerchantInfo merchantInfo;
  final RegularParcelInfo regularParcelInfo;
  final ExchangeParcelInfo exchangeParcelInfo;
  final RegularPaymentModel regularPayment;
  final RegularPaymentModel exchangePayment;
  final String createdBy;
  final String merchantId;
  final String parcelType;
  final List<dynamic> hubHistory;
  final String pickupStatus;
  final bool isTransferMode;
  final String regularStatus;
  final String exchangeStatus;
  final int merchantUpdate;
  final String id;
  final CustomerInfo customerInfo;
  final String sourceHubId;
  final String currentHubId;
  final String destinationHubId;
  final List<StatusLog> regularStatusLogs;
  final List<StatusLog> adminLogs;
  final String serialId;
  final String qrCode;
  final List<dynamic> exchangeStatusLogs;
  final String createdAt;
  final String updatedAt;

  const CreateParcelModel({
    required this.merchantInfo,
    required this.regularParcelInfo,
    required this.exchangeParcelInfo,
    required this.regularPayment,
    required this.exchangePayment,
    required this.createdBy,
    required this.merchantId,
    required this.parcelType,
    required this.hubHistory,
    required this.pickupStatus,
    required this.isTransferMode,
    required this.regularStatus,
    required this.exchangeStatus,
    required this.merchantUpdate,
    required this.id,
    required this.customerInfo,
    required this.sourceHubId,
    required this.currentHubId,
    required this.destinationHubId,
    required this.regularStatusLogs,
    required this.adminLogs,
    required this.serialId,
    required this.qrCode,
    required this.exchangeStatusLogs,
    required this.createdAt,
    required this.updatedAt,
  });

  CreateParcelModel copyWith({
    MerchantInfo? merchantInfo,
    RegularParcelInfo? regularParcelInfo,
    ExchangeParcelInfo? exchangeParcelInfo,
    RegularPaymentModel? regularPayment,
    RegularPaymentModel? exchangePayment,
    String? createdBy,
    String? merchantId,
    String? parcelType,
    List<dynamic>? hubHistory,
    String? pickupStatus,
    bool? isTransferMode,
    String? regularStatus,
    String? exchangeStatus,
    int? merchantUpdate,
    String? id,
    CustomerInfo? customerInfo,
    String? sourceHubId,
    String? currentHubId,
    String? destinationHubId,
    List<StatusLog>? regularStatusLogs,
    List<StatusLog>? adminLogs,
    String? serialId,
    String? qrCode,
    List<dynamic>? exchangeStatusLogs,
    String? createdAt,
    String? updatedAt,
  }) {
    return CreateParcelModel(
      merchantInfo: merchantInfo ?? this.merchantInfo,
      regularParcelInfo: regularParcelInfo ?? this.regularParcelInfo,
      exchangeParcelInfo: exchangeParcelInfo ?? this.exchangeParcelInfo,
      regularPayment: regularPayment ?? this.regularPayment,
      exchangePayment: exchangePayment ?? this.exchangePayment,
      createdBy: createdBy ?? this.createdBy,
      merchantId: merchantId ?? this.merchantId,
      parcelType: parcelType ?? this.parcelType,
      hubHistory: hubHistory ?? this.hubHistory,
      pickupStatus: pickupStatus ?? this.pickupStatus,
      isTransferMode: isTransferMode ?? this.isTransferMode,
      regularStatus: regularStatus ?? this.regularStatus,
      exchangeStatus: exchangeStatus ?? this.exchangeStatus,
      merchantUpdate: merchantUpdate ?? this.merchantUpdate,
      id: id ?? this.id,
      customerInfo: customerInfo ?? this.customerInfo,
      sourceHubId: sourceHubId ?? this.sourceHubId,
      currentHubId: currentHubId ?? this.currentHubId,
      destinationHubId: destinationHubId ?? this.destinationHubId,
      regularStatusLogs: regularStatusLogs ?? this.regularStatusLogs,
      adminLogs: adminLogs ?? this.adminLogs,
      serialId: serialId ?? this.serialId,
      qrCode: qrCode ?? this.qrCode,
      exchangeStatusLogs: exchangeStatusLogs ?? this.exchangeStatusLogs,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'merchantInfo': merchantInfo.toMap(),
      'regularParcelInfo': regularParcelInfo.toMap(),
      'exchangeParcelInfo': exchangeParcelInfo.toMap(),
      'regularPayment': regularPayment.toMap(),
      'exchangePayment': exchangePayment.toMap(),
      'createdBy': createdBy,
      'merchantId': merchantId,
      'parcelType': parcelType,
      'hubHistory': hubHistory,
      'pickupStatus': pickupStatus,
      'isTransferMode': isTransferMode,
      'regularStatus': regularStatus,
      'exchangeStatus': exchangeStatus,
      'merchantUpdate': merchantUpdate,
      '_id': id,
      'customerInfo': customerInfo.toMap(),
      'sourceHubId': sourceHubId,
      'currentHubId': currentHubId,
      'destinationHubId': destinationHubId,
      'regularStatusLogs': regularStatusLogs.map((x) => x.toMap()).toList(),
      'adminLogs': adminLogs.map((x) => x.toMap()).toList(),
      'serialId': serialId,
      'qrCode': qrCode,
      'exchangeStatusLogs': exchangeStatusLogs,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory CreateParcelModel.fromMap(Map<String, dynamic> map) {
    return CreateParcelModel(
      merchantInfo: MerchantInfo.fromMap(map['merchantInfo']),
      regularParcelInfo: RegularParcelInfo.fromMap(map['regularParcelInfo']),
      exchangeParcelInfo: ExchangeParcelInfo.fromMap(map['exchangeParcelInfo']),
      regularPayment: RegularPaymentModel.fromMap(map['regularPayment']),
      exchangePayment: RegularPaymentModel.fromMap(map['exchangePayment']),
      createdBy: map['createdBy'] ?? '',
      merchantId: map['merchantId'] ?? '',
      parcelType: map['parcelType'] ?? '',
      hubHistory: List<dynamic>.from(map['hubHistory'] ?? const []),
      pickupStatus: map['pickupStatus'] ?? '',
      isTransferMode: map['isTransferMode'] ?? false,
      regularStatus: map['regularStatus'] ?? '',
      exchangeStatus: map['exchangeStatus'] ?? '',
      merchantUpdate: map['merchantUpdate']?.toInt() ?? 0,
      id: map['_id'] ?? '',
      customerInfo: CustomerInfo.fromMap(map['customerInfo']),
      sourceHubId: map['sourceHubId'] ?? '',
      currentHubId: map['currentHubId'] ?? '',
      destinationHubId: map['destinationHubId'] ?? '',
      regularStatusLogs: List<StatusLog>.from(
          map['regularStatusLogs']?.map((x) => StatusLog.fromMap(x)) ??
              const []),
      adminLogs: List<StatusLog>.from(
          map['adminLogs']?.map((x) => StatusLog.fromMap(x)) ?? const []),
      serialId: map['serialId'] ?? '',
      qrCode: map['qrCode'] ?? '',
      exchangeStatusLogs: List<StatusLog>.from(
          map['exchangeStatusLogs']?.map((x) => StatusLog.fromMap(x)) ??
              const []),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateParcelModel.fromJson(String source) =>
      CreateParcelModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(merchantInfo: $merchantInfo, regularParcelInfo: $regularParcelInfo, exchangeParcelInfo: $exchangeParcelInfo, regularPayment: $regularPayment, exchangePayment: $exchangePayment, createdBy: $createdBy, merchantId: $merchantId, parcelType: $parcelType, hubHistory: $hubHistory, pickupStatus: $pickupStatus, isTransferMode: $isTransferMode, regularStatus: $regularStatus, exchangeStatus: $exchangeStatus, merchantUpdate: $merchantUpdate, _id: $id, customerInfo: $customerInfo, sourceHubId: $sourceHubId, currentHubId: $currentHubId, destinationHubId: $destinationHubId, regularStatusLogs: $regularStatusLogs, adminLogs: $adminLogs, serialId: $serialId, qrCode: $qrCode, exchangeStatusLogs: $exchangeStatusLogs, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      merchantInfo,
      regularParcelInfo,
      exchangeParcelInfo,
      regularPayment,
      exchangePayment,
      createdBy,
      merchantId,
      parcelType,
      hubHistory,
      pickupStatus,
      isTransferMode,
      regularStatus,
      exchangeStatus,
      merchantUpdate,
      id,
      customerInfo,
      sourceHubId,
      currentHubId,
      destinationHubId,
      regularStatusLogs,
      adminLogs,
      serialId,
      qrCode,
      exchangeStatusLogs,
      createdAt,
      updatedAt,
    ];
  }
}

class MerchantInfo extends Equatable {
  final String address;
  final String shopAddress;
  final String name;
  final String phone;
  final String shopName;
  const MerchantInfo({
    required this.address,
    required this.shopAddress,
    required this.name,
    required this.phone,
    required this.shopName,
  });

  MerchantInfo copyWith({
    String? address,
    String? shopAddress,
    String? name,
    String? phone,
    String? shopName,
  }) {
    return MerchantInfo(
      address: address ?? this.address,
      shopAddress: shopAddress ?? this.shopAddress,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      shopName: shopName ?? this.shopName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'shopAddress': shopAddress,
      'name': name,
      'phone': phone,
      'shopName': shopName,
    };
  }

  factory MerchantInfo.fromMap(Map<String, dynamic> map) {
    return MerchantInfo(
      address: map['address'] ?? '',
      shopAddress: map['shopAddress'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      shopName: map['shopName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MerchantInfo.fromJson(String source) =>
      MerchantInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MerchantInfo(address: $address, shopAddress: $shopAddress, name: $name, phone: $phone, shopName: $shopName)';
  }

  @override
  List<Object> get props {
    return [
      address,
      shopAddress,
      name,
      phone,
      shopName,
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

class ExchangeParcelInfo extends Equatable {
  final String invoiceId;
  final String weight;
  final int productPrice;
  final String materialType;
  final String category;
  final String details;
  const ExchangeParcelInfo({
    required this.invoiceId,
    required this.weight,
    required this.productPrice,
    required this.materialType,
    required this.category,
    required this.details,
  });

  ExchangeParcelInfo copyWith({
    String? invoiceId,
    String? weight,
    int? productPrice,
    String? materialType,
    String? category,
    String? details,
  }) {
    return ExchangeParcelInfo(
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

  factory ExchangeParcelInfo.fromMap(Map<String, dynamic> map) {
    return ExchangeParcelInfo(
      invoiceId: map['invoiceId'] ?? '',
      weight: map['weight'] ?? '',
      productPrice: map['productPrice']?.toInt() ?? 0,
      materialType: map['materialType'] ?? '',
      category: map['category'] ?? '',
      details: map['details'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ExchangeParcelInfo.fromJson(String source) =>
      ExchangeParcelInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExchangeParcelInfo(invoiceId: $invoiceId, weight: $weight, productPrice: $productPrice, materialType: $materialType, category: $category, details: $details)';
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

class StatusLog extends Equatable {
  final String time;
  final String id;
  final String log;
  const StatusLog({
    required this.time,
    required this.id,
    required this.log,
  });

  StatusLog copyWith({
    String? time,
    String? id,
    String? log,
  }) {
    return StatusLog(
      time: time ?? this.time,
      id: id ?? this.id,
      log: log ?? this.log,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      '_id': id,
      'log': log,
    };
  }

  factory StatusLog.fromMap(Map<String, dynamic> map) {
    return StatusLog(
      time: map['time'] ?? '',
      id: map['_id'] ?? '',
      log: map['log'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusLog.fromJson(String source) =>
      StatusLog.fromMap(json.decode(source));

  @override
  String toString() => 'RegularStatusLog(time: $time, _id: $id, log: $log)';

  @override
  List<Object> get props => [time, id, log];
}
