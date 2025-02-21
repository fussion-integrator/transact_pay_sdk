import 'package:flutter/material.dart';
import 'package:transact_pay/ui/screens/initiate_payment_screen.dart';

class TransactPaySDK {
  static void startPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentInitiationScreen(),
      ),
    );
  }
}
