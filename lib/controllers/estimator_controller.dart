import 'package:frontend/api.dart';
import 'package:frontend/controllers/home_controller.dart';
import 'package:frontend/controllers/results_controller.dart';
import 'package:frontend/models/prediction.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final attributeNameProvider = FutureProvider((ref) async {
  return ref.read(repositoryProvider).getAttributeNames();
});

final estimatorController = Provider.autoDispose((ref) => EstimatorController(ref));

class EstimatorController {
  EstimatorController(this._ref);
  final Ref _ref;

  //TODO move into HomePageController
  void restart() {
    // delete any state that needs to be cleared.
    _ref.read(predictedSalaryProvider.notifier).state = null;
  }

  void makePrediction({
    required String experience,
    required String employment,
    required String jobTitle,
    required String residence,
    required String location,
    required String size,
  }) async {
    _ref.read(resultsController).setJobTitle(jobTitle);
    int predictedSalary = await _ref.read(repositoryProvider).getSalaryPrediction(
        PredictionData(experience, employment, jobTitle, residence, location, size, 2023));
    _ref.read(homeController).setPredictionState(predictedSalary, jobTitle);
  }
}
