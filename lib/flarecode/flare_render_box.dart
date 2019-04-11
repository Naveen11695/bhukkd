import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:bhukkd/flarecode/lib/math/aabb.dart';
import 'package:bhukkd/flarecode/lib/math/mat2d.dart';
import 'package:bhukkd/flarecode/lib/math/vec2d.dart';
import 'flare.dart';
import 'flare_cache.dart';
import 'flare_cache_asset.dart';

/// A render box for Flare content.
abstract class FlareRenderBox extends RenderBox {
  AssetBundle _assetBundle;
  BoxFit _fit;
  Alignment _alignment;
  int _frameCallbackID;
  double _lastFrameTime = 0.0;
  bool _isPlaying = false;

  final List<FlareCacheAsset> _assets = [];

  AssetBundle get assetBundle => _assetBundle;
  set assetBundle(AssetBundle value) {
    if (_assetBundle == value) {
      return;
    }
    _assetBundle = value;
    if (_assetBundle != null) {
      load();
    }
  }

  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    if (value != _isPlaying) {
      _isPlaying = value;
      _updatePlayState();
    }
  }

  BoxFit get fit => _fit;
  set fit(BoxFit value) {
    if (value != _fit) {
      _fit = value;
      markNeedsPaint();
    }
  }

  void _updatePlayState() {
    if (_isPlaying && attached) {
      _frameCallbackID ??=
          SchedulerBinding.instance.scheduleFrameCallback(_beginFrame);
    } else {
      if (_frameCallbackID != null) {
        SchedulerBinding.instance.cancelFrameCallbackWithId(_frameCallbackID);
        _frameCallbackID = null;
      }
      _lastFrameTime = 0.0;
    }
  }

  Alignment get alignment => _alignment;
  set alignment(Alignment value) {
    if (value != _alignment) {
      _alignment = value;
      markNeedsPaint();
    }
  }

  @override
  bool get sizedByParent => true;

  @override
  bool hitTestSelf(Offset screenOffset) => true;

  @override
  void performResize() {
    size = constraints.biggest;
  }

  @override
  void detach() {
    super.detach();
    dispose();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _updatePlayState();
  }

  void dispose() {
    _isPlaying = false;
    _updatePlayState();
    _unload();
  }

  void _beginFrame(Duration timestamp) {
    _frameCallbackID = null;
    final double t =
        timestamp.inMicroseconds / Duration.microsecondsPerMillisecond / 1000.0;
    if (_lastFrameTime == 0) {
      _lastFrameTime = t;
      _updatePlayState();
      return;
    }

    double elapsedSeconds = t - _lastFrameTime;
    _lastFrameTime = t;

    if (advance(elapsedSeconds)) {
      _updatePlayState();
    }

    markNeedsPaint();
  }

  /// Get the Axis Aligned Bounding Box that encompasses the world space scene
  AABB get aabb;

  void paintFlare(Canvas canvas, Mat2D viewTransform);
  void prePaint(Canvas canvas, Offset offset) {}
  void postPaint(Canvas canvas, Offset offset) {}

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;

    AABB bounds = aabb;
    if (bounds != null) {
      double contentWidth = bounds[2] - bounds[0];
      double contentHeight = bounds[3] - bounds[1];
      double x =
          -bounds[0] - contentWidth / 2.0 - (_alignment.x * contentWidth / 2.0);
      double y = -bounds[1] -
          contentHeight / 2.0 -
          (_alignment.y * contentHeight / 2.0);

      double scaleX = 1.0, scaleY = 1.0;

      canvas.save();
      prePaint(canvas, offset);

      switch (_fit) {
        case BoxFit.fill:
          scaleX = size.width / contentWidth;
          scaleY = size.height / contentHeight;
          break;
        case BoxFit.contain:
          double minScale =
              min(size.width / contentWidth, size.height / contentHeight);
          scaleX = scaleY = minScale;
          break;
        case BoxFit.cover:
          double maxScale =
              max(size.width / contentWidth, size.height / contentHeight);
          scaleX = scaleY = maxScale;
          break;
        case BoxFit.fitHeight:
          double minScale = size.height / contentHeight;
          scaleX = scaleY = minScale;
          break;
        case BoxFit.fitWidth:
          double minScale = size.width / contentWidth;
          scaleX = scaleY = minScale;
          break;
        case BoxFit.none:
          scaleX = scaleY = 1.0;
          break;
        case BoxFit.scaleDown:
          double minScale =
              min(size.width / contentWidth, size.height / contentHeight);
          scaleX = scaleY = minScale < 1.0 ? minScale : 1.0;
          break;
      }

      Mat2D transform = Mat2D();
      transform[4] =
          offset.dx + size.width / 2.0 + (_alignment.x * size.width / 2.0);
      transform[5] =
          offset.dy + size.height / 2.0 + (_alignment.y * size.height / 2.0);
      Mat2D.scale(transform, transform, Vec2D.fromValues(scaleX, scaleY));
      Mat2D center = Mat2D();
      center[4] = x;
      center[5] = y;
      Mat2D.multiply(transform, transform, center);

      canvas.translate(
        offset.dx + size.width / 2.0 + (_alignment.x * size.width / 2.0),
        offset.dy + size.height / 2.0 + (_alignment.y * size.height / 2.0),
      );

      canvas.scale(scaleX, scaleY);
      canvas.translate(x, y);

      paintFlare(canvas, transform);

      canvas.restore();
      postPaint(canvas, offset);
    }
  }

  /// Advance animations, physics, etc by elapsedSeconds.
  bool advance(double elapsedSeconds);

  /// Perform any loading logic necessary for this scene.
  void load()
  {
	  _unload();
  }

  void _unload() {
    for (final FlareCacheAsset asset in _assets) {
      asset.deref();
    }
    _assets.clear();
	onUnload();
  }

  void onUnload() {}

  /// Load a flare file from cache
  Future<FlutterActor> loadFlare(String filename) async {
    if (assetBundle == null || filename == null) {
      return null;
    }

    FlareCacheAsset asset = await cachedActor(assetBundle, filename);

    if (!attached || asset == null) {
      return null;
    }
    _assets.add(asset);
    asset.ref();
    return asset.actor;
  }
}
