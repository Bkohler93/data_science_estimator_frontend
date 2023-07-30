import 'package:flutter/material.dart';
import 'package:frontend/controllers/home_controller.dart';
import 'package:frontend/widgets/results_viewer.dart';
import 'package:frontend/widgets/estimation_tool.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var predictionState = ref.watch(predictedSalaryProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "SalarySight",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 100.w > 500 ? 500 : 100.w,
          child: predictionState == null
              ? const EstimationTool()
              : ResultsViewer(
                  predictedSalary: predictionState.predictedSalary,
                ),
        ),
      ),
    );
  }
}
