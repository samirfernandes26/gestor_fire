import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

typedef InputOption<T> = ({T value, String description});

Widget radioGroup<T>(
  BuildContext context, {
  required String name,
  required String label,
  required List<InputOption<T>> options,
  bool? isRequired,
  String? Function(T?)? validator,
  bool enabled = true,
  void Function(T?)? onChanged,
  OptionsOrientation orientation = OptionsOrientation.vertical,
  T? initialValue,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label ${isRequired == true ? '*' : ''}',
          style: const TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        FormBuilderRadioGroup<T>(
          enabled: enabled,
          name: name,
          decoration: const InputDecoration(border: InputBorder.none),
          orientation: orientation,
          onChanged: onChanged,
          options:
              options
                  .map(
                    (option) => FormBuilderFieldOption(
                      value: option.value,
                      child: Text(option.description),
                    ),
                  )
                  .toList(),
          initialValue: initialValue,
          validator: validator,
        ),
      ],
    ),
  );
}
