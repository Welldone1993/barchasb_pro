import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? icon;
  final bool isPassword;
  final bool isNumber;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.icon,
    this.isPassword = false,
    this.isNumber = false,
    this.readOnly = false,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    obscureText: isPassword,
    readOnly: readOnly,
    onTap: onTap,
    keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    textAlign: TextAlign.right,
    textDirection: TextDirection.rtl,
    validator:
        validator ??
        (value) => (value == null || value.isEmpty)
            ? 'لطفا $hintText را وارد کنید'
            : null,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon),
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    ),
  );
}
