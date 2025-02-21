import 'package:flutter/material.dart';
import 'package:transact_pay_sdk/src/constant/app_colors.dart';

class AppCardTypeSelection extends StatelessWidget {
  final String cardType;
  final String pan;
  final String imageUrl;
  final Color selectionColor; // Color for selection
  final TextStyle cardTypeStyle;
  final TextStyle panStyle;
  final bool isSelected;
  final ValueChanged<bool> onChanged; // Callback when selection changes

  const AppCardTypeSelection({
    super.key,
    required this.cardType,
    required this.pan,
    required this.imageUrl,
    this.selectionColor = AppColors.primaryColor,
    this.cardTypeStyle = const TextStyle(fontSize: 14.0),
    this.panStyle =
        const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    this.isSelected = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = isSelected ? selectionColor : Colors.grey;
    Color backgroundColor =
        isSelected ? selectionColor.withOpacity(0.2) : Colors.transparent;

    return GestureDetector(
      onTap: () {
        onChanged(!isSelected); // Trigger onChanged to update the selection
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: borderColor, width: 2.0),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            Image.asset(
              imageUrl,
              width: 60,
            ),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardType,
                  style: cardTypeStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pan,
                  style: panStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Radio<bool>(
              value: true,
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
