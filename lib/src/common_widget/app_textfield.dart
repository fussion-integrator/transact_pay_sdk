import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChange;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final double borderRadius;
  final Color textColor;
  final Color backgroundColor;
  final Widget? suffix;
  final Widget? prefix;
  final int maxLines;
  final String hintText;
  final TextStyle hintTextStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle textStyle;
  final bool obscureText;
  final bool isEnabled;
  final List<TextInputFormatter> inputFormatters;

  const AppTextField({
    super.key,
    this.controller,
    this.onChange,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.borderRadius = 8.0,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.suffix,
    this.prefix,
    this.maxLines = 1,
    required this.hintText,
    this.hintTextStyle = const TextStyle(color: Colors.grey),
    this.labelText,
    this.labelStyle,
    this.textStyle = const TextStyle(),
    this.obscureText = false,
    this.isEnabled = true,
    this.inputFormatters = const [],
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChange,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      enabled: isEnabled,
      style: textStyle.copyWith(color: textColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintTextStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        filled: backgroundColor != Colors.transparent,
        fillColor: backgroundColor,
        prefixIcon: prefix,
        suffixIcon: suffix,
        contentPadding: EdgeInsets.only(top: 20, left: 10, right: 5),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.1),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
