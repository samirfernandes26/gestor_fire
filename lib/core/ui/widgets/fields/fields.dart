import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

Widget checkSingle(
  BuildContext context, {
  required String name,
  required String label,
  required Widget title,
  bool? isRequired,
  String? Function(bool?)? validator,
  bool enabled = true,
  void Function(bool?)? onChanged,
  bool? initialValue,
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
        FormBuilderSwitch(
          title: title,
          activeColor: Colors.green,
          activeTrackColor: Colors.green.shade800,
          name: name,
          enabled: enabled,
          decoration: const InputDecoration(
            // fillColor: Colors.transparent,
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          initialValue: initialValue,
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    ),
  );
}

Widget textField<T>(
  BuildContext context, {
  required String name,
  required String label,
  String? hintText,
  bool? isRequired,
  Widget? secondary,
  String? Function(String?)? validator,
  List<TextInputFormatter>? inputFormatters,
  T Function(String?)? valueTransformer,
  TextInputType? keyboardType,
  void Function(String?)? onChanged,
  int? maxLength,
  String? initialValue,
  bool? readOnly,
  bool enabled = true,
  int? minLines,
  int? maxLines,
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
        FormBuilderTextField(
          name: name,
          enabled: enabled,
          readOnly: readOnly ?? false,
          keyboardType: keyboardType,
          // onTapOutside: (_) => context.unfocus(),
          onChanged: onChanged,
          initialValue: initialValue,
          valueTransformer: valueTransformer,
          decoration: InputDecoration(hintText: hintText ?? label),
          validator: validator,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          minLines: minLines,
          maxLines: maxLines,
        ),
        if (secondary != null) secondary,
      ],
    ),
  );
}
