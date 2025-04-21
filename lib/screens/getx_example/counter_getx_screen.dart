import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'counter_controller.dart';

class CounterGetXScreen extends StatelessWidget {
  const CounterGetXScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CounterController controller = Get.put(CounterController());
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.counterTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.reset,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.counterValue,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Obx(
              () => Text(
                '${controller.count}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'decrement',
                  onPressed: controller.decrement,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 24),
                FloatingActionButton(
                  heroTag: 'increment',
                  onPressed: controller.increment,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 