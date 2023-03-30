import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'constants.dart';

InterstitialAd? interstitialAd;
int numInterstitialLoadAttempts = 0;

void createInterstitialAd() {
  //Id teste
  Constants.testDevice;
  InterstitialAd.load(
      adUnitId: Constants.admobTestInterstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('$ad carregado');
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd falhou ao carregar $error.');
          numInterstitialLoadAttempts += 1;
          interstitialAd = null;
          if (numInterstitialLoadAttempts < Constants.maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ));
}

void showInterstitialAd() {
  if (interstitialAd == null) {
    debugPrint('Aviso: tentou mostrar o intersticial antes de ser carregado.');
    return;
  }
  interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (InterstitialAd ad) =>
        debugPrint('$ad onAdShowedFullScreenContent.'),
    onAdDismissedFullScreenContent: (InterstitialAd ad) {
      debugPrint('$ad onAdDismissedFullScreenContent.');
      ad.dispose();
      createInterstitialAd();
    },
    onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
      ad.dispose();
      createInterstitialAd();
    },
  );
  interstitialAd!.show();
  interstitialAd = null;
}
