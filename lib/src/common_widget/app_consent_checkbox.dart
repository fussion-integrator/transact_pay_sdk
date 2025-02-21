import 'package:flutter/material.dart';

class AppConsentCheckbox extends StatefulWidget {
  final String text; // Text for the "I agree" message
  final TextStyle textStyle; // TextStyle for the text
  final VoidCallback? onChanged; // Callback when the checkbox is toggled

  const AppConsentCheckbox({
    super.key,
    this.text = "I agree to the terms and conditions", // Default text
    this.textStyle = const TextStyle(
        fontSize: 14.0, color: Colors.black), // Default text style
    this.onChanged, // Callback when checkbox is toggled
  });

  @override
  _AppConsentCheckboxState createState() => _AppConsentCheckboxState();
}

class _AppConsentCheckboxState extends State<AppConsentCheckbox> {
  bool _isAgreed = false; // Track the state of the checkbox

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _isAgreed,
          onChanged: (bool? value) {
            setState(() {
              _isAgreed = value ?? false; // Update checkbox state
            });
            if (widget.onChanged != null) {
              widget.onChanged!(); // Trigger the callback if it's provided
            }
          },
        ),
        Expanded(
          child: Text(
            widget.text,
            style: widget.textStyle, // Apply the parsed textStyle
          ),
        ),
      ],
    );
  }
}
