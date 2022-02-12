import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: key,
        appBar: AppBar(
          title: Text(title),
        ),
        body: body,
      ),
    );
  }
}
