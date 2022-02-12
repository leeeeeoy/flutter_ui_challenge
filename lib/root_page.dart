import 'package:flutter/material.dart';
import 'package:ui_challenge/topic/custom_dropdown/custom_dropdown_page.dart';
import 'package:ui_challenge/topic/divide_half/divide_half_page.dart';
import 'package:ui_challenge/topic/like_interaction/like_interaction_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Root Page'),
      ),
      body: Center(
        child: Wrap(
          runSpacing: 5,
          spacing: 5,
          children: const [
            _PageButton(
              name: 'Like Interation',
              pushPage: LikeInteractionPage(),
            ),
            _PageButton(
              name: 'Divide Widget',
              pushPage: DivideHalfPage(),
            ),
            _PageButton(
              name: 'Custom Dropdown',
              pushPage: CustomDropdownPage(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  const _PageButton({
    Key? key,
    required this.name,
    required this.pushPage,
  }) : super(key: key);

  final String name;
  final Widget pushPage;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => pushPage)),
      child: Text(name),
    );
  }
}
