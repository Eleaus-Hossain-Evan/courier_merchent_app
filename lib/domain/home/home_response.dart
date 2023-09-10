import 'dart:convert';

import 'package:equatable/equatable.dart';

class HomeResponse extends Equatable {
  final HomeData data;
  final String message;
  final bool success;
  const HomeResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  factory HomeResponse.init() =>
      HomeResponse(data: HomeData.init(), message: '', success: false);

  HomeResponse copyWith({
    HomeData? data,
    String? message,
    bool? success,
  }) {
    return HomeResponse(
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

  factory HomeResponse.fromMap(Map<String, dynamic> map) {
    return HomeResponse(
      data: HomeData.fromMap(map['data']),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeResponse.fromJson(String source) =>
      HomeResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'HomeResponse(data: $data, message: $message, success: $success)';

  @override
  List<Object> get props => [data, message, success];
}

class HomeData extends Equatable {
  final Home home;
  final String bulkExcel;
  final String id;
  final String createdAt;
  final String updatedAt;
  const HomeData({
    required this.home,
    required this.bulkExcel,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HomeData.init() => HomeData(
      home: Home.init(), bulkExcel: '', id: '', createdAt: '', updatedAt: '');

  HomeData copyWith({
    Home? home,
    String? bulkExcel,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
    return HomeData(
      home: home ?? this.home,
      bulkExcel: bulkExcel ?? this.bulkExcel,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'home': home.toMap(),
      'bulkExcel': bulkExcel,
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory HomeData.fromMap(Map<String, dynamic> map) {
    return HomeData(
      home: Home.fromMap(map['home']),
      bulkExcel: map['bulkExcel'] ?? '',
      id: map['_id'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeData.fromJson(String source) =>
      HomeData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(home: $home, bulkExcel: $bulkExcel, _id: $id, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      home,
      bulkExcel,
      id,
      createdAt,
      updatedAt,
    ];
  }
}

class Home extends Equatable {
  final List<TextBanner> textBanner;
  final List<ImageBanner> imageBanner;
  const Home({
    required this.textBanner,
    required this.imageBanner,
  });

  factory Home.init() => const Home(imageBanner: [], textBanner: []);

  Home copyWith({
    List<TextBanner>? textBanner,
    List<ImageBanner>? imageBanner,
  }) {
    return Home(
      textBanner: textBanner ?? this.textBanner,
      imageBanner: imageBanner ?? this.imageBanner,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'textBanner': textBanner.map((x) => x.toMap()).toList(),
      'imageBanner': imageBanner.map((x) => x.toMap()).toList(),
    };
  }

  factory Home.fromMap(Map<String, dynamic> map) {
    return Home(
      textBanner: List<TextBanner>.from(
          map['textBanner']?.map((x) => TextBanner.fromMap(x)) ?? const []),
      imageBanner: List<ImageBanner>.from(
          map['imageBanner']?.map((x) => ImageBanner.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Home.fromJson(String source) => Home.fromMap(json.decode(source));

  @override
  String toString() =>
      'Home(textBanner: $textBanner, imageBanner: $imageBanner)';

  @override
  List<Object> get props => [textBanner, imageBanner];
}

class TextBanner extends Equatable {
  final String description;
  final String link;
  final String id;
  const TextBanner({
    required this.description,
    required this.link,
    required this.id,
  });

  TextBanner copyWith({
    String? description,
    String? link,
    String? id,
  }) {
    return TextBanner(
      description: description ?? this.description,
      link: link ?? this.link,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'link': link,
      '_id': id,
    };
  }

  factory TextBanner.fromMap(Map<String, dynamic> map) {
    return TextBanner(
      description: map['description'] ?? '',
      link: map['link'] ?? '',
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TextBanner.fromJson(String source) =>
      TextBanner.fromMap(json.decode(source));

  @override
  String toString() =>
      'TextBanner(description: $description, link: $link, _id: $id)';

  @override
  List<Object> get props => [description, link, id];
}

class ImageBanner extends Equatable {
  final String image;
  final String link;
  final String id;
  const ImageBanner({
    required this.image,
    required this.link,
    required this.id,
  });

  ImageBanner copyWith({
    String? image,
    String? link,
    String? id,
  }) {
    return ImageBanner(
      image: image ?? this.image,
      link: link ?? this.link,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'link': link,
      '_id': id,
    };
  }

  factory ImageBanner.fromMap(Map<String, dynamic> map) {
    return ImageBanner(
      image: map['image'] ?? '',
      link: map['link'] ?? '',
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageBanner.fromJson(String source) =>
      ImageBanner.fromMap(json.decode(source));

  @override
  String toString() => 'ImageBanner(image: $image, link: $link, _id: $id)';

  @override
  List<Object> get props => [image, link, id];
}
