import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:techanalyticatest/core/utils/assets/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.dummyMap).existsSync(), isTrue);
    expect(File(Images.loginBg).existsSync(), isTrue);
    expect(File(Images.onboardingBg).existsSync(), isTrue);
    expect(File(Images.iconBbb).existsSync(), isTrue);
    expect(File(Images.iconCcc).existsSync(), isTrue);
    expect(File(Images.iconDdd).existsSync(), isTrue);
    expect(File(Images.iconDestinationPin).existsSync(), isTrue);
    expect(File(Images.iconHome).existsSync(), isTrue);
    expect(File(Images.iconLocationPin).existsSync(), isTrue);
    expect(File(Images.iconRebook).existsSync(), isTrue);
  });
}
