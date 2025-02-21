import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:transact_pay_sdk/src/config/transact_pay_request.dart';
import 'package:transact_pay_sdk/src/constant/app_images.dart';
import 'package:transact_pay_sdk/src/models/order_response_model.dart';
import 'package:transact_pay_sdk/src/ui/payment_type_screen.dart';
import 'package:transact_pay_sdk/src/ui/popup_dialog/loading_progress_dialog.dart';

class PaymentInitiationScreen extends StatefulWidget {
  final String apiKey;
  final String encryptionKey;
  final String secretKey;
  final Map<String, dynamic> payload;
  final Widget returnScreen;

  const PaymentInitiationScreen(
      {super.key,
      required this.apiKey,
      required this.encryptionKey,
      required this.secretKey,
      required this.payload,
      required this.returnScreen});

  @override
  State<PaymentInitiationScreen> createState() =>
      _PaymentInitiationScreenState();
}

String apiKey = "";
String encryptionKey = "";
String secretKey = "";
Widget returnScreen = Scaffold();

class _PaymentInitiationScreenState extends State<PaymentInitiationScreen> {
  //final _formKey = GlobalKey<FormState>();

  // final TextEditingController _firstNameController = TextEditingController();
  // final TextEditingController _lastNameController = TextEditingController();
  // final TextEditingController _amountController = TextEditingController();
  // final TextEditingController _phoneNumberController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _descriptionController = TextEditingController();

  bool isValid = false;

  // void _validateForm() {
  //   setState(() {
  //     isValid = _formKey.currentState?.validate() ?? false;
  //   });
  // }

  late TransactPay transactPay;

  @override
  void initState() {
    super.initState();
    apiKey = widget.apiKey;
    encryptionKey = widget.encryptionKey;
    secretKey = widget.secretKey;
    returnScreen = widget.returnScreen;
    transactPay = TransactPay(apiKey: apiKey, encryptionKey: encryptionKey);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      createOrder();
    });
  }

  Future<void> createOrder() async {
    try {
      if (widget.payload.isEmpty) {
        _showDialog("Error", "Invalid payment details.");
        return;
      }

      _showLoadingDialog();

      final response = await transactPay.createOrder(widget.payload);
      if (Navigator.canPop(context)) Navigator.pop(context); // Close dialog

      final responseJson = jsonDecode(response.body);
      if (response.statusCode == 200 && responseJson.containsKey("data")) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PaymentTypeScreen(
                    order: OrderResponseModel.fromJson(responseJson))));
        _showSnackbar(
            "Order created successfully", Colors.grey.withValues(alpha: 0.5));
      } else {
        _showSnackbar(responseJson['message'] ?? "Something went wrong",
            Colors.grey.withValues(alpha: 0.5));
        Navigator.pop(context);
      }
    } catch (e) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      _showSnackbar("Failed to create order. Please try again.", Colors.red);
    }
  }

// Helper function to show a loading dialog
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            AppImages.footer,
            package: "transact_pay_sdk",
          )),
          const LoadingDialog(message: "Initializing payment..."),
        ],
      ),
    );
  }

// Helper function to show an alert dialog
  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

