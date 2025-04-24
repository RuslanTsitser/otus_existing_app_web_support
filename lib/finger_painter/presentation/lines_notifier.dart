import 'package:flutter/material.dart';

import '../domain/line_object.dart';

class LinesNotifierProvider extends InheritedWidget {
  const LinesNotifierProvider({super.key, required super.child, required this.notifier});

  final LinesNotifier notifier;

  static LinesNotifier of(BuildContext context) {
    final LinesNotifierProvider? provider = context.getInheritedWidgetOfExactType<LinesNotifierProvider>();
    return provider!.notifier;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class LinesNotifier extends ValueNotifier<List<LineObject>> {
  LinesNotifier() : super([]);

  void onPanUpdate(DragUpdateDetails details) {
    value.last = value.last.copyWith(points: [...value.last.points, details.localPosition]);
    notifyListeners();
  }

  void onPanStart(DragStartDetails details) {
    value.add(LineObject(color: Colors.red, points: [details.localPosition]));
    notifyListeners();
  }

  void onPanEnd(DragEndDetails details) {}
}
