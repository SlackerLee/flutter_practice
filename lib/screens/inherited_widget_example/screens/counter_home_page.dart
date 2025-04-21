import 'package:flutter/material.dart';

import '../state/counter_inherited_widget.dart';

class CounterHomePage extends StatelessWidget {
  const CounterHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = CounterInheritedWidget.of(context);
    final counter = inheritedWidget?.counter ?? 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Inherited Widget Example'),
        leading: 
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, '/');
            },
          ),
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/detail');
              },
              child: const Text('Go to Detail Page'),
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