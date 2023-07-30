import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/controllers/results_controller.dart';
import 'package:frontend/models/bar_chart.dart';
import 'package:frontend/widgets/drop_down.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

double roundToNextHighest50000(double number) {
  return (number / 50000).ceilToDouble() * 50000;
}

class ResultsViewer extends HookConsumerWidget {
  final List<String> fieldNames = [
    "Experience Level",
    "Employment Type",
    "Company Size",
  ];
  final int predictedSalary;
  // final String jobTitle;

  ResultsViewer({super.key, required this.predictedSalary});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // widget needs to access csv data (other widgets may as well)
    //  and initialize by displaying salaries given different job titles
    final selectedField = useState(fieldNames[0]);
    final jobTitle = ref.watch(jobTitleProvider);

    final barChartData = ref.watch(avgSalaryBarChartState);

    useEffect(() {
      ref.read(resultsController).initState();
      return ref.read(resultsController).dispose;
    }, []);

    return Column(
      children: [
        Text("Your estimated salary as a $jobTitle is"),
        const SizedBox(
          height: 8,
        ),
        Text(
          predictedSalary.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$jobTitle Average Salary By"),
            const SizedBox(width: 5),
            SizedBox(
              width: 200,
              child: DropDown(
                items: fieldNames,
                onChanged: (newValue) {
                  ref.read(resultsController).updateGraph(newValue as String);
                  selectedField.value = newValue;
                },
                value: selectedField.value,
              ),
            ),
          ],
        ),
        SizedBox(
          // width: 500,
          height: 500,
          child: barChartData != null
              ? BarChart(
                  BarChartData(
                    maxY: roundToNextHighest50000(barChartData.salaries
                        .fold<double>(0.0, (prev, curr) => prev > curr ? prev : curr)),
                    borderData: FlBorderData(
                      border: const Border(
                        left: BorderSide(width: 0.5),
                        bottom: BorderSide(),
                      ),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                        axisNameWidget: Text("Salary"),
                        sideTitles: SideTitles(reservedSize: 44, showTitles: true, interval: 50000),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 30,
                          showTitles: true,
                          getTitlesWidget: (value, meta) => SideTitleWidget(
                            axisSide: AxisSide.bottom,
                            space: 0.0,
                            child: Text(
                              barChartData.categories[value as int],
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ),
                      rightTitles: const AxisTitles(),
                      topTitles: const AxisTitles(),
                    ),
                    gridData: FlGridData(
                      checkToShowHorizontalLine: (value) => value % 50000 == 0,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) =>
                          FlLine(strokeWidth: 1, color: Colors.blue[50]!),
                    ),
                    barGroups: List.generate(
                      barChartData.salaries.length,
                      (index) => BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            width: 20.0,
                            toY: barChartData.salaries[index],
                          ),
                        ],
                      ),
                    ),
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 150),
                  swapAnimationCurve: Curves.linear,
                )
              : const SpinKitDoubleBounce(
                  color: Colors.blue,
                ),
        ),
        ElevatedButton(
          onPressed: ref.read(resultsController).dispose,
          child: const Text("Create another estimate"),
        ),
      ],
    );
  }
}
