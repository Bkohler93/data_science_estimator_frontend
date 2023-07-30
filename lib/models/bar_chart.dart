// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final avgSalaryBarChartState = StateProvider<AvgSalaryBarChartData?>((ref) {
  return null;
});

class AvgSalaryBarChartData {
  final String fieldName;
  final String jobTitle;
  late final List<String> categories;
  final List<double> salaries;

  AvgSalaryBarChartData(
    this.fieldName,
    this.categories,
    this.salaries,
    this.jobTitle,
  );

  AvgSalaryBarChartData copyWith({
    String? fieldName,
    String? jobTitle,
    List<String>? categories,
    List<double>? salaries,
  }) {
    return AvgSalaryBarChartData(
      fieldName ?? this.fieldName,
      categories ?? this.categories,
      salaries ?? this.salaries,
      jobTitle ?? this.jobTitle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fieldName': fieldName,
      'categories': categories,
      'salaries': salaries,
    };
  }

  factory AvgSalaryBarChartData.fromMap(Map<String, dynamic> map) {
    return AvgSalaryBarChartData(
      map['fieldName'] as String,
      List<String>.from(map['categories'] as List<String>),
      List<double>.from(map['salaries'] as List<double>),
      map['jobTitle'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AvgSalaryBarChartData.fromJson(String source) =>
      AvgSalaryBarChartData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AvgSalaryBarChartData(fieldName: $fieldName, categories: $categories, salaries: $salaries)';

  @override
  bool operator ==(covariant AvgSalaryBarChartData other) {
    if (identical(this, other)) return true;

    return other.fieldName == fieldName &&
        listEquals(other.categories, categories) &&
        listEquals(other.salaries, salaries);
  }

  @override
  int get hashCode => fieldName.hashCode ^ categories.hashCode ^ salaries.hashCode;
}
