import 'package:flutter/material.dart';

import '../model/breed.model.dart';
import '../utils/theme.utils.dart';

class SelecWidget extends StatelessWidget {
  final String title;
  final List<dynamic>? items;
  final String? hint;
  final Function(dynamic)? action;
  final String? defaultValue;

  const SelecWidget({
    Key? key,
    required this.title,
    this.items,
    this.action,
    this.hint,
    this.defaultValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
            child: Text(
              title,
              style: TextStyle(
                color: ThemeUtils.getThemeTitle(),
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          DropdownButtonFormField<String>(
            isExpanded: true,
            borderRadius: BorderRadius.circular(8),
            icon: const Icon(Icons.arrow_drop_down),
            iconEnabledColor: ThemeUtils.getTheme(),
            dropdownColor: ThemeUtils.getBackGround(),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ThemeUtils.getTheme()),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ThemeUtils.getTheme()),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ThemeUtils.getTheme()),
              ),
              fillColor: ThemeUtils.getThemeBackground(),
              filled: true,
            ),
            onChanged: action,
            value: defaultValue != null ? defaultValue! : null,
            items: items != null && items!.isNotEmpty
                ? items!.map((value) {
                    return DropdownMenuItem<String>(
                      value: value is BreedModel ? value.breed : value,
                      child: Text(
                        value is BreedModel ? value.breed : value,
                      ),
                    );
                  }).toList()
                : <DropdownMenuItem<String>>[],
            hint: items != null && items!.isNotEmpty ? Text(hint!) : null,
          ),
        ],
      ),
    );
  }
}
