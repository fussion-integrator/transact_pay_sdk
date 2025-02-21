import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MoneyInputFormatter extends TextInputFormatter {
  // Formatter for Nigerian Naira
  final NumberFormat _currencyFormat =
      NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 0);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Only handle the input if it's a number (remove commas and symbols)
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.isNotEmpty) {
      // Parse the value and format it as currency
      final parsedValue = double.tryParse(newText);
      if (parsedValue != null) {
        newText =
            _currencyFormat.format(parsedValue).replaceAll('₦', '').trim();
      }
    }

    // Ensure the cursor stays in the right place
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

double unformatMoney(String input) {
  try {
    // Remove currency symbol (e.g. NGN, $, €) and commas
    String unformatted = input.replaceAll(RegExp(r'[^\d.]'), '');

    // Attempt to parse the value into a double
    double value = double.parse(unformatted);
    return value;
  } catch (e) {
    // If there is an error (e.g., invalid input), return 0.0 or handle it as needed
    debugPrint("Error parsing input: $e");
    return 0.0; // You could also throw an exception or return another value
  }
}

String formatMoney(dynamic amount,
    {String currencySymbol = '', int decimalPlaces = 2}) {
  if (amount == null) return "0.00"; // Handle null values

  try {
    if (amount is String) {
      amount = num.tryParse(amount) ?? amount;
    }

    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: currencySymbol,
      decimalDigits: decimalPlaces,
    );

    return formatter.format(amount);
  } catch (e) {
    return amount.toString(); // Return the original value if formatting fails
  }
}
