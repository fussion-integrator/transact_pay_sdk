import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:transact_pay_sdk/src/common_widget/app_button.dart';
import 'package:transact_pay_sdk/src/common_widget/app_countdown_timer.dart';
import 'package:transact_pay_sdk/src/config/api_endpoints.dart';
import 'package:transact_pay_sdk/src/config/transact_pay_request.dart';
import 'package:transact_pay_sdk/src/constant/app_colors.dart';
import 'package:transact_pay_sdk/src/constant/app_images.dart';
import 'package:transact_pay_sdk/src/models/verify_order_response_model.dart';
import 'package:transact_pay_sdk/transact_pay_sdk.dart';
import 'package:transact_pay/services/encryption_service.dart';
import 'package:http/http.dart' as http;

class BankTransferProgressPopup extends StatefulWidget {
  final String orderReference;
  const BankTransferProgressPopup({super.key, required this.orderReference});

  @override
  State<BankTransferProgressPopup> createState() =>
      _BankTransferProgressPopupState();
}

class _BankTransferProgressPopupState extends State<BankTransferProgressPopup> {
  int currentStep = 0;
  bool isWaiting = false;
  late TransactPay transactPay;
  final EncryptionService encryptionService =
      EncryptionService(encryptionKey: encryptionKey);

  @override
  void initState() {
    super.initState();
    transactPay = TransactPay(apiKey: apiKey, encryptionKey: encryptionKey);
    verifyBankTransferOrder();
  }

  Future<void> verifyBankTransferOrder() async {
    //String bodyString = json.encode(payload);

    // Encrypt the JSON string payload
    //Uint8List encryptedBody = encryptionService.encryptPayload(bodyString);
    //String encryptedBase64 = base64.encode(encryptedBody);

    // Define the request headers including the API key
    var headers = {
      'api-key': secretKey,
      'Content-Type': 'application/json',
    };

    try {
      // Create an HTTP request object using the specified method and endpoint
      var request = http.Request("POST", Uri.parse(ApiEndpoints.verifyOrder));
      request.headers.addAll(headers);
      //request.body = json.encode({"data": encryptedBase64});
      request.body = json.encode({"reference": widget.orderReference});

      // Send the request and get the response
      final http.StreamedResponse streamedResponse =
          await http.Client().send(request);
      final http.Response response =
          await http.Response.fromStream(streamedResponse);

      // Check response status
      if (response.statusCode == 200) {
        debugPrint("✅ Order Verified: ${response.body}");
        final responseJson = jsonDecode(response.body);

        // Optional: Parse the response into a model
        final verifyResponse = VerifyOrderResponseModel.fromJson(responseJson);
        print("dfjk3jkerk3ui4443k4jk43");
        print((verifyResponse.data!.statusId == 4));
        if (verifyResponse.data!.statusId == 4) {
          _showSnackbar(" ❌Transaction Order Failed", Colors.transparent);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => returnScreen),
            (route) => false,
          );
        } else if (verifyResponse.data!.statusId == 5) {
          _showSnackbar("Order verified successfully",
              Colors.grey.withValues(alpha: 0.5));
          setState(() {
            currentStep = 3;
          });
        } else if (verifyResponse.data!.statusId == 6) {
          _showSnackbar(
              "Transaction reveresed", Colors.grey.withValues(alpha: 0.5));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => returnScreen),
            (route) => false,
          );
        } else if (verifyResponse.data!.statusId == 2) {
          _showSnackbar(
              "Transaction pending", Colors.grey.withValues(alpha: 0.5));
          setState(() {
            currentStep = 2;
          });
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => returnScreen),
            (route) => false,
          );
        }
      } else {
        debugPrint("❌ Error: ${response.statusCode} - ${response.body}");
        _showSnackbar(" ❌Failed to verify order", Colors.transparent);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => returnScreen),
          (route) => false,
        );
      }
    } catch (e) {
      debugPrint("❌ Exception: $e");
      _showSnackbar("❌ An unexpected error occurred", Colors.red);
    }
  }

  // Helper function to show a snackbar
  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Visibility(
            visible: currentStep < 2,
            child: Column(
              children: [
                CircularProgressIndicator(
                  strokeWidth: 5,
                  color: AppColors.primaryColor,
                  strokeCap: StrokeCap.round,
                ),
                SizedBox(height: 20),
                Text(
                  "Checking Transaction Status",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: currentStep < 2,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "This may take up to ", // First text
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                        WidgetSpan(
                          child: AppCountdownTimer(
                            durationInSeconds: 20,
                            onRemainingTimeChanged: (value) {
                              if (value < 20 / 2 && !isWaiting) {
                                setState(() {
                                  currentStep = 1;
                                });
                              }
                            },
                            onCountdownFinished: () {
                              setState(() {
                                currentStep = 2;
                              });
                            },
                          ),
                        ),
                        TextSpan(
                          text: " minutes", // Final text
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: currentStep == 1,
                  child: Column(
                    children: [
                      Text(
                        "This is taking longer than expected. "
                        "Do you want to get notified when your "
                        "transaction is completed or continue waiting?",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 35,
                            width: 100,
                            child: AppButton(
                              text: "Wait",
                              textStyle:
                                  TextStyle(color: AppColors.primaryColor),
                              width: MediaQuery.of(context).size.width / 3,
                              backgroundColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  currentStep = 0;
                                  isWaiting = true;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            width: 120,
                            child: AppButton(
                              text: "Notify Me",
                              textStyle:
                                  TextStyle(fontSize: 13, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  currentStep = 2;
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: currentStep == 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.info,
                  package: "transact_pay_sdk",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Pending Payment",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Text(
                  "A mail will be sent to you once your transaction is confirmed.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 30),
                AppButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => returnScreen),
                      (route) => false,
                    );
                  },
                  text: "Close",
                ),
              ],
            ),
          ),
          Visibility(
            visible: currentStep == 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.completed,
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
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => returnScreen),
                        (route) => false,
                      );
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
          // SizedBox(height: 20),
          // AppConsentCheckbox(
          //   text: "Show Success Screen",
          //   //textStyle: TextStyle(fontSize: 16.0, color: Colors.blue),
          //   onChanged: () {
          //     setState(() {
          //       currentStep = 3;
          //     });
          //   },
          // ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
