import 'package:flutter/material.dart';

class CounterInheritedWidget extends InheritedWidget {
  final int counter;
  final VoidCallback incrementCounter;

  const CounterInheritedWidget({
    super.key,
    required this.counter,
    required this.incrementCounter,
    required Widget child,
  }) : super(child: child);

  static CounterInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterInheritedWidget>();
  }

  @override
  bool updateShouldNotify(CounterInheritedWidget oldWidget) {
    return oldWidget.counter != counter;
  }
} 