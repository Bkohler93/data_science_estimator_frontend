// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AttributeNames {
  final List<String> experienceLevels;
  final List<String> employmentTypes;
  final List<String> jobTitles;
  final List<String> employeeResidences;
  final List<String> companyLocations;
  final List<String> companySizes;

  AttributeNames(
    this.experienceLevels,
    this.employmentTypes,
    this.jobTitles,
    this.employeeResidences,
    this.companyLocations,
    this.companySizes,
  );

  AttributeNames copyWith({
    List<String>? experienceLevels,
    List<String>? employmentTypes,
    List<String>? jobTitles,
    List<String>? employeeResidences,
    List<String>? companyLocations,
    List<String>? companySizes,
  }) {
    return AttributeNames(
      experienceLevels ?? this.experienceLevels,
      employmentTypes ?? this.employmentTypes,
      jobTitles ?? this.jobTitles,
      employeeResidences ?? this.employeeResidences,
      companyLocations ?? this.companyLocations,
      companySizes ?? this.companySizes,
    );
  }

  factory AttributeNames.fromMap(Map<String, dynamic> map) {
    return AttributeNames(
      List<String>.from((map['experience_level'].map((s) => s.toString()))),
      List<String>.from((map['employment_type'].map((s) => s.toString()))),
      List<String>.from((map['job_title'].map((s) => s.toString()))),
      List<String>.from((map['employee_residence'].map((s) => s.toString()))),
      List<String>.from((map['company_location'].map((s) => s.toString()))),
      List<String>.from((map['company_size'].map((s) => s.toString()))),
    );
  }

  factory AttributeNames.fromJson(String source) =>
      AttributeNames.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AttributeNames(experienceLevels: $experienceLevels, employmentTypes: $employmentTypes, jobTitles: $jobTitles, employeeResidences: $employeeResidences, companyLocations: $companyLocations,  companySizes: $companySizes)';
  }

  @override
  bool operator ==(covariant AttributeNames other) {
    if (identical(this, other)) return true;

    return listEquals(other.experienceLevels, experienceLevels) &&
        listEquals(other.employmentTypes, employmentTypes) &&
        listEquals(other.jobTitles, jobTitles) &&
        listEquals(other.employeeResidences, employeeResidences) &&
        listEquals(other.companyLocations, companyLocations) &&
        listEquals(other.companySizes, companySizes);
  }

  @override
  int get hashCode {
    return experienceLevels.hashCode ^
        employmentTypes.hashCode ^
        jobTitles.hashCode ^
        employeeResidences.hashCode ^
        companyLocations.hashCode ^
        companySizes.hashCode;
  }
}
