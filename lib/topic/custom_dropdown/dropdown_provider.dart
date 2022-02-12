import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dropDownKeyProvider = Provider<GlobalKey>((ref) {
  return GlobalKey();
});
