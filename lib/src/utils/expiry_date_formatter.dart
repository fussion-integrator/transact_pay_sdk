import 'package:flutter/services.dart';

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    // Remove any non-digit characters
    text = text.replaceAll(RegExp(r'\D'), '');

    // Ensure the text length doesn't exceed 4 digits (MMYY format)
    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    // Format the text as MM/YY
    StringBuffer formattedText = StringBuffer();
    if (text.length > 2) {
      formattedText.write(text.substring(0, 2));
      formattedText.write('/');
      formattedText.write(text.substring(2));
    } else {
      formattedText.write(text);
    }

    // Return the formatted text with proper cursor positioning
    return newValue.copyWith(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
