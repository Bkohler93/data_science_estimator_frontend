import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  const DropDown({
    super.key,
    required this.items,
    this.fieldName,
    required this.onChanged,
    required this.value,
  });

  /// List of names to select
  final List<String> items;

  /// The field name this dropdown is for. If not null will create a decoration to include this name on the button
  final String? fieldName;

  /// Runs every time a new value is selected from drop down
  final void Function(String?)? onChanged;

  /// Currently selected value, starts as null
  final String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      value: value,
      onChanged: onChanged,
      items: items.map((level) {
        return DropdownMenuItem<String>(
          value: level,
          child: Text(
            level,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
      buttonStyleData: const ButtonStyleData(
        height: 25,
        // width: 400,
      ),
      decoration: InputDecoration(
        labelText: fieldName,
      ),
    );
  }
}
