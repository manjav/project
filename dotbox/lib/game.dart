import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';

/* class MyGame extends BaseGame with TapDetector {
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

*/

class Palette {
  static const PaletteEntry white = BasicPalette.white;
  static const PaletteEntry red = PaletteEntry(Color(0xFFFF0000));
  static const PaletteEntry blue = PaletteEntry(Color(0xFF0000FF));
}

class Square extends PositionComponent with HasGameRef<MyGame> {
  static const SPEED = 0.25;
  static Paint white = Palette.white.paint();
  static Paint red = Palette.red.paint();
  static Paint blue = Palette.blue.paint();

  @override
  void render(Canvas c) {
    super.render(c);
    // prepareCanvas(c);

    c.drawRect(size.toRect(), white);
    c.drawRect(const Rect.fromLTWH(0, 0, 3, 3), red);
    c.drawRect(Rect.fromLTWH(width / 2, height / 2, 3, 3), blue);
  }

  @override
  void update(double t) {
    super.update(t);
    angle += SPEED * t;
    angle %= 2 * 3.1415;
  }

  @override
  void onMount() {
    super.onMount();
    width = height = gameRef.squareSize;
    anchor = Anchor.center;
  }
}

class MyGame extends BaseGame with DoubleTapDetector, TapDetector, PanDetector {
  final double squareSize = 128;
  bool running = true;

  MyGame() {
    // add(Square()
    //   ..x = 100
    //   ..y = 100);
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    print(details.globalPosition);
  }

  @override
  void onTapUp(details) {
    final touchArea = Rect.fromCenter(
      center: details.localPosition,
      width: 20,
      height: 20,
    );

    bool handled = false;
    components.forEach((c) {
      if (c is PositionComponent && c.toRect().overlaps(touchArea)) {
        handled = true;
        remove(c); //markToRemove
      }
    });

    if (!handled) {
      add(Square() //addLater
        ..x = touchArea.left
        ..y = touchArea.top);
    }
  }

  @override
  void onDoubleTap() {
    if (running) {
      pauseEngine();
    } else {
      resumeEngine();
    }

    running = !running;
  }
}
