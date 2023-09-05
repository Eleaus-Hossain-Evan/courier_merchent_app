part of 'extensions.dart';

extension ParcelMaterialTypeExt on ParcelMaterialType {
  String get value {
    switch (this) {
      case ParcelMaterialType.regular:
        return "regular";
      case ParcelMaterialType.fragile:
        return "fragile";
      case ParcelMaterialType.liquid:
        return "liquid";
      case ParcelMaterialType.none:
        return "";
    }
  }
}

extension ParcelListTypeExt on ParcelRegularStatus {
  String get value {
    switch (this) {
      case ParcelRegularStatus.all:
        return "all";
      case ParcelRegularStatus.pending:
        return "pending";
      case ParcelRegularStatus.pickup:
        return "pickup";
      case ParcelRegularStatus.shipping:
        return "shipping";
      case ParcelRegularStatus.shipped:
        return "shipped";
      case ParcelRegularStatus.dropoff:
        return "dropoff";
      // case ParcelRegularStatus.partial:
      //   return "partial";
      case ParcelRegularStatus.returns:
        return "return";
      case ParcelRegularStatus.cancel:
        return "cancel";
    }
  }
}
