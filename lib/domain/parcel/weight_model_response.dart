import 'dart:convert';

import 'package:equatable/equatable.dart';

class WeightModelResponse extends Equatable {
  final List<WeightModel> data;
  final String message;
  final bool success;

  const WeightModelResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  WeightModelResponse copyWith({
    List<WeightModel>? data,
    String? message,
    bool? success,
  }) {
    return WeightModelResponse(
      data: data ?? this.data,
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
      'message': message,
      'success': success,
    };
  }

  factory WeightModelResponse.fromMap(Map<String, dynamic> map) {
    return WeightModelResponse(
      data: List<WeightModel>.from(
          map['data']?.map((x) => WeightModel.fromMap(x)) ?? const []),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeightModelResponse.fromJson(String source) =>
      WeightModelResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'WeghtModelResponse(data: $data, message: $message, success: $success)';

  @override
  List<Object> get props => [data, message, success];
}

class WeightModel extends Equatable {
  final String id;
  final String name;
  final double insidePrice;
  final double subSidePrice;
  final double outSidePrice;
  final String createdAt;
  final String updatedAt;

  const WeightModel({
    required this.id,
    required this.name,
    required this.insidePrice,
    required this.subSidePrice,
    required this.outSidePrice,
    required this.createdAt,
    required this.updatedAt,
  });

  WeightModel copyWith({
    String? id,
    String? name,
    double? insidePrice,
    double? subSidePrice,
    double? outSidePrice,
    String? createdAt,
    String? updatedAt,
  }) {
    return WeightModel(
      id: id ?? this.id,
      name: name ?? this.name,
      insidePrice: insidePrice ?? this.insidePrice,
      subSidePrice: subSidePrice ?? this.subSidePrice,
      outSidePrice: outSidePrice ?? this.outSidePrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'insidePrice': insidePrice,
      'subSidePrice': subSidePrice,
      'outSidePrice': outSidePrice,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory WeightModel.fromMap(Map<String, dynamic> map) {
    return WeightModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      insidePrice: map['insidePrice']?.toDouble() ?? 0,
      subSidePrice: map['subSidePrice']?.toDouble() ?? 0,
      outSidePrice: map['outSidePrice']?.toDouble() ?? 0,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WeightModel.fromJson(String source) =>
      WeightModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WeightModel(_id: $id, name: $name, insidePrice: $insidePrice, subSidePrice: $subSidePrice, outSidePrice: $outSidePrice, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      insidePrice,
      subSidePrice,
      outSidePrice,
      createdAt,
      updatedAt,
    ];
  }
}
