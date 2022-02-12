import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DivideHalfPage extends StatefulWidget {
  const DivideHalfPage({Key? key}) : super(key: key);

  @override
  State<DivideHalfPage> createState() => _DivideHalfPageState();
}

class _DivideHalfPageState extends State<DivideHalfPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final GlobalKey _globalKey = GlobalKey();
  Uint8List? _file;

  bool isTab = false;

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

  // 위젯을 이미지로 캡쳐
  Future<void> _capturePng() async {
    final boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    final ui.Image image = await boundary!.toImage();
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final imageBytes = byteData!.buffer.asUint8List();
    _file = imageBytes;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await _capturePng();
            isTab = true;
            setState(() {});
          },
          child: const Icon(CupertinoIcons.add_circled),
        ),
        body: AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: isTab ? 0.2 : 1,
          child: RepaintBoundary(
            key: _globalKey,
            child: !isTab
                ? ListView.builder(
                    itemBuilder: (context, index) => Container(
                        color: Colors.yellowAccent,
                        child: const FlutterLogo(size: 200)),
                    itemCount: 50)
                : Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(-70 * _controller.value, 0),
                            child: child,
                          );
                        },
                        child: ClipRect(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            widthFactor: 0.5,
                            heightFactor: 1,
                            child: Image.memory(_file!),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(70 * _controller.value, 0),
                            child: child,
                          );
                        },
                        child: ClipRect(
                          child: Align(
                            alignment: Alignment.centerRight,
                            widthFactor: 0.5,
                            heightFactor: 1,
                            child: Image.memory(_file!),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class MyClipperL extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(Rect.fromLTRB(0, 0, size.width / 2, size.height));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyClipperR extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(Rect.fromLTRB(size.width / 2, 0, size.width, size.height));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

                    // ClipRect(
                    //   child: Container(
                    //     child: Align(
                    //       alignment: Alignment.centerRight,
                    //       widthFactor: 0.5,
                    //       heightFactor: 1,
                    //       child: Image.memory(_file!),
                    //     ),
                    //   ),
                    // ),