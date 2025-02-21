import 'package:flutter/material.dart';
import 'package:transact_pay_sdk/src/common_widget/app_button.dart';
import 'package:transact_pay_sdk/src/common_widget/app_countdown_timer.dart';
import 'package:transact_pay_sdk/src/constant/app_colors.dart';
import 'package:transact_pay_sdk/src/constant/app_images.dart';

class CardPaymentProgressPopup extends StatefulWidget {
  const CardPaymentProgressPopup({super.key});

  @override
  State<CardPaymentProgressPopup> createState() =>
      _CardPaymentProgressPopupState();
}

class _CardPaymentProgressPopupState extends State<CardPaymentProgressPopup> {
  int currentStep = 0;
  bool isWaiting = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Visibility(
            visible: currentStep == 0,
            child: Column(
              children: [
                CircularProgressIndicator(
                  strokeWidth: 5,
                  color: AppColors.primaryColor,
                  strokeCap: StrokeCap.round,
                ),
                SizedBox(height: 20),
                Text(
                  "Loading Bank Services",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: currentStep < 2,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "This might take a while ", // First text
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                        WidgetSpan(
                          child: AppCountdownTimer(
                            durationInSeconds: 10,
                            onCountdownFinished: () {
                              setState(() {
                                currentStep = 1;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: currentStep == 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.completed,
                  package: "transact_pay_sdk",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Payment Completed",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: AppButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "Finish",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Center(
              child: Image.asset(AppImages.footer,
                  package: "transact_pay_sdk", width: 180)),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
