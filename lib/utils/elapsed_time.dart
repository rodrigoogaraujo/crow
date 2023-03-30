import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ElapsedTime extends TextComponent with HasGameRef<CrowGame> {
  @override
  void onLoad() async {
    await super.onLoad();
    scale = Vector2.all(3);
    position = Vector2(gameRef.size.x / 2, 4);
    textRenderer = TextPaint(
        style: const TextStyle(
            color: Color.fromARGB(255, 5, 100, 5),
            fontFamily: 'Kaph',
            fontStyle: FontStyle.normal));
  }

  @override
  void update(double dt) {
    text = gameRef.elapsedTime.elapsed.inSeconds.toString();
    super.update(dt);
  }
}
