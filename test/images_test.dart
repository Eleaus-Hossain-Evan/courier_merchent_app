import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:courier_merchent_app/utils/assets/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.bkashLogo).existsSync(), isTrue);
    expect(File(Images.boxs).existsSync(), isTrue);
    expect(File(Images.bulkParcel3d).existsSync(), isTrue);
    expect(File(Images.bulkParcel).existsSync(), isTrue);
    expect(File(Images.deliveryBoxCheck).existsSync(), isTrue);
    expect(File(Images.deliveryBoxIcon).existsSync(), isTrue);
    expect(File(Images.deliveryBoxList).existsSync(), isTrue);
    expect(File(Images.deliveryBoxLoading).existsSync(), isTrue);
    expect(File(Images.deliveryBoxes3d).existsSync(), isTrue);
    expect(File(Images.homeBanner2).existsSync(), isTrue);
    expect(File(Images.homeBanner3).existsSync(), isTrue);
    expect(File(Images.homeBanner4).existsSync(), isTrue);
    expect(File(Images.homeBanner).existsSync(), isTrue);
    expect(File(Images.logo).existsSync(), isTrue);
    expect(File(Images.nagadLogo).existsSync(), isTrue);
    expect(File(Images.parcelSearch).existsSync(), isTrue);
    expect(File(Images.singleParcel3d).existsSync(), isTrue);
    expect(File(Images.singleParcel).existsSync(), isTrue);
    expect(File(Images.truck).existsSync(), isTrue);
    expect(File(Images.iconCallDropped).existsSync(), isTrue);
    expect(File(Images.iconObjectScan).existsSync(), isTrue);
    expect(File(Images.iconDelivery).existsSync(), isTrue);
    expect(File(Images.iconFacebook).existsSync(), isTrue);
    expect(File(Images.iconGoogle).existsSync(), isTrue);
    expect(File(Images.iconParcelCancel).existsSync(), isTrue);
    expect(File(Images.iconParcelCredit).existsSync(), isTrue);
    expect(File(Images.iconParcelDeliveryFeesPaid).existsSync(), isTrue);
    expect(File(Images.iconParcelDropoff).existsSync(), isTrue);
    expect(File(Images.iconParcelPending).existsSync(), isTrue);
    expect(File(Images.iconParcelReturnEnd).existsSync(), isTrue);
    expect(File(Images.iconParcelShipping).existsSync(), isTrue);
    expect(File(Images.iconParcelTotal).existsSync(), isTrue);
    expect(File(Images.iconPayCollection).existsSync(), isTrue);
    expect(File(Images.iconPayDeliveryCharge).existsSync(), isTrue);
    expect(File(Images.iconPayPending).existsSync(), isTrue);
    expect(File(Images.iconPayProcessing).existsSync(), isTrue);
    expect(File(Images.iconPayWithDraw).existsSync(), isTrue);
    expect(File(Images.iconTotalUnsettledAmount).existsSync(), isTrue);
    expect(File(Images.svgCheck).existsSync(), isTrue);
  });
}
