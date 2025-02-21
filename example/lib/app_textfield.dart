import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInputField extends StatefulWidget {
  final Widget? prefix;
  final Widget? suffixIcon;
  final String hintText;
  final TextStyle hintTextStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextEditingController controller;
  final TextStyle textStyle;
  final Color? backgroundColor;
  final bool obscureText;
  final String obscureTextValue;
  final void Function(String)? onChange;
  final bool isEnabled;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function()? onUnfocus;
  final void Function()? onfocus;
  final List<TextInputFormatter>? inputFormatters;
  final bool isTextArea;
  final bool isRequired;
  final bool showErrorInside; // NEW PROPERTY

  AppInputField({
    this.prefix,
    this.suffixIcon,
    required this.hintText,
    this.hintTextStyle =
        const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
    this.labelText,
    this.labelStyle = const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
    required this.controller,
    this.textStyle = const TextStyle(color: Colors.black),
    this.backgroundColor = Colors.white,
    this.obscureText = false,
    this.obscureTextValue = '',
    this.onChange,
    this.isEnabled = true,
    this.validator,
    this.keyboardType,
    this.onUnfocus,
    this.onfocus,
    this.inputFormatters,
    this.isTextArea = false,
    this.isRequired = false,
    this.showErrorInside = true, // Default to showing error inside
  });

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  late FocusNode _focusNode;
  bool _isValidated = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      if (widget.controller.text.isNotEmpty) {
        setState(() {
          _isValidated = true;
        });
      } else {
        setState(() {
          _isValidated = false;
        });
      }
    } else {
      setState(() {
        _isValidated = false;
      });
    }

    if (!_focusNode.hasFocus && widget.onUnfocus != null) {
      widget.onUnfocus!();
    } else if (widget.onfocus != null) {
      widget.onfocus!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? errorMessage = _isValidated && widget.validator != null
        ? widget.validator!(widget.controller.text)
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 1.0),
              child: Row(
                children: [
                  Text(
                    widget.labelText!,
                    style: widget.labelStyle,
                  ),
                  if (widget.isRequired)
                    Text(
                      ' *',
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                ],
              ),
            ),
          Container(
            height: widget.isTextArea ? null : 45,
            decoration: BoxDecoration(
              border: Border.all(
                color: errorMessage != null ? Colors.red : Colors.black38,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(8.0),
              color: widget.backgroundColor ?? Colors.grey.withOpacity(0.01),
            ),
            padding: EdgeInsets.only(left: 12.0),
            margin: EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                if (widget.prefix != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: widget.prefix,
                  ),
                Expanded(
                  child: TextFormField(
                    enabled: widget.isEnabled,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 1),
                      hintText: widget.hintText,
                      labelStyle: widget.labelStyle,
                      hintStyle: widget.hintTextStyle,
                      border: InputBorder.none,
                      // Show error inside the input if showErrorInside is true
                      errorText: widget.showErrorInside ? errorMessage : null,
                    ),
                    style: widget.textStyle,
                    controller: widget.controller,
                    focusNode: _focusNode,
                    obscureText: widget.obscureText,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _isValidated = false;
                        });
                      }
                      if (widget.onChange != null) widget.onChange!(value);
                    },
                    keyboardType: widget.keyboardType,
                    inputFormatters: widget.inputFormatters,
                    maxLines: widget.isTextArea ? null : 4,
                  ),
                ),
                if (widget.suffixIcon != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: widget.suffixIcon,
                  ),
              ],
            ),
          ),
          // Show error below the input if showErrorInside is false
          if (!widget.showErrorInside && errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
