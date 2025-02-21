import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:transact_pay_sdk/src/common_widget/app_button.dart';
import 'package:transact_pay_sdk/src/common_widget/app_header.dart';
import 'package:transact_pay_sdk/src/common_widget/app_payment_type_selection.dart';
import 'package:transact_pay_sdk/src/config/transact_pay_request.dart';
import 'package:transact_pay_sdk/src/constant/app_colors.dart';
import 'package:transact_pay_sdk/src/constant/app_images.dart';
import 'package:transact_pay_sdk/src/models/fee_response_model.dart';
import 'package:transact_pay_sdk/src/models/order_response_model.dart';
import 'package:transact_pay_sdk/src/ui/bank_transfer_screen.dart';
import 'package:transact_pay_sdk/src/ui/card_payment_screen.dart';
import 'package:transact_pay_sdk/src/utils/helper.dart';
import 'package:transact_pay_sdk/src/utils/money_formatter.dart';
import 'package:transact_pay_sdk/src/utils/page_navigator/fading_page_navigator.dart';
import 'package:transact_pay_sdk/transact_pay_sdk.dart';

class PaymentTypeScreen extends StatefulWidget {
  final OrderResponseModel order;

  const PaymentTypeScreen({super.key, required this.order});

  @override
  State<PaymentTypeScreen> createState() => _PaymentTypeScreenState();
}

class _PaymentTypeScreenState extends State<PaymentTypeScreen> {
  int _selectedIndex = -1;
  late TransactPay transactPay;
  String fee = "0.00";

  @override
  void initState() {
    super.initState();
    transactPay = TransactPay(apiKey: apiKey, encryptionKey: encryptionKey);

    // // ✅ Check if order data exists before printing
    // if (widget.order.data != null) {
    //   print(widget.order.data);
    // } else {
    //   print("⚠ Warning: Order data is null");
    // }
  }

  void _onPaymentTypeSelected(int index) {
    setState(() {
      _selectedIndex = index;
      getFee();
    });
  }

  void getFee() async {
    print(widget.order.data!.order!.currency ?? "no currency");
    if (widget.order.data?.order?.amount == null ||
        widget.order.data?.order?.currency == null) {
      print("⚠ Warning: Order amount or currency is null. Cannot proceed.");
      return;
    }

    final payload = {
      "amount": widget.order.data!.order!.amount,
      "currency": widget.order.data!.order!.currency,
      "paymentoption": _selectedIndex == 0 ? "BANK-TRANSFER" : "C"
    };

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingDialog(message: "Fetching fees..."),
    );

    final response = await transactPay.orderFee(payload);

    if (Navigator.canPop(context)) Navigator.pop(context); // Close dialog

    if (response.statusCode == 200) {
      debugPrint("✅ Fee Retrieved: ${response.body}");
      final responseJson = jsonDecode(response.body);
      final feeResponse = FeeResponseModel.fromJson(responseJson);
      setState(() {
        fee = feeResponse.data!.fee.toString();
      });
    } else {
      final decodedJson = jsonDecode(response.body);
      _showSnackbar(decodedJson["message"] ?? "Something went wrong");
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderData = widget.order.data;
    final customer = orderData?.customer;
    final order = orderData?.order;

    print(fee);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back, color: AppColors.primaryColor),
                          Text(" Back",
                              style: TextStyle(color: AppColors.primaryColor)),
                        ],
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () => Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => returnScreen),
                    //     (route) => false, // Removes all previous routes
                    //   ),
                    //   child: const Icon(Icons.close,
                    //       color: AppColors.primaryColor),
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          customer?.email ?? "No Email",
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              "NGN ${formatMoney(order?.amount ?? 0)} ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: () {
                                AppHelper.copyToClipboard(
                                  order?.amount.toString() ?? "0",
                                  message: "Text copied to clipboard!",
                                );
                              },
                              child: Icon(Icons.copy_all,
                                  color: AppColors.primaryColor),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Visibility(
                  visible: _selectedIndex > -1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total Amount",
                          style: TextStyle(fontSize: 13)),
                      Row(
                        children: [
                          Text(
                            "NGN ${formatMoney(order?.amount ?? 0)} ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              AppHelper.copyToClipboard(
                                order?.amount.toString() ?? "0",
                                message: "Text copied to clipboard!",
                              );
                            },
                            child: Icon(Icons.copy_all,
                                color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildSummaryRow(
                          "Sub Total", (order?.amount ?? 0).toString()),
                      _buildSummaryRow("Charges", fee),
                    ],
                  ),
                ),
                const Divider(thickness: 0.3),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Select Payment Method",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 20),
                _buildPaymentOptions(),
                const SizedBox(height: 50),
                AppButton(
                  onPressed: _selectedIndex == 0
                      ? () {
                          fadingPageNavigator(
                            context,
                            BankTransferScreen(
                              order: widget.order,
                              fee: fee,
                            ),
                            false,
                          );
                        }
                      : _selectedIndex == 1
                          ? () {
                              fadingPageNavigator(
                                context,
                                CardPaymentScreen(
                                  order: widget.order,
                                  fee: fee,
                                ),
                                false,
                              );
                            }
                          : null,
                  text: "Initiate Payment",
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
    );
  }

  Widget _buildSummaryRow(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          Text("NGN ${formatMoney(amount)}",
              style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Column(
      children: [
        AppPaymentTypeSelection(
          text: 'Pay with bank transfer',
          imageUrl: AppImages.paperPlane,
          isSelected: _selectedIndex == 0,
          onChanged: (isSelected) {
            print(isSelected);
            _onPaymentTypeSelected(0);
          },
        ),
        const SizedBox(height: 20),
        AppPaymentTypeSelection(
          text: 'Pay with card',
          imageUrl: AppImages.card,
          isSelected: _selectedIndex == 1,
          onChanged: (isSelected) {
            print(isSelected);
            _onPaymentTypeSelected(1);
          },
        ),
      ],
    );
  }
}
