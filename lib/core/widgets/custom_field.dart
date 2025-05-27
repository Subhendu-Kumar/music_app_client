import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final bool readOnly;
  final String hintText;
  final bool isObscureText;
  final VoidCallback? onTap;
  final TextEditingController? controller;

  const CustomField({
    super.key,
    this.onTap,
    this.readOnly = false,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      validator: (val) {
        if (val!.trim().isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      obscureText: isObscureText,
    );
  }
}
