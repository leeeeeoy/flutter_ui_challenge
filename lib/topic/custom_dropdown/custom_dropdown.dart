import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_challenge/topic/custom_dropdown/dropdown_provider.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const DropDownList(),
              // transitionsBuilder:
              //     (context, animation, secondaryAnimation, child) {
              //   const begin = Offset(0.0, 1.0);
              //   const end = Offset.zero;
              //   const curve = Curves.easeOutSine;

              //   var tween = Tween(
              //     begin: begin,
              //     end: end,
              //   ).chain(
              //     CurveTween(
              //       curve: curve,
              //     ),
              //   );

              //   return SlideTransition(
              //     position: animation.drive(tween),
              //     child: child,
              //   );
              // },
            ),
          );
        },
        child: Container(
          height: 50,
          width: 50,
          color: Colors.red,
          child: const Center(
            child: Text(
              '버튼',
            ),
          ),
        ),
      ),
    );
  }
}

class DropDownList extends ConsumerStatefulWidget {
  const DropDownList({Key? key}) : super(key: key);

  @override
  ConsumerState<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends ConsumerState<DropDownList> {
  double _calPositionY() {
    final _key = ref.watch(dropDownKeyProvider);
    dev.log('$_key');
    var box = _key.currentContext!.findRenderObject()!;
    // var position = box.paintBounds.bottomCenter; //this is global position
    var position = box.paintBounds.bottomCenter;
    dev.log('$position');
    return position.dy;
  }

  double _calPositionX() {
    final _key = ref.watch(dropDownKeyProvider);
    dev.log('$_key');
    var box = _key.currentContext!.findRenderObject()! as RenderBox;
    var position = box.paintBounds.bottomCenter; //this is global position
    dev.log('$position');
    return position.dx;
  }

  Offset _getOverlayEntryPosition() {
    final _key = ref.watch(dropDownKeyProvider);
    RenderBox renderBox = _key.currentContext!.findRenderObject()! as RenderBox;
    return Offset(
      renderBox.localToGlobal(Offset.zero).dx,
      renderBox.localToGlobal(Offset.zero).dy + renderBox.size.height,
    );
  }

  Size _getOverlayEntrySize() {
    final _key = ref.watch(dropDownKeyProvider);
    RenderBox renderBox = _key.currentContext!.findRenderObject()! as RenderBox;
    return renderBox.size;
  }

  @override
  Widget build(BuildContext context) {
    final _offset = _getOverlayEntryPosition();
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned(
              // left: _calPositionX(),
              // top: MediaQuery.of(context).padding.top + _calPositionY(),
              left: _offset.dx,
              top: _offset.dy,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                height: 200,
                width: 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.yellow,
                ),
                child: Scrollbar(
                  isAlwaysShown: true,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 20, bottom: 8),
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.purple[100 * ((index + 1) % 10)],
                        height: 60,
                        child: Center(
                          child: Text(
                            '$index',
                          ),
                        ),
                      );
                    },
                    itemCount: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