// Helper function to show a snackbar
  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      // body: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.all(4.0),
      //     child: SingleChildScrollView(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Form(
      //         key: _formKey,
      //         onChanged: _validateForm,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             const Padding(
      //               padding: EdgeInsets.all(12.0),
      //               child: AppHeader(),
      //             ),
      //             const SizedBox(height: 20),
      //             const AppFieldLable(text: 'First Name'),
      //             AppTextField(
      //               controller: _firstNameController,
      //               hintText: "Enter first name",
      //               validator: (value) => value == null || value.isEmpty
      //                   ? "First name is required"
      //                   : null,
      //             ),
      //             const SizedBox(height: 16.0),
      //             const AppFieldLable(text: "Last Name"),
      //             AppTextField(
      //               controller: _lastNameController,
      //               hintText: "Enter last name",
      //               validator: (value) => value == null || value.isEmpty
      //                   ? "Last name is required"
      //                   : null,
      //             ),
      //             const SizedBox(height: 16.0),
      //             const AppFieldLable(text: "Phone Number"),
      //             AppTextField(
      //               controller: _phoneNumberController,
      //               hintText: "00 0000 0000",
      //               keyboardType: TextInputType.phone,
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return "Phone number is required";
      //                 }
      //                 if (!RegExp(r"^[0-9]{10,11}$").hasMatch(value)) {
      //                   return "Enter a valid phone number";
      //                 }
      //                 return null;
      //               },
      //               prefix: Row(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   const Text("  🇳🇬", style: TextStyle(fontSize: 24)),
      //                   const Text(" +234 "),
      //                   Container(
      //                     margin: const EdgeInsets.symmetric(horizontal: 8),
      //                     color: Colors.black,
      //                     height: 32,
      //                     width: 0.5,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             const SizedBox(height: 16.0),
      //             const AppFieldLable(text: "Email"),
      //             AppTextField(
      //               controller: _emailController,
      //               hintText: "Enter your email",
      //               keyboardType: TextInputType.emailAddress,
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return "Email is required";
      //                 }
      //                 if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
      //                   return "Enter a valid email address";
      //                 }
      //                 return null;
      //               },
      //             ),
      //             const SizedBox(height: 16.0),
      //             const AppFieldLable(text: "Amount"),
      //             AppTextField(
      //               controller: _amountController,
      //               hintText: "Enter amount",
      //               keyboardType: TextInputType.number,
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return "Amount is required";
      //                 }
      //                 if (double.tryParse(value.replaceAll(',', '')) == null) {
      //                   return "Enter a valid number";
      //                 }
      //                 if (double.parse(value.replaceAll(',', '')) <= 0) {
      //                   return "Amount must be greater than 0";
      //                 }
      //                 return null;
      //               },
      //               prefix: Row(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   const Text("  🇳🇬", style: TextStyle(fontSize: 24)),
      //                   const Text(" NGN"),
      //                   Container(
      //                     margin: const EdgeInsets.symmetric(horizontal: 8),
      //                     color: Colors.black,
      //                     height: 32,
      //                     width: 0.5,
      //                   ),
      //                 ],
      //               ),
      //               inputFormatters: [
      //                 MoneyInputFormatter(),
      //               ],
      //             ),
      //             const SizedBox(height: 16.0),
      //             const AppFieldLable(
      //               text: "Payment Description",
      //               optional: true,
      //             ),
      //             AppTextField(
      //               controller: _descriptionController,
      //               hintText: "Enter payment description (optional)",
      //               maxLines: 3,
      //               onChange: (value) {
      //                 // Ensure that the input is no more than 50 characters
      //                 if (_descriptionController.text.length > 50) {
      //                   _descriptionController.text =
      //                       _descriptionController.text.substring(0, 50);
      //                   _descriptionController.selection =
      //                       TextSelection.collapsed(
      //                           offset: _descriptionController.text.length);
      //                 }
      //               },
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(top: 8.0),
      //               child: Align(
      //                 alignment: Alignment.bottomRight,
      //                 child: Text(
      //                   "${_descriptionController.text.length}/50", // Current character count and max length
      //                   style: TextStyle(fontSize: 12.0, color: Colors.grey),
      //                 ),
      //               ),
      //             ),
      //             const SizedBox(height: 32.0),
      //             AppButton(
      //               onPressed: isValid
      //                   ? () {
      //                       createOrder();
      //                     }
      //                   : null,
      //               text: "Initiate Payment",
      //             ),
      //             const SizedBox(height: 30),
      //             Center(
      //                 child: Image.asset(
      //               AppImages.footer,
      //               package: "transact_pay_sdk",
      //             )),
      //             const SizedBox(height: 30),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
