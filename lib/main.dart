import 'package:crow/utils/game_over_screen.dart';
import 'package:crow/utils/game_play_screen.dart';
import 'package:crow/utils/start_screen.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

import 'admob/interstitial.dart';
import 'players/crow.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      //Tela cheia
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  //Orientação da Tela
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Carrega admob
  if (defaultTargetPlatform == TargetPlatform.android) {
    MobileAds.instance.initialize();
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    MobileAds.instance.initialize();
  } else {
//web or desktop specific code
  }

  runApp(GameWidget(game: CrowGame()));
}

class CrowGame extends FlameGame
    with HasTappableComponents, HasCollisionDetection {
  Vector2 gravity = Vector2(0, 0.30);
  late final RouterComponent router;
  bool gameOver = false;
  bool showingGameOverScreen = false;
  Crow crow = Crow();
  Stopwatch elapsedTime = Stopwatch();

  @override
  void onLoad() async {
    createInterstitialAd();
    super.onLoad();
    add(
      router = RouterComponent(
        initialRoute: 'start',
        routes: {
          'gameplay': Route(GamePlayScreen.new),
          'gameover': Route(GameOverScreen.new),
          'start': Route(StartScreen.new),
        },
      ),
    );
  }

  @override
  void update(double dt) {
    if (gameOver && !showingGameOverScreen) {
      router.pushNamed('gameover');
      showingGameOverScreen = true;
    }
    super.update(dt);
  }
}
