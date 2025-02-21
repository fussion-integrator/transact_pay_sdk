import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:transact_pay/services/encryption_service.dart';
import 'package:transact_pay_sdk/src/config/api_endpoints.dart';

/// The `TransactPayApi` class provides methods to make API requests to
/// various endpoints related to payment processing. It uses encryption
/// to secure the data sent to the server.
class TransactPayApi {
  final String apiKey;
  final EncryptionService encryptionService;

  /// Constructor for the `TransactPayApi` class.
  ///
  /// Accepts an `apiKey` for authentication and an `encryptionKey`
  /// for encrypting the request payload.
  TransactPayApi({
    required this.apiKey,
    required String encryptionKey,
  }) : encryptionService = EncryptionService(encryptionKey: encryptionKey);

  /// Helper method to make API requests to the server.
  ///
  /// [endpoint]: The URL of the API endpoint.
  /// [body]: The request payload in the form of a `Map`.
  /// [method]: The HTTP method for the request (e.g., 'POST', 'GET', etc.).
  ///
  /// This method encrypts the request payload using the `EncryptionService`,
  /// prepares the headers and body, and sends the request. It returns the
  /// response from the server as an `http.Response`.
  Future<http.Response> makeApiRequest(
    String endpoint,
    Map<String, dynamic> body,
    String method,
  ) async {
    // Convert the request body into a JSON string
    String bodyString = json.encode(body);

    // Encrypt the JSON string payload
    Uint8List encryptedBody = encryptionService.encryptPayload(bodyString);
    String encryptedBase64 = base64.encode(encryptedBody);

    // Define the request headers including the API key
    var headers = {
      'api-key': apiKey,
      'Content-Type': 'application/json',
    };

    // Create an HTTP request object using the specified method and endpoint
    var request = http.Request(method, Uri.parse(endpoint));
    request.headers.addAll(headers);

    // Add the encrypted body to the request as a JSON object
    request.body = json.encode({"data": encryptedBase64});

    // Send the request and return the response
    return await http.Client().send(request).then((response) async {
      return await http.Response.fromStream(response);
    });
  }

  /// Sends a request to create a new order.
  ///
  /// [orderDetails]: The details of the order to be created.
  /// Returns an `http.Response` from the API.
  Future<http.Response> createOrder(Map<String, dynamic> orderDetails) {
    return makeApiRequest(ApiEndpoints.createOrder, orderDetails, 'POST');
  }

  /// Sends a request to process payment using card details.
  ///
  /// [paymentDetails]: The card details and amount to charge.
  /// Returns an `http.Response` from the API.
  Future<http.Response> payWithCard(Map<String, dynamic> paymentDetails) {
    return makeApiRequest(ApiEndpoints.payWithCard, paymentDetails, 'POST');
  }

  /// Sends a request to process payment using bank transfer.
  ///
  /// [paymentDetails]: The bank details and amount to charge.
  /// Returns an `http.Response` from the API.
  Future<http.Response> payWithBankTransfer(
      Map<String, dynamic> paymentDetails) {
    return makeApiRequest(
        ApiEndpoints.payWithBankTransfer, paymentDetails, 'POST');
  }

  /// Sends a request to retrieve the status of an order.
  ///
  /// [orderId]: The ID of the order to check.
  /// Returns an `http.Response` with the order status.
  Future<http.Response> orderStatus(Map<String, dynamic> orderId) {
    return makeApiRequest(
        ApiEndpoints.orderStatus, {"orderId": orderId}, 'POST');
  }

  /// Sends a request to verify an order.
  ///
  /// [orderId]: The ID of the order to verify.
  /// Returns an `http.Response` with the verification result.
  Future<http.Response> verifyOrder(Map<String, dynamic> orderId) {
    return makeApiRequest(ApiEndpoints.verifyOrder, orderId, 'POST');
  }

  /// Sends a request to save card details for future transactions.
  ///
  /// [cardDetails]: The card details to save.
  /// Returns an `http.Response` from the API.
  Future<http.Response> saveCard(Map<String, dynamic> cardDetails) {
    return makeApiRequest(ApiEndpoints.saveCard, cardDetails, 'PATCH');
  }

  /// Sends a request to calculate the fee for an order.
  ///
  /// [feeDetails]: The details of the order to calculate the fee for.
  /// Returns an `http.Response` with the fee information.
  Future<http.Response> orderFee(Map<String, dynamic> feeDetails) {
    return makeApiRequest(ApiEndpoints.orderFee, feeDetails, 'POST');
  }

  /// Sends a request to track events (e.g., user actions or transaction events).
  ///
  /// [eventDetails]: The details of the event to track.
  /// Returns an `http.Response` from the API.
  Future<http.Response> trackEvents(Map<String, dynamic> eventDetails) {
    return makeApiRequest(ApiEndpoints.trackEvents, eventDetails, 'POST');
  }

  /// Sends a request to retrieve a list of supported banks.
  ///
  /// Returns an `http.Response` with the list of banks.
  Future<http.Response> banks() {
    return makeApiRequest(ApiEndpoints.banks, {}, 'GET');
  }

  /// Sends a request to retrieve a payment link.
  ///
  /// [linkDetails]: The details required to generate the payment link.
  /// Returns an `http.Response` with the payment link.
  Future<http.Response> getPaymentLink(Map<String, dynamic> linkDetails) {
    return makeApiRequest(ApiEndpoints.getPaymentLink, linkDetails, 'GET');
  }

  /// Sends a request to retrieve payment keys for initiating a transaction.
  ///
  /// Returns an `http.Response` with the payment keys.
  Future<http.Response> getPaymentKeys(Map<String, dynamic> linkDetails) {
    return makeApiRequest(ApiEndpoints.getPaymentKeys, {}, 'POST');
  }

  /// Sends a request to tokenize a card charge.
  ///
  /// [chargeDetails]: The charge details to be tokenized.
  /// Returns an `http.Response` from the API.
  Future<http.Response> tokenizeCharge(Map<String, dynamic> chargeDetails) {
    return makeApiRequest(ApiEndpoints.tokenizeCharge, chargeDetails, 'POST');
  }

  /// Sends a request to refund a previous order.
  ///
  /// [refundDetails]: The details of the order to refund.
  /// Returns an `http.Response` with the refund status.
  Future<http.Response> refundOrder(Map<String, dynamic> refundDetails) {
    return makeApiRequest(ApiEndpoints.refundOrder, refundDetails, 'POST');
  }
}
