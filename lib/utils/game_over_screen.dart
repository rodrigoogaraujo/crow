
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart' hide Route;

import '../admob/interstitial.dart';
import '../main.dart';
import 'package:flutter/foundation.dart';

class GameOverScreen extends Component with HasGameRef<CrowGame>, TapCallbacks {
  @override
  void onLoad() async {
    await super.onLoad();
    add(
      TextComponent(
        text: 'GAME OVER',
        anchor: Anchor.center,
        position: gameRef.size / 2,
        textRenderer: TextPaint(
            style: const TextStyle(
                fontSize: 64,
                color: Colors.red,
                fontFamily: 'Kaph',
                fontStyle: FontStyle.normal)),
      ),
    );
    add(TextComponent(
      text: "dev by novigo.dev",
      anchor: Anchor.center,
      position: Vector2(gameRef.size.x / 2, gameRef.size.y * 0.25),
      textRenderer: TextPaint(
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Kaph',
              fontStyle: FontStyle.normal)),
    ));
  }

  @override
  void update(double dt) {
    if (gameRef.elapsedTime.isRunning) {
      gameRef.elapsedTime.reset();
      gameRef.elapsedTime.stop();
      if (defaultTargetPlatform == TargetPlatform.android) {
        showInterstitialAd();
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        showInterstitialAd();
      } else {
        null;
      }
    }
    super.update(dt);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) {
    gameRef.crow.position = gameRef.size / 2;
    gameRef.showingGameOverScreen = false;
    gameRef.gameOver = false;
    gameRef.gravity = Vector2(0, 30);
    gameRef.router.pop();
    gameRef.elapsedTime.start();
    super.onTapUp(event);
  }
}
