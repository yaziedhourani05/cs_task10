import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.onSaved,
    this.onChanged,
    required this.labelText,
    this.initialValue,
    this.controller,
    this.onTap,
    this.readOnly,
    this.customWidth,
    this.validator,
    this.maxLength,
    this.keyboardType,
    this.obsecureText,
  }) : super(key: key);
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final TextEditingController? controller;
  final String labelText;
  final bool? obsecureText;
  final String? initialValue;
  final double? customWidth;
  final Function()? onTap;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
      child: Container(
        width: customWidth ?? 200,
        child: TextFormField(
          controller: controller,
          onSaved: onSaved,
          onChanged: onChanged,
          validator: validator,
          initialValue: initialValue,
          obscureText: obsecureText ?? false,
          maxLength: maxLength,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: labelText,
            floatingLabelStyle: const TextStyle(color: Colors.orange),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.0, color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 1.5, color: Colors.red),
            ),
          ),
          onTap: onTap,
          readOnly: readOnly ?? false,
        ),
      ),
    );
  }
}
