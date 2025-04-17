import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.validator,
    this.onFieldSubmitted,
    this.onTap,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}