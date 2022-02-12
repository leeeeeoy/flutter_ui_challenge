import 'package:flutter/material.dart';
import 'package:ui_challenge/default_layout.dart';
import 'package:ui_challenge/topic/like_interaction/animated_heart.dart';

final List<AnimatedHeart> hearts = [];

class LikeInteractionPage extends StatefulWidget {
  const LikeInteractionPage({Key? key}) : super(key: key);

  @override
  State<LikeInteractionPage> createState() => _LikeInteractionPageState();
}

class _LikeInteractionPageState extends State<LikeInteractionPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Like Interaction',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    hearts.add(AnimatedHeart(
                      key: ValueKey(_count),
                      value: _count,
                    ));
                    _count++;
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.favorite_border_sharp,
                    size: 50,
                  ),
                ),
                ...hearts,
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Like: $_count',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
