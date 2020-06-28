import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flare_flutter/flare_actor.dart' show FlareActor;
import 'package:flare_flutter/asset_provider.dart' show AssetProvider;
import 'package:flare_flutter/provider/asset_flare.dart' show AssetFlare;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'ik_controller.dart';
import 'platform_detector.dart';
import 'pseudo3D_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key navKey}) : super(key: navKey);
  static final navKey = GlobalKey<NavigatorState>();

  static AssetProvider cache =
      AssetFlare(bundle: rootBundle, name: 'assets/animations/background.flr');

  static TextStyle textStyle(
      [Color _color = const Color(0xFFffffff), double _fontSize]) {
    return TextStyle(
        fontFamily: 'Seldom Scene', color: _color, fontSize: _fontSize);
  }

  AssetProvider get _cache => cache;

  @override
  _MyMainScreenState createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> _pseudo3D, _depth;
  AnimationController _hudController;
  final IKController _ikController = IKController();
  double _point = 0.0, _turn = 0.0;
  final AssetsAudioPlayer _sfxAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _sfxAudioPlayer.open(
      Audio('assets/audio/misc_12.ogg'),
      autoStart: true,
      volume: 0.5,
      playInBackground: PlayInBackground.disabledRestoreOnForeground,
      respectSilentMode: true,
      showNotification: false,
    );

    _hudController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..addListener(
        () => setState(
          () {
            if (_pseudo3D != null) {
              _point *= _pseudo3D.value;
              _turn *= _pseudo3D.value;
            }
          },
        ),
      );
    _hudController.forward(from: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFF000000),
      child: GameControls(
        onTap: () {
          _sfxAudioPlayer.play();
          setState(() => _ikController.detecting = true);
        },
        onHover: (dynamic _moveOver) {
          _point += _moveOver.delta.dy * (0.1 / _size.height) as num;
          _turn -= _moveOver.delta.dx * (0.1 / _size.width) as num;
          setState(() => _ikController.moveAim(Offset(
              (_moveOver.localPosition.dx) as double,
              (_moveOver.localPosition.dy) as double)));
        },
        onExit: (dynamic _details) {
          _pseudo3D = Tween<double>(
            begin: 1.0,
            end: 0.0,
          ).animate(_hudController);
          _depth = Tween<double>(
            begin: 1.0,
            end: 0.0,
          ).animate(
            CurvedAnimation(
                parent: _hudController, curve: const Cubic(0.5, 0, 0.25, 1.0)),
          );
          _hudController.forward();
          setState(() =>
              _ikController.moveAim(Offset(_size.width / 2, _size.height / 2)));
        },
        onEnter: (dynamic _details) {
          _pseudo3D = null;
          _depth = Tween<double>(
            begin: 1.0,
            end: 0.0,
          ).animate(
            CurvedAnimation(
                parent: _hudController, curve: const Cubic(1.0, 0.0, 1.0, 1.0)),
          );
          _hudController.reverse();
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: FlareActor.asset(widget._cache,
                  animation: 'game', controller: _ikController),
            ),
            Positioned.fill(
              child: RivePseudo3DWidget(
                  point: _point, turn: _turn, depth: _depth?.value ?? 0.0),
            ),
          ],
        ),
      ),
    );
  }
}
