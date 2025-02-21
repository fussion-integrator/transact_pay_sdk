import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transact_pay/transact_pay.dart';
import 'package:transact_pay_sdk/src/common_widget/app_bank_detail.dart';
import 'package:transact_pay_sdk/src/common_widget/app_button.dart';
import 'package:transact_pay_sdk/src/common_widget/app_countdown_timer.dart';
import 'package:transact_pay_sdk/src/common_widget/app_header.dart';
import 'package:transact_pay_sdk/src/constant/app_colors.dart';
import 'package:transact_pay_sdk/src/constant/app_images.dart';
import 'package:transact_pay_sdk/src/models/bank_payment_response_model.dart';
import 'package:transact_pay_sdk/src/models/order_response_model.dart';
import 'package:transact_pay_sdk/src/ui/popup_dialog/bank_transfer_progress_popup.dart';
import 'package:transact_pay_sdk/src/utils/money_formatter.dart';

import 'initiate_payment_screen.dart';

class BankTransferScreen extends StatefulWidget {
  final OrderResponseModel order;
  final String? fee;

  const BankTransferScreen({super.key, required this.order, this.fee});

  @override
  State<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen> {
  late TransactPay transactPay;
  String accountNumber = "";
  String accountName = "";
  String bankName = "";
  String paymentReference = "";

  @override
  void initState() {
    super.initState();
    transactPay = TransactPay(apiKey: apiKey, encryptionKey: encryptionKey);
    createBankTransferOrder();
  }

  Future<void> createBankTransferOrder() async {
    final payload = {
      "reference": widget.order.data!.order!.reference,
      "paymentoption": "bank-transfer",
      "country": widget.order.data!.customer!.country,
      "BankTransfer": {}
    };

    try {
      final response = await transactPay.payWithBankTransfer(payload);
      _showSnackbar(
          "Bank transfer order initiated.", Colors.grey.withValues(alpha: 0.5));
      debugPrint("Order Created: ${response.body}");
      final responseJson = jsonDecode(response.body);
      final bankResponse = BankPaymentResponseModel.fromJson(responseJson);
      setState(() {
        bankName = bankResponse.data!.bankTransferDetails!.bankName ?? "";
        accountNumber =
            bankResponse.data!.bankTransferDetails!.bankAccount ?? "";
        accountName = bankResponse.data!.bankTransferDetails!.accountName ?? "";
        paymentReference =
            bankResponse.data!.paymentDetail!.paymentReference ?? "";
      });
    } catch (e) {
      debugPrint("Error creating order: $e");
      _showSnackbar("Bank transfer order failed", Colors.red);
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
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
                        onTap: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => returnScreen),
                          (route) => false,
                        ),
                        child: const Icon(Icons.close,
                            color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text:
                              "Transfer NGN ${formatMoney(widget.order.data!.order!.amount)} to ", // First text in normal style
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black, // Adjust color as needed
                          ),
                          children: [
                            TextSpan(
                              text: accountNumber, // Second text in bold
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: accountNumber));
                          _showSnackbar("$accountNumber copied to clipboard",
                              Colors.grey);
                        },
                        child: Icon(
                          Icons.copy_all,
                          color: AppColors.primaryColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.all(10),
                    //padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 0.3)),
                    child: Column(
                      children: [
                        AppBankDetail(
                          title: "Amount",
                          infoText: "Final amount has added cost of transfer",
                          subtitle:
                              "NGN ${formatMoney(widget.order.data!.order!.amount)}",
                          onIconTap: () {
                            debugPrint("Subtitle: Bank Account");
                          },
                        ),
                        Divider(thickness: 0.5),
                        AppBankDetail(
                          title: "Account Number",
                          subtitle: accountNumber,
                          onIconTap: () {
                            Clipboard.setData(
                                ClipboardData(text: accountNumber));
                            _showSnackbar("$accountNumber copied to clipboard",
                                Colors.grey);
                          },
                        ),
                        Divider(thickness: 0.5),
                        AppBankDetail(
                          title: "Account Name",
                          subtitle: accountName,
                          onIconTap: () {
                            Clipboard.setData(
                                ClipboardData(text: accountNumber));
                            _showSnackbar("$accountName copied to clipboard",
                                Colors.grey);
                          },
                        ),
                        Divider(thickness: 0.5),
                        AppBankDetail(
                          title: "Bank",
                          subtitle: bankName,
                          onIconTap: () {
                            Clipboard.setData(
                                ClipboardData(text: accountNumber));
                            _showSnackbar(
                                "$bankName copied to clipboard", Colors.grey);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "Account details is valid for this transaction only and it will expire in ", // First text
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                        WidgetSpan(
                          child: AppCountdownTimer(
                            durationInSeconds: 600,
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
                  SizedBox(height: 30),
                  AppButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            surfaceTintColor: Colors.white,
                            child: IntrinsicHeight(
                              child: IntrinsicWidth(
                                child: BankTransferProgressPopup(
                                  orderReference:
                                      widget.order.data!.order!.reference ??
                                          "Order not found",
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    text: "I have sent the money",
                  ),
                  const SizedBox(height: 30),
                  Center(
                      child: Image.asset(
                    AppImages.footer,
                    package: "transact_pay_sdk",
                  )),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
