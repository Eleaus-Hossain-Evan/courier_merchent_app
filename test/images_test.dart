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
    expect(File(Images.iconFacebook).existsSync(), isTrue);
    expect(File(Images.iconGoogle).existsSync(), isTrue);
    expect(File(Images.svgCheck).existsSync(), isTrue);
  });
}
