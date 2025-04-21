import 'package:flutter/material.dart';

import 'screens/counter_detail_page.dart';
import 'screens/counter_home_page.dart';
import 'state/counter_inherited_widget.dart';

class CounterRoot extends StatefulWidget {
  const CounterRoot({super.key});

  @override
  State<CounterRoot> createState() => _CounterRootState();
}

class _CounterRootState extends State<CounterRoot> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CounterInheritedWidget(
      counter: _counter,
      incrementCounter: _incrementCounter,
      child: Navigator(
        initialRoute: '/',
        onGenerateRoute: (settings) {
          Widget page;
          switch (settings.name) {
            case '/':
              page = const CounterHomePage();
              break;
            case '/detail':
              page = const CounterDetailPage();
              break;
            default:
              page = const CounterHomePage();
          }
          return MaterialPageRoute(builder: (context) => page);
        },
      ),
    );
  }
}   