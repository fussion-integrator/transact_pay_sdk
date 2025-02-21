import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppHelper {
  /// Copies the given [text] to the clipboard and optionally shows a confirmation [message].
  static Future<void> copyToClipboard(String text, {String? message}) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      if (message != null) {
        // Optionally show confirmation, e.g., using a Snackbar
        Get.snackbar("", message); // Replace with a UI notification if needed
      }
    } catch (e) {
      debugPrint("Failed to copy to clipboard: $e");
    }
  }

  /// Retrieves the current text from the clipboard.
  static Future<String?> getClipboardText() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      return clipboardData?.text;
    } catch (e) {
      debugPrint("Failed to get clipboard text: $e");
      return null;
    }
  }
}
