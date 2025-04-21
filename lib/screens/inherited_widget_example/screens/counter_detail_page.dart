import 'package:flutter/material.dart';

import '../state/counter_inherited_widget.dart';

class CounterDetailPage extends StatelessWidget {
  const CounterDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = CounterInheritedWidget.of(context);
    final counter = inheritedWidget?.counter ?? 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Detail Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Counter value in Detail:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: inheritedWidget?.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
} 