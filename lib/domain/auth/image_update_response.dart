import 'dart:convert';

import 'package:equatable/equatable.dart';

class ImageUpdateResponse extends Equatable {
  final ImageUpdateData data;
  final bool success;
  final String message;

  const ImageUpdateResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  ImageUpdateResponse copyWith({
    ImageUpdateData? data,
    bool? success,
    String? message,
  }) {
    return ImageUpdateResponse(
      data: data ?? this.data,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
      'success': success,
      'message': message,
    };
  }

  factory ImageUpdateResponse.fromMap(Map<String, dynamic> map) {
    return ImageUpdateResponse(
      data: ImageUpdateData.fromMap(map['data']),
      success: map['success'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageUpdateResponse.fromJson(String source) =>
      ImageUpdateResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'ImageUpdateResponse(data: $data, success: $success, message: $message)';

  @override
  List<Object> get props => [data, success, message];
}

class ImageUpdateData extends Equatable {
  final String image;
  final String id;
  final String updatedAt;

  const ImageUpdateData({
    required this.image,
    required this.id,
    required this.updatedAt,
  });

  ImageUpdateData copyWith({
    String? image,
    String? id,
    String? updatedAt,
  }) {
    return ImageUpdateData(
      image: image ?? this.image,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      '_id': id,
      'updatedAt': updatedAt,
    };
  }

  factory ImageUpdateData.fromMap(Map<String, dynamic> map) {
    return ImageUpdateData(
      image: map['image'] ?? '',
      id: map['_id'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageUpdateData.fromJson(String source) =>
      ImageUpdateData.fromMap(json.decode(source));

  @override
  String toString() =>
      'ImageUpdateData(image: $image, _id: $id, updatedAt: $updatedAt)';

  @override
  List<Object> get props => [image, id, updatedAt];
}
