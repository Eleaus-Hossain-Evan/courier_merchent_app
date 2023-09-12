import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:courier_merchent_app/domain/meta_data_model.dart';
import 'package:courier_merchent_app/domain/parcel/model/parcel_model.dart';

class ParcelState extends Equatable {
  final bool loading;
  final MetaDataModel metaData;
  final IList<ParcelModel> allParcel;
  final IList<ParcelModel> pendingParcel;
  final IList<ParcelModel> holdParcel;
  final IList<ParcelModel> pickupParcel;
  final IList<ParcelModel> shippingParcel;
  final IList<ParcelModel> shippedParcel;
  final IList<ParcelModel> dropoffParcel;
  final IList<ParcelModel> returnParcel;
  final IList<ParcelModel> cancelParcel;

  const ParcelState({
    required this.loading,
    required this.metaData,
    required this.allParcel,
    required this.pendingParcel,
    required this.holdParcel,
    required this.pickupParcel,
    required this.shippingParcel,
    required this.shippedParcel,
    required this.dropoffParcel,
    required this.returnParcel,
    required this.cancelParcel,
  });

  factory ParcelState.init() => ParcelState(
        loading: false,
        metaData: MetaDataModel.init(),
        allParcel: const IListConst([]),
        holdParcel: const IListConst([]),
        cancelParcel: const IListConst([]),
        dropoffParcel: const IListConst([]),
        pendingParcel: const IListConst([]),
        pickupParcel: const IListConst([]),
        returnParcel: const IListConst([]),
        shippedParcel: const IListConst([]),
        shippingParcel: const IListConst([]),
      );

  ParcelState copyWith({
    bool? loading,
    MetaDataModel? metaData,
    IList<ParcelModel>? allParcel,
    IList<ParcelModel>? pendingParcel,
    IList<ParcelModel>? holdParcel,
    IList<ParcelModel>? pickupParcel,
    IList<ParcelModel>? shippingParcel,
    IList<ParcelModel>? shippedParcel,
    IList<ParcelModel>? dropoffParcel,
    IList<ParcelModel>? returnParcel,
    IList<ParcelModel>? cancelParcel,
  }) {
    return ParcelState(
      loading: loading ?? this.loading,
      metaData: metaData ?? this.metaData,
      allParcel: allParcel ?? this.allParcel,
      pendingParcel: pendingParcel ?? this.pendingParcel,
      holdParcel: holdParcel ?? this.holdParcel,
      pickupParcel: pickupParcel ?? this.pickupParcel,
      shippingParcel: shippingParcel ?? this.shippingParcel,
      shippedParcel: shippedParcel ?? this.shippedParcel,
      dropoffParcel: dropoffParcel ?? this.dropoffParcel,
      returnParcel: returnParcel ?? this.returnParcel,
      cancelParcel: cancelParcel ?? this.cancelParcel,
    );
  }

  @override
  String toString() {
    return 'ParcelState(loading: $loading, metaData: $metaData, allParcel: $allParcel, pendingParcel: $pendingParcel, holdParcel: $holdParcel, pickupParcel: $pickupParcel, shippingParcel: $shippingParcel, shippedParcel: $shippedParcel, dropoffParcel: $dropoffParcel, returnParcel: $returnParcel, cancelParcel: $cancelParcel)';
  }

  @override
  List<Object> get props {
    return [
      loading,
      metaData,
      allParcel,
      pendingParcel,
      holdParcel,
      pickupParcel,
      shippingParcel,
      shippedParcel,
      dropoffParcel,
      returnParcel,
      cancelParcel,
    ];
  }
}
