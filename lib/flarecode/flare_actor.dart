import 'dart:math';
import 'dart:typed_data';
import 'package:bhukkd/flarecode/flare_render_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:bhukkd/flarecode/lib/actor_drawable.dart';
import 'package:bhukkd/flarecode/lib/math/mat2d.dart';
import 'package:bhukkd/flarecode/lib/math/vec2d.dart';
import 'package:bhukkd/flarecode/lib/math/aabb.dart';
import 'flare.dart';
import 'flare_controller.dart';

typedef void FlareCompletedCallback(String name);

class FlareActor extends LeafRenderObjectWidget {
  final String filename;
  final String animation;
  final bool snapToEnd;
  final BoxFit fit;
  final Alignment alignment;
  final bool isPaused;
  final bool shouldClip;
  final FlareController controller;
  final FlareCompletedCallback callback;
  final Color color;
  final String boundsNode;

  const FlareActor(this.filename,
      {this.boundsNode,
      this.animation,
      this.fit = BoxFit.contain,
      this.alignment = Alignment.center,
      this.isPaused = false,
      this.snapToEnd = false,
      this.controller,
      this.callback,
      this.color,
      this.shouldClip = true});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return FlareActorRenderObject()
      ..assetBundle = DefaultAssetBundle.of(context)
      ..filename = filename
      ..fit = fit
      ..alignment = alignment
      ..animationName = animation
      ..snapToEnd = snapToEnd
      ..isPlaying = !isPaused
      ..controller = controller
      ..completed = callback
      ..color = color
      ..shouldClip = shouldClip
      ..boundsNodeName = boundsNode;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant FlareActorRenderObject renderObject) {
    renderObject
      ..assetBundle = DefaultAssetBundle.of(context)
      ..filename = filename
      ..fit = fit
      ..alignment = alignment
      ..animationName = animation
      ..snapToEnd = snapToEnd
      ..isPlaying = !isPaused
      ..color = color
      ..shouldClip = shouldClip
      ..boundsNodeName = boundsNode;
  }

  @override
  void didUnmountRenderObject(covariant FlareActorRenderObject renderObject) {
    renderObject.dispose();
  }
}

class FlareAnimationLayer {
  String name;
  ActorAnimation animation;
  double time = 0.0, mix = 0.0, mixSeconds = 0.2;
  void apply(FlutterActorArtboard artboard) {
    animation.apply(time, artboard, mix);
  }

  double get duration => animation.duration;
  bool get isDone => time >= animation.duration;
}

class FlareActorRenderObject extends FlareRenderBox {
  String _filename;
  String _animationName;
  String _boundsNodeName;
  FlareController _controller;
  FlareCompletedCallback _completedCallback;
  bool snapToEnd = false;

  final List<FlareAnimationLayer> _animationLayers = [];
  bool shouldClip;

  FlutterActorArtboard _artboard;
  AABB _setupAABB;

  Color _color;

  Color get color => _color;
  set color(Color value) {
    if (value != _color) {
      _color = value;
      if (_artboard != null) {
        _artboard.overrideColor = value == null
            ? null
            : Float32List.fromList([
                value.red / 255.0,
                value.green / 255.0,
                value.blue / 255.0,
                value.opacity
              ]);
      }
      markNeedsPaint();
    }
  }

