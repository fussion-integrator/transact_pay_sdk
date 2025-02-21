import 'package:flutter/material.dart';
import 'package:transact_pay/ui/screens/initiate_payment_screen.dart';
import 'package:transact_pay_sdk/src/config/transact_pay_api.dart';
import 'package:http/http.dart' as http;

class TransactPay {
  final String apiKey;
  final String encryptionKey;
  late final TransactPayApi _api;

  // Constructor initializes the TransactPayApi instance using the provided API key and encryption key
  TransactPay({
    required this.apiKey,
    required this.encryptionKey,
  }) {
    _api = TransactPayApi(apiKey: apiKey, encryptionKey: encryptionKey);
  }

  /// Creates a new order by sending the order details to the API
  Future<http.Response> createOrder(Map<String, dynamic> orderDetails) {
    return _api.createOrder(orderDetails);
  }

  /// Processes a card payment with the provided payment details
  Future<http.Response> payWithCard(Map<String, dynamic> paymentDetails) {
    return _api.payWithCard(paymentDetails);
  }

  /// Processes a payment via bank transfer with the given payment details
  Future<http.Response> payWithBankTransfer(
      Map<String, dynamic> paymentDetails) {
    return _api.payWithBankTransfer(paymentDetails);
  }

  /// Retrieves the status of an order using the provided order ID
  Future<http.Response> orderStatus(Map<String, dynamic> orderId) {
    return _api.orderStatus(orderId);
  }

  /// Verifies the status of an order using the provided order ID
  Future<http.Response> verifyOrder(Map<String, dynamic> orderId) {
    return _api.verifyOrder(orderId);
  }

  /// Saves card details by sending them to the API for secure storage
  Future<http.Response> saveCard(Map<String, dynamic> cardDetails) {
    return _api.saveCard(cardDetails);
  }

  /// Retrieves the fee details for an order
  Future<http.Response> orderFee(Map<String, dynamic> feeDetails) {
    return _api.orderFee(feeDetails);
  }

  /// Tracks events (e.g., user actions) by sending event details to the API
  Future<http.Response> trackEvents(Map<String, dynamic> eventDetails) {
    return _api.trackEvents(eventDetails);
  }

  /// Fetches the list of available banks from the API
  Future<http.Response> banks() {
    return _api.banks();
  }

  /// Retrieves a payment link by sending link details to the API
  Future<http.Response> getPaymentLink(Map<String, dynamic> linkDetails) {
    return _api.getPaymentLink(linkDetails);
  }

  /// Retrieves payment keys, likely used for encryption or authentication
  Future<http.Response> getPaymentKeys(Map<String, dynamic> linkDetails) {
    return _api.getPaymentKeys(linkDetails);
  }

  /// Tokenizes a charge, which converts sensitive payment data into a secure token
  Future<http.Response> tokenizeCharge(Map<String, dynamic> chargeDetails) {
    return _api.tokenizeCharge(chargeDetails);
  }

  /// Processes a refund for an order using the provided refund details
  Future<http.Response> refundOrder(Map<String, dynamic> refundDetails) {
    return _api.refundOrder(refundDetails);
  }

  /// Navigates to the Payment Initiation Screen
  // Future<void> showPaymentInitiationScreen(
  //     BuildContext context, Map<String, dynamic> paymentDetails) async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const PaymentInitiationScreen(),
  //     ),
  //   );
  // }

  // /// Navigates to the Card Payment Screen
  // Future<void> showCardPaymentScreen(
  //     BuildContext context, Map<String, dynamic> paymentDetails) async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => CardPaymentScreen(
  //         email: paymentDetails['email'],
  //         amount: paymentDetails['amount'],
  //       ),
  //     ),
  //   );
  // }
  //
  // /// Navigates to the Bank Transfer Screen
  // Future<void> showBankTransferScreen(
  //     BuildContext context, Map<String, dynamic> paymentDetails) async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => BankTransferScreen(
  //         email: paymentDetails['email'],
  //         amount: paymentDetails['amount'],
  //       ),
  //     ),
  //   );
  // }
  //
  // /// Navigates to the Payment Type Selection Screen
  // Future<void> showPaymentTypeScreen(BuildContext context) async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const PaymentTypeScreen(),
  //     ),
  //   );
  // }
  //
  // /// Navigates to the Saved Card Payment Screen
  // Future<void> showSavedCardPaymentScreen(
  //     BuildContext context, Map<String, dynamic> paymentDetails) async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => SavedCardPaymentScreen(
  //         email: paymentDetails['email'],
  //         amount: paymentDetails['amount'],
  //       ),
  //     ),
  //   );
  //}
}
