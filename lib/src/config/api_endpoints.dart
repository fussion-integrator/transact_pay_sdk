// lib/constants.dart

class ApiEndpoints {
  static const String createOrder =
      'https://payment-api-service.transactpay.ai/payment/order/create';
  static const String payWithCard =
      'https://payment-api-service.transactpay.ai/payment/order/pay';
  static const String payWithBankTransfer =
      'https://payment-api-service.transactpay.ai/payment/order/pay';
  static const String orderStatus =
      'https://payment-api-service.transactpay.ai/payment/order/status';
  static const String verifyOrder =
      'https://payment-api-service.transactpay.ai/payment/order/verify';
  static const String saveCard =
      'https://payment-api-service.transactpay.ai/payment/order/save-card';
  static const String orderFee =
      'https://payment-api-service.transactpay.ai/payment/order/fee';
  static const String trackEvents =
      'https://payment-api-service.transactpay.ai/payment/order/event/track';
  static const String banks =
      'https://payment-api-service.transactpay.ai/payment/banks';
  static const String getPaymentLink =
      'https://payment-api-service.transactpay.ai/payment/paymentlink/info';
  static const String getPaymentKeys =
      'https://payment-api-service.transactpay.ai/payment/paymentlink/get-keys';
  static const String tokenizeCharge =
      'https://payment-api-service.transactpay.ai/payment/order/card/tokenized/pay';
  static const String refundOrder =
      'https://payment-api-service.transactpay.ai/payment/order/refund';
}
