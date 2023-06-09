import 'package:crow/enemies/ufo.dart';
import 'package:crow/utils/elapsed_time.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/parallax.dart';

import '../main.dart';

class GamePlayScreen extends Component with HasGameRef<CrowGame>, TapCallbacks {
  Timer interval = Timer(6, repeat: true);

  @override
  void onLoad() async {
    await super.onLoad();
    gameRef.elapsedTime.start();
    ParallaxComponent mountainBackground = await gameRef.loadParallaxComponent([
      ParallaxImageData('sky.png'),
      ParallaxImageData('clouds_bg.png'),
      ParallaxImageData('glacial_mountains.png'),
      ParallaxImageData('clouds_mg_1.png'),
      ParallaxImageData('cloud_lonely.png'),
    ],
        baseVelocity: Vector2(10, 0),
        velocityMultiplierDelta: Vector2(1.6, 1.0));
    add(mountainBackground);

    add(gameRef.crow);
    addShips();
    add(ElapsedTime());
  }

  void addShips() {
    interval.onTick = () {
      double elapsedSeconds = gameRef.elapsedTime.elapsed.inSeconds.toDouble();

      void addShipAtSecond(int secondToAdd) {
        Future.delayed(Duration(seconds: secondToAdd), () {
          add(Ufo());
        });
      }

      add(Ufo());
      if (elapsedSeconds > 10.0) {
        addShipAtSecond(5);
      }
      if (elapsedSeconds > 20.0) {
        addShipAtSecond(6);
      }
      if (elapsedSeconds > 30.0) {
        addShipAtSecond(8);
      }
    };
  }

  @override
  void update(double dt) {
    interval.update(dt);
    super.update(dt);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) {
    gameRef.gravity.y -= 20;

    super.onTapUp(event);
  }
}
