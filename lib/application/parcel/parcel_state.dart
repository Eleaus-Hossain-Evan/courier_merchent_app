import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:courier_merchent_app/domain/parcel/model/parcel_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class ParcelState extends Equatable {
  final bool loading;
  final IList<ParcelModel> parcelList;
  const ParcelState({
    required this.loading,
    required this.parcelList,
  });

  factory ParcelState.init() =>
      const ParcelState(loading: false, parcelList: IListConst([]));

  ParcelState copyWith({
    bool? loading,
    IList<ParcelModel>? parcelList,
  }) {
    return ParcelState(
      loading: loading ?? this.loading,
      parcelList: parcelList ?? this.parcelList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loading': loading,
      'parcelList': parcelList.map((x) => x.toMap()).toList(),
    };
  }

  factory ParcelState.fromMap(Map<String, dynamic> map) {
    return ParcelState(
      loading: map['loading'] ?? false,
      parcelList: List<ParcelModel>.from(
              map['parcelList']?.map((x) => ParcelModel.fromMap(x)) ?? const [])
          .lock,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParcelState.fromJson(String source) =>
      ParcelState.fromMap(json.decode(source));

  @override
  String toString() =>
      'ParcelState(loading: $loading, parcelList: $parcelList)';

  @override
  List<Object> get props => [loading, parcelList];
}
