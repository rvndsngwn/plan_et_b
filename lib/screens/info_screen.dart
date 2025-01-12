import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';

import '../helpers/audio_player.dart';
import '../helpers/glitch_extension.dart';
import '../helpers/platform_detector.dart';
import '../widgets/button.dart';
import '../widgets/dialog.dart';

// Info screen, a.k.a. Main Screen of the app.
class InfoScreen extends StatelessWidget {
  const InfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    // Portrait orientation devices will need a little bit more lines for texts.
    final bool _portraitOrientation = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height * 1.25;
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.topRight,
        children: [
          Opacity(
            opacity: 0.66,
            child: Image.asset('assets/images/StarfieldSimulation_rot.gif',
                fit: BoxFit.fill, filterQuality: FilterQuality.high),
          ),
          PlayAnimation<double>(
            tween: Tween<double>(begin: 0.1, end: 1),
            duration: const Duration(seconds: 1),
            builder: (context, child, value) => Transform.scale(scale: value, child: child),
            child: Opacity(
              opacity: 0.9,
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 0.85,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Color(0xFF09cad9), width: 4),
                          bottom: BorderSide(color: Color(0xFF09cad9), width: 4)),
                      gradient: RadialGradient(
                          center: Alignment(-0.6, -0.5),
                          radius: 0.1,
                          colors: <Color>[Color(0x4d084e79), Color(0x40032331)],
                          stops: <double>[0.9, 1]),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      heightFactor: 0.9,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Opacity(opacity: 0.75, child: const Text('Plan-et-B', maxLines: 1).glitchText)),
                          Opacity(
                            opacity: 0.66,
                            child: AutoSizeText(
                                "2077y ...the world is divided. Since 2020, there have been tremendous changes in social order. The countries have lost their geopolitical influence because of internal problems, so they have ceased efforts to change the climate on Earth. It's becoming impossible to live here, your mission is find a new planet (Planet B). Unfortunately, you have a limited amount of fuel.",
                                maxLines: _portraitOrientation ? 5 : 11,
                                minFontSize: 11,
                                style: FontEnchantments.text,
                                textAlign: TextAlign.center),
                          ),
                          const CyberButton(text: 'Play'),
                          Flexible(
                            child: AutoSizeText(
                                GameControls.isSmartphone
                                    ? "Drag to look around, double tap tap to determine a planet's suitability for life. There is a dozen planets to check"
                                    : "Move aim to look around, press to determine a planet's suitability for life. There is a dozen planets to check.",
                                maxLines: _portraitOrientation ? 2 : 4,
                                minFontSize: 11,
                                style: FontEnchantments.text,
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: LoopAnimation<double>(
              tween: Tween<double>(begin: 0.3, end: 0.8),
              duration: const Duration(seconds: 3),
              curve: Curves.easeOut,
              builder: (context, child, value) => Opacity(opacity: value, child: child),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //About icon.
                  IconButton(
                      iconSize: 40,
                      padding: const EdgeInsets.all(12),
                      color: const Color(0x9909cad9),
                      tooltip: 'About this game.',
                      icon: const Icon(Icons.info_outline),
                      onPressed: () => showDialog<void>(context: context, builder: (_) => const CyberDialog())),
                  // Music button.
                  IconButton(
                      iconSize: 40,
                      padding: const EdgeInsets.all(12),
                      color: const Color(0xFF09cad9),
                      tooltip:
                          'Play/Pause Music. There is short delay, please wait for it.\nYou will not hear any sounds if DND or silence mode is enabled.',
                      icon: const Icon(Icons.music_note),
                      onPressed: () => AudioPlayer.playOrPauseMusic)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
