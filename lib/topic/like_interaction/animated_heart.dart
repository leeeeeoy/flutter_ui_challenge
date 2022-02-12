import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_challenge/topic/like_interaction/like_interaction_page.dart';

class AnimatedHeart extends StatefulWidget {
  const AnimatedHeart({
    Key? key,
    required this.value,
  }) : super(key: key);

  final int value;

  @override
  State<AnimatedHeart> createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<AnimatedHeart>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    repeatOnce();

    super.initState();
  }

  void repeatOnce() async {
    await _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: const Icon(
        CupertinoIcons.heart_fill,
        color: Colors.red,
        size: 40,
      ),
      builder: (BuildContext context, Widget? child) {
        if (_controller.status == AnimationStatus.completed) {
          hearts.removeWhere(
              (element) => (element.key as ValueKey).value == widget.value);
        }
        return Opacity(
          opacity: 1 - _controller.value,
          child: Transform(
            transform: Matrix4(
                _controller.value + 1,
                0,
                0,
                0,
                0,
                _controller.value + 1,
                0,
                0,
                0,
                0,
                1,
                0,
                0,
                _controller.value * -200,
                0,
                1)
              ..rotateZ(_controller.value),
            child: child,
          ),
        );
      },
    );
  }
}
