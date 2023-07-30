import 'package:hooks_riverpod/hooks_riverpod.dart';

final predictedSalaryProvider = StateProvider<PredictionState?>((ref) {
  return null;
});

final homeController = Provider.autoDispose(
  (ref) => HomeController(ref),
);

class HomeController {
  final Ref _ref;

  HomeController(this._ref);

  void setPredictionState(int predictedSalary, String jobTitle) {
    _ref.read(predictedSalaryProvider.notifier).state = PredictionState(
      predictedSalary,
      jobTitle,
    );
  }
}

class PredictionState {
  final int predictedSalary;
  final String jobTitle;

  PredictionState(this.predictedSalary, this.jobTitle);
}
