// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/attribute_names.dart';

import 'package:frontend/models/bar_chart.dart';
import 'package:frontend/models/prediction.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

String baseUrl = switch (kEnvironment) {
  "development" => "http://127.0.0.1:5000",
  "production" => "https://brettkohler93.pythonanywhere.com",
  _ => throw Exception("Invalid argument for 'environment' flag")
};

final dioProvider = Provider((ref) => Dio());
final repositoryProvider = Provider((ref) => ApiRepository(ref));

extension ApiStringExtension on String {
  String toApiString() => switch (this) {
        "Job Title" => "job_title",
        "Experience Level" => "experience_level",
        "Company Size" => "company_size",
        "Company Location" => "company_location",
        "Employee Residence" => "employee_residence",
        "Employment Type" => "employment_type",
        _ => ""
      };
}

class ApiRepository {
  ApiRepository(this._ref);
  final Ref _ref;
  // store dataset here
  Future<AvgSalaryBarChartData> getAvgSalaryData(String fieldName, String jobTitle) async {
    final formattedFieldName = fieldName.toApiString();
    List<String> categories = [];
    List<double> salaries = [];

    final request =
        Uri.encodeFull("$baseUrl/avg_salary_data?field=$formattedFieldName&job_title=$jobTitle");
    final response = await _ref.read(dioProvider).get(request);
    final rows = jsonDecode(response.data);
    for (var row in rows) {
      categories.add(row[formattedFieldName]);
      salaries.add(row["salary"]);
    }

    return AvgSalaryBarChartData(fieldName, categories, salaries, jobTitle);
  }

  Future<int> getSalaryPrediction(PredictionData predictionData) async {
    // translate fields into data acceptable by API
    var [
      experienceLevel,
      employmentType,
      jobTitle,
      employeeResidence,
      companyLocation,
      companySize,
      workYear
    ] = predictionData.toParamList();
    final request = Uri.encodeFull(
        "$baseUrl/predict?experience_level=$experienceLevel&employment_type=$employmentType&job_title=$jobTitle&employee_residence=$employeeResidence&company_location=$companyLocation&company_size=$companySize&work_year=$workYear");
    final response = await _ref.read(dioProvider).get(request);

    // return value
    final prediction = response.data["result"];
    return prediction.floor();
  }

  Future<AttributeNames> getAttributeNames() async {
    final request = Uri.encodeFull("$baseUrl/attribute_names");
    final response = await _ref.read(dioProvider).get(request);
    var attributeData = jsonDecode(response.data);
    return AttributeNames.fromMap(attributeData);
  }
}
