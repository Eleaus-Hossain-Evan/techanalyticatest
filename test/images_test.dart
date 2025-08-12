import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:techanalyticatest/core/utils/assets/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.loginBg).existsSync(), isTrue);
    expect(File(Images.onboardingBg).existsSync(), isTrue);
  });
}
