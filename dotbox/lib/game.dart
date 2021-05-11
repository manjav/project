import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';

class MyGame extends BaseGame with TapDetector {
  MyGame() {
  }

  @override
  Color backgroundColor() => const Color(0xFF00FF00);

  @override
  void onTapDown(TapDownDetails details) {
    print(details);
  }

  @override
  void onTapUp(TapUpDetails details) {
    print(details);
  }
}
