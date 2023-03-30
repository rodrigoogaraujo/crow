import 'dart:math';

import 'package:crow/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Ufo extends SpriteComponent with HasGameRef<CrowGame> {
  Ufo() : super() {
    /* debugMode = true; */
  }
  final _random = Random();
  @override
  void onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('ufo.png');
    size = Vector2(gameRef.size.y * 800 / 469, gameRef.size.y) * 0.10;
    flipHorizontallyAroundCenter();
    double yPosition = _random.nextDouble() * game.size.y;
    position = Vector2(gameRef.size.x * 0.95, yPosition);
    add(
      CircleHitbox(
          anchor: Anchor.center, radius: size.y * 0.35, position: size / 2),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (x > 0 && !gameRef.gameOver) {
      x = x - 100 * dt;
    } else {
      removeFromParent();
    }

    if (gameRef.elapsedTime.elapsed.inSeconds > 30 && x > gameRef.crow.x) {
      if (gameRef.crow.y > y) {
        y += 3 * dt;
      } else {
        y -= 3 * dt;
      }
    }
  }
}
