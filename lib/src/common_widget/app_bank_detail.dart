import 'package:flutter/material.dart';
import 'package:transact_pay_sdk/src/constant/app_colors.dart';

class AppBankDetail extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final String? infoText;
  final TextStyle? infoTextStyle;
  final String subtitle;
  final TextStyle? subtitleStyle;
  final Icon icon;
  final VoidCallback? onIconTap;

  const AppBankDetail({
    super.key,
    this.title = "Default Title",
    this.titleStyle = const TextStyle(fontSize: 14.0, color: Colors.black),
    this.infoText,
    this.infoTextStyle =
        const TextStyle(fontSize: 12.0, color: AppColors.primaryColor),
    this.subtitle = "Default Subtitle",
    this.subtitleStyle =
        const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    this.icon =
        const Icon(Icons.copy, size: 20.0, color: AppColors.primaryColor),
    this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: titleStyle,
              ),
              if (infoText != null)
                Text(
                  infoText!,
                  style: infoTextStyle,
                ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                subtitle,
                style: subtitleStyle,
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  if (onIconTap != null) {
                    onIconTap!();
                  }
                },
                child: icon,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
