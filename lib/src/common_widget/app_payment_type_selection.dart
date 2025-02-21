import 'package:flutter/material.dart';
import 'package:transact_pay_sdk/src/constant/app_colors.dart';

class AppPaymentTypeSelection extends StatelessWidget {
  final String text;
  final String imageUrl;
  final Color selectionColor; // Color for selection
  final TextStyle textStyle;
  final bool isSelected;
  final ValueChanged<bool> onChanged; // Callback when selection changes

  const AppPaymentTypeSelection({
    super.key,
    required this.text,
    required this.imageUrl,
    this.selectionColor = AppColors.primaryColor,
    this.textStyle = const TextStyle(fontSize: 16.0),
    this.isSelected = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = isSelected ? selectionColor : Colors.grey;
    Color backgroundColor =
        isSelected ? selectionColor.withValues(alpha: 0.2) : Colors.transparent;

    return GestureDetector(
      onTap: () {
        onChanged(!isSelected); // Trigger onChanged to update the selection
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: borderColor, width: 2.0),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundColor: AppColors.primaryColor,
              child: Image.asset(
                imageUrl,
                package: "transact_pay_sdk",
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                text,
                style: textStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Radio<bool>(
              value: true,
              activeColor: selectionColor,
              groupValue: isSelected, // Radio is selected if isSelected is true
              onChanged: (bool? value) {
                onChanged(value ?? false); // Update the selection state
              },
            ),
          ],
        ),
      ),
    );
  }
}
