import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:courier_merchent_app/domain/parcel/model/parcel_model.dart';

class ParcelState extends Equatable {
  final bool loading;
  final IList<ParcelModel> allParcel;
  final IList<ParcelModel> pendingParcel;
  final IList<ParcelModel> pickupParcel;
  final IList<ParcelModel> shippingParcel;
  final IList<ParcelModel> shippedParcel;
  final IList<ParcelModel> dropoffParcel;
  final IList<ParcelModel> returnParcel;
  final IList<ParcelModel> cancelParcel;

  const ParcelState({
    required this.loading,
    required this.allParcel,
    required this.cancelParcel,
    required this.dropoffParcel,
    required this.pendingParcel,
    required this.pickupParcel,
    required this.returnParcel,
    required this.shippedParcel,
    required this.shippingParcel,
  });

  factory ParcelState.init() => const ParcelState(
        loading: false,
        allParcel: IListConst([]),
        cancelParcel: IListConst([]),
        dropoffParcel: IListConst([]),
        pendingParcel: IListConst([]),
        pickupParcel: IListConst([]),
        returnParcel: IListConst([]),
        shippedParcel: IListConst([]),
        shippingParcel: IListConst([]),
      );

  ParcelState copyWith({
    bool? loading,
    IList<ParcelModel>? allParcel,
    IList<ParcelModel>? pendingParcel,
    IList<ParcelModel>? pickupParcel,
    IList<ParcelModel>? shippingParcel,
    IList<ParcelModel>? shippedParcel,
    IList<ParcelModel>? dropoffParcel,
    IList<ParcelModel>? returnParcel,
    IList<ParcelModel>? cancelParcel,
  }) {
    return ParcelState(
      loading: loading ?? this.loading,
      allParcel: allParcel ?? this.allParcel,
      pendingParcel: pendingParcel ?? this.pendingParcel,
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
    return 'ParcelState(loading: $loading, allParcel: $allParcel, pendingParcel: $pendingParcel, pickupParcel: $pickupParcel, shippingParcel: $shippingParcel, shippedParcel: $shippedParcel, dropoffParcel: $dropoffParcel, returnParcel: $returnParcel, cancelParcel: $cancelParcel)';
  }

  @override
  List<Object> get props {
    return [
      loading,
      allParcel,
      pendingParcel,
      pickupParcel,
      shippingParcel,
      shippedParcel,
      dropoffParcel,
      returnParcel,
      cancelParcel,
    ];
  }
}
