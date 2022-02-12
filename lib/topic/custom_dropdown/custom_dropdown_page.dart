import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_challenge/default_layout.dart';
import 'package:ui_challenge/topic/custom_dropdown/custom_dropdown.dart';
import 'package:ui_challenge/topic/custom_dropdown/dropdown_provider.dart';

class CustomDropdownPage extends ConsumerWidget {
  const CustomDropdownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _key = ref.watch(dropDownKeyProvider);
    dev.log('$_key');

    return DefaultLayout(
      title: 'Custom Dropdown',
      body: Center(
        child: Container(
          color: Colors.amberAccent,
          height: 200,
          width: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomDropDown(
                key: _key,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
