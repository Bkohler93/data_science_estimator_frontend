import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchableDropDown extends HookConsumerWidget {
  const SearchableDropDown({
    super.key,
    required this.items,
    required this.valueNotifier,
    required this.fieldName,
    required this.resetValidator,
  });

  final List<String> items;
  final ValueNotifier<String?> valueNotifier;
  final String fieldName;
  final Function resetValidator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();
    // TODO: implement build
    return DropdownButtonFormField2<String>(
      decoration: InputDecoration(
        labelText: fieldName,
      ),
      alignment: Alignment.centerLeft,
      isExpanded: true,
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      value: valueNotifier.value,
      onChanged: (value) {
        resetValidator();
        valueNotifier.value = value!;
      },
      buttonStyleData: const ButtonStyleData(
        height: 20,
        // width: 400,
      ),
      dropdownStyleData: const DropdownStyleData(
        maxHeight: 200,
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
      ),
      dropdownSearchData: DropdownSearchData(
        searchController: textEditingController,
        searchInnerWidgetHeight: 50,
        searchInnerWidget: Container(
          height: 50,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 4,
            right: 8,
            left: 8,
          ),
          child: TextFormField(
            expands: true,
            maxLines: null,
            controller: textEditingController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: 'Search for a $fieldName',
              hintStyle: const TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        searchMatchFn: (item, searchValue) {
          return item.value.toString().contains(searchValue);
        },
      ),
      //This to clear the search value when you close the menu
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          textEditingController.clear();
        }
      },
    );
  }
}
