import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:transact_pay_sdk/src/common_widget/app_button.dart';
import 'package:transact_pay_sdk/src/common_widget/app_consent_checkbox.dart';
import 'package:transact_pay_sdk/src/common_widget/app_field_label.dart';
import 'package:transact_pay_sdk/src/common_widget/app_header.dart';
import 'package:transact_pay_sdk/src/common_widget/app_textfield.dart';
import 'package:transact_pay_sdk/src/config/transact_pay_request.dart';
import 'package:transact_pay_sdk/src/constant/app_colors.dart';
import 'package:transact_pay_sdk/src/constant/app_images.dart';
import 'package:transact_pay_sdk/src/models/card_payment_response_model.dart';
import 'package:transact_pay_sdk/src/models/order_response_model.dart';
import 'package:transact_pay_sdk/src/ui/card_3ds_screen.dart';
import 'package:transact_pay_sdk/src/ui/popup_dialog/popup_exports.dart';
import 'package:transact_pay_sdk/src/ui/saved_card_payment_screen.dart';
import 'package:transact_pay_sdk/src/utils/credit_card_formatter.dart';
import 'package:transact_pay_sdk/src/utils/expiry_date_formatter.dart';
import 'package:transact_pay_sdk/src/utils/money_formatter.dart';
import 'package:transact_pay_sdk/src/utils/page_navigator/fading_page_navigator.dart';
import 'package:transact_pay_sdk/transact_pay_sdk.dart';

class CardPaymentScreen extends StatefulWidget {
  final OrderResponseModel order;
  final String fee;

  const CardPaymentScreen({super.key, required this.order, required this.fee});

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late TransactPay transactPay;

  @override
  void initState() {
    transactPay = TransactPay(apiKey: apiKey, encryptionKey: encryptionKey);
    super.initState();
  }

  bool isValid = false;

  void _validateForm() {
    setState(() {
      isValid = _formKey.currentState?.validate() ?? false;
    });
  }

  void processCardPayment() async {
    print(widget.order.data!.order!.currency ?? "no currency");
    if (widget.order.data?.order?.amount == null ||
        widget.order.data?.order?.currency == null) {
      print("⚠ Warning: Order amount or currency is null. Cannot proceed.");
      return;
    }

    List<int> parts =
        _expiryDateController.text.split('/').map((e) => int.parse(e)).toList();
    int month = parts[0], year = parts[1];

    final payload = {
      "reference": widget.order.data!.order!.reference,
      "paymentoption": "C",
      "country": widget.order.data!.customer!.country,
      "card": {
        "cardnumber": _cardNumberController.text,
        "expirymonth": month.toString(),
        "expiryyear": year.toString(),
        "cvv": _cvvController.text
      }
    };

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          const LoadingDialog(message: "Processing card transaction..."),
    );

    final response = await transactPay.payWithCard(payload);

    if (Navigator.canPop(context)) Navigator.pop(context); // Close dialog

    if (response.statusCode == 200) {
      debugPrint("✅ Fee Retrieved: ${response.body}");
      final responseJson = jsonDecode(response.body);
      final cardResponse = CardPaymentResponseModel.fromJson(responseJson);
      print(cardResponse.data!.paymentDetail!.redirectUrl!);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Card3DSScreen(
                  redirectUrl:
                      cardResponse.data!.paymentDetail!.redirectUrl!)));
    } else {
      final decodedJson = jsonDecode(response.body);
      _showSnackbar(
        decodedJson["message"] ?? "Something went wrong",
      );
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message),
          backgroundColor: Colors.grey.withValues(alpha: 0.5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_expiryDateController.text);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                onChanged: _validateForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: AppHeader(),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back,
                              color: AppColors.primaryColor),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${widget.order.data!.customer!.email}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  "NGN ${formatMoney(widget.order.data!.order!.amount)}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Icon(
                                  Icons.copy_all,
                                  color: AppColors.primaryColor,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(thickness: 0.5),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Enter your card details",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            fadingPageNavigator(
                                context,
                                SavedCardPaymentScreen(
                                  email: widget.order.data!.customer!.email,
                                  amount: widget.order.data!.order!.amount
                                      .toString(),
                                ),
                                false);
                          },
                          child: Text(
                            "Pay with saved card",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const AppFieldLable(text: "Card Number"),
                    AppTextField(
                      controller: _cardNumberController,
                      hintText: "Enter your card number",
                      keyboardType: TextInputType.number,
                      inputFormatters: [CreditCardFormatter()],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Card number is required";
                        }
                        if (!RegExp(r"^\d{4} \d{4} \d{4} \d{4}$")
                            .hasMatch(value)) {
                          return "Enter a valid card number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    const AppFieldLable(text: "Expiry Date"),
                    AppTextField(
                      controller: _expiryDateController,
                      hintText: "MM / YY",
                      keyboardType: TextInputType.number,
                      inputFormatters: [ExpiryDateFormatter()],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Expiry date is required";
                        }
                        if (!RegExp(r"^(0[1-9]|1[0-2])\/\d{2}$")
                            .hasMatch(value)) {
                          return "Enter a valid expiry date (MM/YY)";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    const AppFieldLable(text: "CVV"),
                    AppTextField(
                      controller: _cvvController,
                      hintText: "***",
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "CVV is required";
                        }
                        // Regex to validate the CVV format (3 or 4 digits)
                        if (!RegExp(r"^\d{3,4}$").hasMatch(value)) {
                          return "Enter a valid CVV";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    AppConsentCheckbox(
                      text:
                          "Save my card information for a faster checkout next time",
                    ),
                    SizedBox(height: 50),
                    AppButton(
                      onPressed: isValid
                          ? () {
                              processCardPayment();
                              // showDialog(
                              //   context: context,
                              //   barrierDismissible: false,
                              //   builder: (BuildContext context) {
                              //     return Dialog(
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(8.0),
                              //       ),
                              //       surfaceTintColor: Colors.white,
                              //       child: IntrinsicHeight(
                              //         child: IntrinsicWidth(
                              //           child: const CardPaymentProgressPopup(),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // );
                            }
                          : null,
                      text:
                          "Pay NGN ${formatMoney(widget.order.data!.order!.amount)}",
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Image.asset(
                        AppImages.footer,
                        package: "transact_pay_sdk",
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
