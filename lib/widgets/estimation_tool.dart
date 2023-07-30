import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/controllers/estimator_controller.dart';
import 'package:frontend/models/attribute_names.dart';
import 'package:frontend/widgets/drop_down.dart';
import 'package:frontend/widgets/searchable_drop_down.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EstimationTool extends HookConsumerWidget {
  const EstimationTool({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Fill out the form below and hit submit to receive an estimate on what you could be earning in the field of Data Science.",
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
            ),
          ),
          FormWidget(),
        ],
      ),
    );
  }
}

class FormWidget extends HookConsumerWidget {
  const FormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AttributeNames> attributeNames = ref.watch(attributeNameProvider);

    final experienceLevel = useState<String?>(null);
    final employmentType = useState<String?>(null);
    final jobTitle = useState<String?>(null);
    final employeeResidence = useState<String?>(null);
    final companyLocation = useState<String?>(null);
    final companySize = useState<String?>(null);
    final formIsInvalid = useState<bool>(false);

    void resetFormValidator() {
      formIsInvalid.value = false;
    }

    void handleSubmit() {
      // if (experienceLevel.value == null ||
      //     employmentType.value == null ||
      //     jobTitle.value == null ||
      //     employeeResidence.value == null ||
      //     companyLocation.value == null ||
      //     companySize.value == null) {
      //   formIsInvalid.value = true;
      //   return;
      // }

      // String experience = experienceLevel.value!;
      // String employment = employmentType.value!;
      // String job = jobTitle.value!;
      // String residence = employeeResidence.value!;
      // String location = companyLocation.value!;
      // String size = companySize.value!;

      // ref.read(estimatorController).makePrediction(
      //       experience: experience,
      //       employment: employment,
      //       jobTitle: job,
      //       residence: residence,
      //       location: location,
      //       size: size,
      //     );

      // //! Uncomment to autofill form on submit to skip to results_viewer with filled values
      ref.read(estimatorController).makePrediction(
          experience: "Senior",
          employment: "Full-Time",
          jobTitle: "Data Engineer",
          residence: "United States",
          location: "United States",
          size: "Medium");
    }

    return attributeNames.when(
        loading: () => const SpinKitChasingDots(
              color: Colors.blue,
            ),
        error: (obj, trace) => Text("Error $obj, $trace"),
        data: (data) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SearchableDropDown(
                    items: data.jobTitles,
                    valueNotifier: jobTitle,
                    fieldName: "Job Title",
                    resetValidator: resetFormValidator,
                  ),
                  const SizedBox(height: 16.0),
                  DropDown(
                    items: data.experienceLevels,
                    value: experienceLevel.value,
                    onChanged: (newValue) {
                      experienceLevel.value = newValue;
                    },
                    fieldName: "Experience Level",
                  ),
                  const SizedBox(height: 16.0),
                  DropDown(
                    items: data.employmentTypes,
                    value: employmentType.value,
                    onChanged: (newValue) {
                      employmentType.value = newValue;
                    },
                    fieldName: "Employment Type",
                  ),
                  const SizedBox(height: 16.0),
                  SearchableDropDown(
                    items: data.employeeResidences,
                    valueNotifier: employeeResidence,
                    fieldName: "Employee Residence (Country)",
                    resetValidator: resetFormValidator,
                  ),
                  const SizedBox(height: 16.0),
                  SearchableDropDown(
                    items: data.companyLocations,
                    valueNotifier: companyLocation,
                    fieldName: "Company Location (Country)",
                    resetValidator: resetFormValidator,
                  ),
                  const SizedBox(height: 16.0),
                  DropDown(
                      fieldName: "Company Size",
                      value: companySize.value,
                      onChanged: (newValue) {
                        companySize.value = newValue;
                      },
                      items: data.companySizes),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: handleSubmit,
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 20),
                  formIsInvalid.value
                      ? const Text("You must fill in all form fields before hitting submit")
                      : const Text(""),
                ],
              ),
            ));
  }
}
