import 'dart:isolate';

import 'package:flutter/material.dart';

// Serializable data class to pass to the isolate
class IsolateData {
  final int computationSize;
  final SendPort sendPort;

  IsolateData(this.computationSize, this.sendPort);
}

// Message class to handle different types of messages from isolate
class IsolateMessage {
  final String type; // 'progress' or 'result'
  final dynamic data;

  IsolateMessage(this.type, this.data);
}

class IsolateHome extends StatefulWidget {
  const IsolateHome({super.key});

  @override
  State<IsolateHome> createState() => _IsolateHomeState();
}

class _IsolateHomeState extends State<IsolateHome> {
  double _progress = 0.0;
  String _result = '';
  bool _isComputing = false;
  Isolate? _isolate;
  ReceivePort? _receivePort;

  @override
  void dispose() {
    _isolate?.kill();
    _receivePort?.close();
    super.dispose();
  }

  Future<void> _startComputation(int size) async {
    if (_isComputing) return;

    setState(() {
      _isComputing = true;
      _progress = 0.0;
      _result = '';
    });

    // Create a ReceivePort to get messages from the isolate
    _receivePort = ReceivePort();

    // Create a data object to send to the isolate
    final isolateData = IsolateData(size, _receivePort!.sendPort);

    // Spawn an isolate to perform the computation
    _isolate = await Isolate.spawn(performHeavyComputation, isolateData);

    // Listen for messages from the isolate
    _receivePort!.listen((message) {
      if (message is IsolateMessage) {
        setState(() {
          if (message.type == 'progress') {
            _progress = message.data;
          } else if (message.type == 'result') {
            _result = 'Final sum: ${message.data}';
            _isComputing = false;
          }
        });
      }
    });
  }

  // This function runs in the isolate
  static void performHeavyComputation(IsolateData data) {
    int sum = 0;
    final int totalNumbers = data.computationSize;
    
    // Perform computation with progress updates
    for (int i = 0; i < totalNumbers; i++) {
      sum += i;
      
      // Send progress updates every 5% or so
      if (i % (totalNumbers ~/ 20) == 0) {
        final progress = i / totalNumbers;
        data.sendPort.send(IsolateMessage('progress', progress));
      }
      
      // Simulate some extra work to make the computation visible
      if (i % 10000 == 0) {
        Future.delayed(const Duration(microseconds: 1));
      }
    }

    // Send the final result
    data.sendPort.send(IsolateMessage('result', sum));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Isolate Example'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Heavy Computation Example',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 32),
            if (_isComputing) ...[
              LinearProgressIndicator(value: _progress),
              const SizedBox(height: 16),
              Text('Progress: ${(_progress * 100).toStringAsFixed(1)}%'),
            ],
            const SizedBox(height: 32),
            if (_result.isNotEmpty)
              Text(
                _result,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isComputing
                      ? null
                      : () => _startComputation(1000000),
                  child: const Text('Small Computation'),
                ),
                ElevatedButton(
                  onPressed: _isComputing
                      ? null
                      : () => _startComputation(100000000),
                  child: const Text('Large Computation'),
                ),
              ],
            ),
            if (_isComputing) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _isolate?.kill();
                  setState(() {
                    _isComputing = false;
                    _progress = 0.0;
                    _result = 'Computation cancelled';
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Cancel Computation'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}