import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtils {
  static int lastIndex = -1;

  static Color getRandomColor() {
    final Random random = Random();

    final List<Color> allowedColors = [
      Colors.red,
      Colors.green,
      Colors.pink,
      Colors.yellow,
      Colors.deepOrange,
      Colors.black,
      Colors.brown,
      Colors.blue,
    ];
    int randomIndex = random.nextInt(allowedColors.length);
    if (randomIndex == lastIndex) {
      randomIndex = random.nextInt(allowedColors.length);
    }
    lastIndex = randomIndex;
    return allowedColors[randomIndex];
  }

  static int lettersToIndex(String letters) {
    var result = 0;
    for (var i = 0; i < letters.length; i++) {
      result = result * 26 + (letters.codeUnitAt(i) & 0x1f);
    }
    return result;
  }

  static Color getNameSpecificColor(String firstChar) {
    int index = lettersToIndex(firstChar) % 8;
    final List<Color> allowedColors = [
      Colors.red,
      Colors.green,
      Colors.pink,
      Colors.yellow,
      Colors.deepOrange,
      Colors.grey,
      Colors.brown,
      Colors.blue,
    ];

    return allowedColors[index];
  }
}
