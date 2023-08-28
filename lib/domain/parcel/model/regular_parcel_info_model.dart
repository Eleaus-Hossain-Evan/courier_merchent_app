import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:courier_merchent_app/utils/utils.dart';

class RegularParcelInfoModel extends Equatable {
  final String invoiceId;
  final String weight;
  final int productPrice;
  final ParcelMaterialType materialType;
  final String category;
  final String details;
  final String instruction;

  const RegularParcelInfoModel({
    required this.invoiceId,
    required this.weight,
    required this.productPrice,
    required this.materialType,
    required this.category,
    required this.details,
    required this.instruction,
  });

  factory RegularParcelInfoModel.init() => const RegularParcelInfoModel(
        invoiceId: '',
        weight: '',
        productPrice: 0,
        materialType: ParcelMaterialType.regular,
        category: '',
        details: '',
        instruction: '',
      );

  RegularParcelInfoModel copyWith({
    String? invoiceId,
    String? weight,
    int? productPrice,
    ParcelMaterialType? materialType,
    String? category,
    String? details,
    String? instruction,
  }) {
    return RegularParcelInfoModel(
      invoiceId: invoiceId ?? this.invoiceId,
      weight: weight ?? this.weight,
      productPrice: productPrice ?? this.productPrice,
      materialType: materialType ?? this.materialType,
      category: category ?? this.category,
      details: details ?? this.details,
      instruction: instruction ?? this.instruction,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'invoiceId': invoiceId,
      'weight': weight,
      'productPrice': productPrice,
      'materialType': materialType.value,
      'category': category,
      'details': details,
      'instruction': instruction,
    };
  }

  factory RegularParcelInfoModel.fromMap(Map<String, dynamic> map) {
    return RegularParcelInfoModel(
      invoiceId: map['invoiceId'] ?? '',
      weight: map['weight'] ?? '',
      productPrice: map['productPrice']?.toInt() ?? 0,
      materialType: ParcelMaterialType.values .firstWhere((e) => e.value ==map['materialType']),
      category: map['category'] ?? '',
      details: map['details'] ?? '',
      instruction: map['instruction'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegularParcelInfoModel.fromJson(String source) =>
      RegularParcelInfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegularParcelInfoModel(invoiceId: $invoiceId, weight: $weight, productPrice: $productPrice, materialType: $materialType, category: $category, details: $details, instruction: $instruction)';
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
      instruction,
    ];
  }
}
