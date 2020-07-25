import 'dart:ui';

import 'package:flutter/widgets.dart' show ValueNotifier;

import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_dart/math/mat2d.dart' show Mat2D;
import 'package:flare_dart/math/vec2d.dart' show Vec2D;

import 'cockpit_control.dart';

// Here you will need some advantage knowledge of Rive Controllers, please refer to official documentation at:
// https://pub.dev/documentation/flare_dart/latest

class IKController implements FlareController {
  bool detecting = false;

  double _animationTime = 0, _detectTime = 0;
  ActorAnimation _backgroundLoop, _detect;
  ActorNode _ikTarget;
  Offset _screenTouch;
  Mat2D _viewTransform;

  @override
  ValueNotifier<bool> isActive;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    if (_detectTime >= _detect.duration) {
      _detectTime = 0;
      CockpitControl.increaseScore();
      detecting = false;
    } else if (detecting) {
      _detectTime += elapsed;
      _detect?.apply(_detectTime, artboard, 1.0);
    }

    _animationTime += elapsed;
    _backgroundLoop?.apply(_animationTime % _backgroundLoop.duration, artboard, 1.0);

    if (_ikTarget == null || _screenTouch == null || _viewTransform == null) {
      return false;
    }

    Mat2D inverseViewTransform = Mat2D();
    if (!Mat2D.invert(inverseViewTransform, _viewTransform)) {
      return true;
    }

    Vec2D worldTouch = Vec2D();
    Vec2D.transformMat2D(worldTouch, Vec2D.fromValues(_screenTouch.dx, _screenTouch.dy), inverseViewTransform);

    Mat2D inverseTargetWorld = Mat2D();
    if (!Mat2D.invert(inverseTargetWorld, _ikTarget.parent.worldTransform)) {
      return true;
    }

    Vec2D localTouchCoordinates = Vec2D();
    Vec2D.transformMat2D(localTouchCoordinates ?? Vec2D.fromValues(0, 0), worldTouch, inverseTargetWorld);

    CockpitControl.ikTarget.translation = _ikTarget.translation = localTouchCoordinates ?? Vec2D.fromValues(0, 0);
    return true;
  }

  @override
  void initialize(FlutterActorArtboard _artboard) {
    _ikTarget = _artboard.getNode('view_control');
    _backgroundLoop = _artboard.getAnimation('background');
    _detect = _artboard.getAnimation('detect');
  }

  void moveAim(Offset _offset) => _screenTouch = _offset;

  @override
  void setViewTransform(Mat2D viewTransform) => _viewTransform = viewTransform;
}