  String get boundsNodeName => _boundsNodeName;
  set boundsNodeName(String value) {
    if (_boundsNodeName == value) {
      return;
    }
    _boundsNodeName = value;
    if (_artboard != null) {
      ActorNode node = _artboard.getNode(_boundsNodeName);
      if (node is ActorDrawable) {
        _setupAABB = node.computeAABB();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller = null;
  }

  void updateBounds() {
    if (_artboard != null) {
      ActorNode node;
      if (_boundsNodeName != null &&
          (node = _artboard.getNode(_boundsNodeName)) is ActorDrawable) {
        _setupAABB = (node as ActorDrawable).computeAABB();
      } else {
        _setupAABB = _artboard.artboardAABB();
      }
    }
  }

  String get animationName => _animationName;
  set animationName(String value) {
    if (value != _animationName) {
      _animationName = value;
      _updateAnimation();
    }
  }

  FlareController get controller => _controller;
  set controller(FlareController c) {
    if (_controller != c) {
      _controller = c;
      if (_controller != null && _artboard != null) {
        _controller.initialize(_artboard);
      }
    }
  }

  @override
  void onUnload() {
    _animationLayers.length = 0;
  }

  String get filename => _filename;
  set filename(String value) {
    if (value == _filename) {
      return;
    }
    _filename = value;

    if (_filename == null) {
      markNeedsPaint();
    }

    load();
  }

  @override
  void load() {
    super.load();
    loadFlare(_filename).then((FlutterActor actor) {
      if (actor == null || actor.artboard == null) {
        return;
      }
      _artboard = actor.artboard.makeInstance() as FlutterActorArtboard;
      _artboard.initializeGraphics();
      _artboard.overrideColor = _color == null
          ? null
          : Float32List.fromList([
              _color.red / 255.0,
              _color.green / 255.0,
              _color.blue / 255.0,
              _color.opacity
            ]);
      _artboard.advance(0.0);
      updateBounds();

      if (_controller != null) {
        _controller.initialize(_artboard);
      }
      _updateAnimation(onlyWhenMissing: true);
      markNeedsPaint();
    });
  }

  FlareCompletedCallback get completed => _completedCallback;
  set completed(FlareCompletedCallback value) {
    if (_completedCallback != value) {
      _completedCallback = value;
    }
  }

  @override
  bool advance(double elapsedSeconds) {
    if (isPlaying) {
      int lastFullyMixed = -1;
      double lastMix = 0.0;

      List<FlareAnimationLayer> completed = [];

      for (int i = 0; i < _animationLayers.length; i++) {
        FlareAnimationLayer layer = _animationLayers[i];

        if (snapToEnd && !layer.animation.isLooping) {
          layer.mix = 1.0;
          layer.time = layer.duration;
        } else {
          layer.mix += elapsedSeconds;
          layer.time += elapsedSeconds;
        }

        lastMix = (layer.mixSeconds == null || layer.mixSeconds == 0.0)
            ? 1.0
            : min(1.0, layer.mix / layer.mixSeconds);
        if (layer.animation.isLooping) {
          layer.time %= layer.animation.duration;
        }
        layer.animation.apply(layer.time, _artboard, lastMix);
        if (lastMix == 1.0) {
          lastFullyMixed = i;
        }
        if (layer.time > layer.animation.duration) {
          completed.add(layer);
        }
      }

      if (lastFullyMixed != -1) {
        _animationLayers.removeRange(0, lastFullyMixed);
      }
      if (animationName == null &&
          _animationLayers.length == 1 &&
          lastMix == 1.0) {
        // Remove remaining animations.
        _animationLayers.removeAt(0);
      }
      for (final FlareAnimationLayer animation in completed) {
        _animationLayers.remove(animation);
        if (_completedCallback != null) {
          _completedCallback(animation.name);
        }
      }
    }

    bool stopPlaying = true;
    if (_animationLayers.isNotEmpty) {
      stopPlaying = false;
    }

    if (_controller != null) {
      if (_controller.advance(_artboard, elapsedSeconds)) {
        stopPlaying = false;
      }
    }

    if (_artboard != null) {
      _artboard.advance(elapsedSeconds);
    }

    if (stopPlaying) {
      isPlaying = false;
    }

    return !stopPlaying;
  }

  @override
  AABB get aabb => _setupAABB;

  @override
  void prePaint(Canvas canvas, Offset offset) {
    if (shouldClip) {
      canvas.clipRect(offset & size);
    }
  }

  @override
  void paintFlare(Canvas canvas, Mat2D viewTransform) {
    if (_artboard == null) {
      return;
    }
    _artboard.draw(canvas);
  }

  void _updateAnimation({bool onlyWhenMissing = false}) {
    if (onlyWhenMissing && _animationLayers.isNotEmpty) {
      return;
    }
    if (_animationName != null && _artboard != null) {
      ActorAnimation animation = _artboard.getAnimation(_animationName);
      if (animation != null) {
        _animationLayers.add(FlareAnimationLayer()
          ..name = _animationName
          ..animation = animation
          ..mix = 1.0
		  ..mixSeconds = 0.2);
        animation.apply(0.0, _artboard, 1.0);
        _artboard.advance(0.0);
      }
    }
  }
}
