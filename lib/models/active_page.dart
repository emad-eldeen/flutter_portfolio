import 'dart:async';

import 'package:flutter/material.dart';

class ActivePage extends ChangeNotifier {
  int _index = 0;
  // debounce to prevent intermediate changes of the index between pages when
  // clicking on navbar items
  Timer? _debounce;

  // getter for the active page index
  int get index => _index;

  set index(int? index) {
    // disable active timer
    if (_debounce?.isActive ?? true) _debounce?.cancel();
    // update after x ms (wait in case of intermediate update
    _debounce = Timer(const Duration(milliseconds: 50), () {
      // update only in case of the new index is different from the current
      if (index != null && index != _index) {
        _index = index;
        notifyListeners();
      }
    });
  }
}
