import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum LottiePathEnum {
  IMAGE_PICKER
}

extension LottiePathEnumExtension on LottiePathEnum {
  String get rawValue {
    switch (this) {
      case LottiePathEnum.IMAGE_PICKER:
        return _pathValue('image-picker');
    }
  }

  Widget get toWidget {
    return Lottie.asset(rawValue);
  }

  String _pathValue(String title) => 'assets/lottie/$title.json';
}
