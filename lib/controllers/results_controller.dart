import 'package:frontend/api.dart';
import 'package:frontend/controllers/estimator_controller.dart';
import 'package:frontend/models/bar_chart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final resultsController = Provider.autoDispose((ref) => ResultsController(ref));

final jobTitleProvider = StateProvider<String?>((ref) => null);

class ResultsController {
  ResultsController(this._ref);
  final Ref _ref;

  void setJobTitle(String jobTitle) {
    _ref.read(jobTitleProvider.notifier).state = jobTitle;
  }

  void dispose() {
    // delete any state that needs to be cleared.
    _ref.read(avgSalaryBarChartState.notifier).state = null;
    _ref.read(estimatorController).restart();
  }

  void initState() async {
    var jobTitle = _ref.watch(jobTitleProvider);
    _ref.read(avgSalaryBarChartState.notifier).state =
        await _ref.read(repositoryProvider).getAvgSalaryData("Experience Level", jobTitle!);
  }

  void updateGraph(String fieldName) async {
    var jobTitle = _ref.watch(jobTitleProvider);
    _ref.read(avgSalaryBarChartState.notifier).state =
        await _ref.read(repositoryProvider).getAvgSalaryData(fieldName, jobTitle!);
  }
}
