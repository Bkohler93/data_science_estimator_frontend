// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PredictionData {
  final String experienceLevel;
  final String employmentType;
  final String jobTitle;
  final String employeeResidence;
  final String companyLocation;
  final String companySize;
  final int workYear;

  PredictionData(
    this.experienceLevel,
    this.employmentType,
    this.jobTitle,
    this.employeeResidence,
    this.companyLocation,
    this.companySize,
    this.workYear,
  );

  PredictionData copyWith({
    String? experienceLevel,
    String? employmentType,
    String? jobTitle,
    String? employeeResidence,
    String? companyLocation,
    String? remote,
    String? companySize,
    int? workYear,
  }) {
    return PredictionData(
      experienceLevel ?? this.experienceLevel,
      employmentType ?? this.employmentType,
      jobTitle ?? this.jobTitle,
      employeeResidence ?? this.employeeResidence,
      companyLocation ?? this.companyLocation,
      companySize ?? this.companySize,
      workYear ?? this.workYear,
    );
  }

  List<dynamic> toParams() {
    String experienceLevel = switch (this.experienceLevel) {
      "Entry" => "EN",
      "Intermediate" => "MI",
      "Senior" => "SE",
      "Executive" => "EX",
      _ => throw Exception("Invalid value for 'experienceLevel': ${this.experienceLevel}")
    };

    String employmentType = switch (this.employmentType) {
      "Freelance" => "FL",
      "Full-time" => "FT",
      "Part-time" => "PT",
      "Contract" => "CT",
      _ => throw Exception("Invalid value used for 'employment_type': ${this.employmentType}"),
    };

    String jobTitle = this.jobTitle;
    String employeeResidence = this.employeeResidence;

    String companyLocation = this.companyLocation;
    String companySize = switch (this.companySize) {
      "Small" => "S",
      "Medium" => "M",
      "Large" => "L",
      _ => throw Exception("Invalid value used for 'company_location': ${this.companySize}"),
    };
    int workYear = 2023;
    return [
      experienceLevel,
      employmentType,
      jobTitle,
      employeeResidence,
      companyLocation,
      companySize,
      workYear
    ];
  }

  factory PredictionData.fromMap(Map<String, dynamic> map) {
    return PredictionData(
      map['experienceLevel'] as String,
      map['employmentType'] as String,
      map['jobTitle'] as String,
      map['employeeResidence'] as String,
      map['companyLocation'] as String,
      map['companySize'] as String,
      map['workYear'] as int,
    );
  }

  factory PredictionData.fromJson(String source) =>
      PredictionData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PredictionData(experienceLevel: $experienceLevel, employmentType: $employmentType, jobTitle: $jobTitle, employeeResidence: $employeeResidence, companyLocation: $companyLocation,  companySize: $companySize, workYear: $workYear)';
  }

  @override
  bool operator ==(covariant PredictionData other) {
    if (identical(this, other)) return true;

    return other.experienceLevel == experienceLevel &&
        other.employmentType == employmentType &&
        other.jobTitle == jobTitle &&
        other.employeeResidence == employeeResidence &&
        other.companyLocation == companyLocation &&
        other.companySize == companySize &&
        other.workYear == workYear;
  }

  @override
  int get hashCode {
    return experienceLevel.hashCode ^
        employmentType.hashCode ^
        jobTitle.hashCode ^
        employeeResidence.hashCode ^
        companyLocation.hashCode ^
        companySize.hashCode ^
        workYear.hashCode;
  }

  List<dynamic> toParamList() {
    return [
      experienceLevel,
      employmentType,
      jobTitle,
      employeeResidence,
      companyLocation,
      companySize,
      workYear
    ];
  }
}
