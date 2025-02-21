import 'dart:convert';

CardPaymentResponseModel cardPaymentResponseModelFromJson(String str) =>
    CardPaymentResponseModel.fromJson(json.decode(str));

String cardPaymentResponseModelToJson(CardPaymentResponseModel data) =>
    json.encode(data.toJson());

class CardPaymentResponseModel {
  Data? data;
  String? status;
  String? statusCode;
  String? message;

  CardPaymentResponseModel({
    this.data,
    this.status,
    this.statusCode,
    this.message,
  });

  factory CardPaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      CardPaymentResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
        "statusCode": statusCode,
        "message": message,
      };
}

class Data {
  PaymentDetail? paymentDetail;
  dynamic bankTransferDetails;
  OrderPayment? orderPayment;

  Data({
    this.paymentDetail,
    this.bankTransferDetails,
    this.orderPayment,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paymentDetail: json["paymentDetail"] == null
            ? null
            : PaymentDetail.fromJson(json["paymentDetail"]),
        bankTransferDetails: json["bankTransferDetails"],
        orderPayment: json["orderPayment"] == null
            ? null
            : OrderPayment.fromJson(json["orderPayment"]),
      );

  Map<String, dynamic> toJson() => {
        "paymentDetail": paymentDetail?.toJson(),
        "bankTransferDetails": bankTransferDetails,
        "orderPayment": orderPayment?.toJson(),
      };
}

class OrderPayment {
  int? orderId;
  String? orderPaymentReference;
  String? currency;
  int? statusId;
  String? orderPaymentResponseCode;
  String? orderPaymentResponseMessage;
  dynamic orderPaymentInstrument;
  String? remarks;
  double? totalAmount;
  double? fee;

  OrderPayment({
    this.orderId,
    this.orderPaymentReference,
    this.currency,
    this.statusId,
    this.orderPaymentResponseCode,
    this.orderPaymentResponseMessage,
    this.orderPaymentInstrument,
    this.remarks,
    this.totalAmount,
    this.fee,
  });

  factory OrderPayment.fromJson(Map<String, dynamic> json) => OrderPayment(
        orderId: _parseInt(json["orderId"]),
        orderPaymentReference: json["orderPaymentReference"],
        currency: json["currency"],
        statusId: _parseInt(json["statusId"]),
        orderPaymentResponseCode: json["orderPaymentResponseCode"],
        orderPaymentResponseMessage: json["orderPaymentResponseMessage"],
        orderPaymentInstrument: json["orderPaymentInstrument"],
        remarks: json["remarks"],
        totalAmount: _parseDouble(json["totalAmount"]),
        fee: _parseDouble(json["fee"]),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderPaymentReference": orderPaymentReference,
        "currency": currency,
        "statusId": statusId,
        "orderPaymentResponseCode": orderPaymentResponseCode,
        "orderPaymentResponseMessage": orderPaymentResponseMessage,
        "orderPaymentInstrument": orderPaymentInstrument,
        "remarks": remarks,
        "totalAmount": totalAmount,
        "fee": fee,
      };
}

class PaymentDetail {
  String? redirectUrl;
  dynamic recipientAccount;
  String? paymentReference;

  PaymentDetail({
    this.redirectUrl,
    this.recipientAccount,
    this.paymentReference,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) => PaymentDetail(
        redirectUrl: json["redirectUrl"],
        recipientAccount: json["recipientAccount"],
        paymentReference: json["paymentReference"],
      );

  Map<String, dynamic> toJson() => {
        "redirectUrl": redirectUrl,
        "recipientAccount": recipientAccount,
        "paymentReference": paymentReference,
      };
}

// 🔥 Utility Functions to Handle Data Type Issues
int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

double? _parseDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}
