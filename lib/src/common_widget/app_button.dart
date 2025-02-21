import 'package:flutter/material.dart';
import 'package:transact_pay_sdk/src/constant/app_colors.dart';

class AppButton extends StatelessWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final String text;
  final TextStyle textStyle;
  final Color foregroundColor;
  final double borderRadius;
  final VoidCallback? onPressed;
  final bool isEnabled; // New parameter with default value

  const AppButton({
    super.key,
    this.height = 50.0, // Default height
    this.width = double.infinity, // Default width takes all available space
    this.backgroundColor = AppColors.primaryColor, // Default background color
    required this.text, // Required parameter for text
    this.textStyle = const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white), // Default text style
    this.foregroundColor = Colors.white, // Default foreground color
    this.borderRadius = 8.0, // Default border radius
    this.onPressed, // Optional onPressed callback
    this.isEnabled = true, // Default is enabled
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed:
            isEnabled ? onPressed : null, // Disable button if not enabled
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? backgroundColor
              : AppColors.primaryColor.withOpacity(0.5), // Dim if disabled
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
        child: Text(
          text,
          style: textStyle.copyWith(
            color: isEnabled
                ? textStyle.color
                : Colors.grey, // Dim text if disabled
          ),
        ),
      ),
    );
  }
}
