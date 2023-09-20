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
    return switch (this) {
      ParcelRegularStatus.all => "all",
      ParcelRegularStatus.pending => "pending",
      ParcelRegularStatus.hold => "hold",
      ParcelRegularStatus.pickup => "pickup",
      ParcelRegularStatus.shipping => "shipping",
      ParcelRegularStatus.shipped => "shipped",
      ParcelRegularStatus.dropoff => "dropoff",
      // case ParcelRegularStatus.partial:
      //   return "partial";
      ParcelRegularStatus.returns => "return",
      ParcelRegularStatus.cancel => "cancel",
      ParcelRegularStatus.returnEnd => "return_end",
      // ignore: unreachable_switch_case
      _ => "",
    };
  }
}
