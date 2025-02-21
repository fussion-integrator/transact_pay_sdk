import 'dart:convert';

BankPaymentResponseModel bankPaymentResponseModelFromJson(String str) =>
    BankPaymentResponseModel.fromJson(json.decode(str));

String bankPaymentResponseModelToJson(BankPaymentResponseModel data) =>
    json.encode(data.toJson());

class BankPaymentResponseModel {
  Data? data;
  String? status;
  String? statusCode;
  String? message;

  BankPaymentResponseModel({
    this.data,
    this.status,
    this.statusCode,
    this.message,
  });

  factory BankPaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      BankPaymentResponseModel(
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
  BankTransferDetails? bankTransferDetails;
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
        bankTransferDetails: json["bankTransferDetails"] == null
            ? null
            : BankTransferDetails.fromJson(json["bankTransferDetails"]),
        orderPayment: json["orderPayment"] == null
            ? null
            : OrderPayment.fromJson(json["orderPayment"]),
      );

  Map<String, dynamic> toJson() => {
        "paymentDetail": paymentDetail?.toJson(),
        "bankTransferDetails": bankTransferDetails?.toJson(),
        "orderPayment": orderPayment?.toJson(),
      };
}

class BankTransferDetails {
  String? bankAccount;
  String? accountName;
  String? bankName;

  BankTransferDetails({
    this.bankAccount,
    this.accountName,
    this.bankName,
  });

  factory BankTransferDetails.fromJson(Map<String, dynamic> json) =>
      BankTransferDetails(
        bankAccount: json["bankAccount"],
        accountName: json["accountName"],
        bankName: json["bankName"],
      );

  Map<String, dynamic> toJson() => {
        "bankAccount": bankAccount,
        "accountName": accountName,
        "bankName": bankName,
      };
}

class OrderPayment {
  int? orderId;
  String? orderPaymentReference;
  String? currency;
  int? statusId;
  String? orderPaymentResponseCode;
  String? orderPaymentResponseMessage;
  String? orderPaymentInstrument;
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
        orderId: parseInt(json["orderId"]),
        orderPaymentReference: json["orderPaymentReference"],
        currency: json["currency"],
        statusId: parseInt(json["statusId"]),
        orderPaymentResponseCode: json["orderPaymentResponseCode"],
        orderPaymentResponseMessage: json["orderPaymentResponseMessage"],
        orderPaymentInstrument: json["orderPaymentInstrument"],
        remarks: json["remarks"],
        totalAmount: parseDouble(json["totalAmount"]),
        fee: parseDouble(json["fee"]),
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
  String? recipientAccount;
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

/// **Helper functions to handle mixed data types**
num? parseNum(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  if (value is String) return num.tryParse(value);
  return null;
}

double? parseDouble(dynamic value) {
  final num? parsed = parseNum(value);
  return parsed?.toDouble();
}

int? parseInt(dynamic value) {
  final num? parsed = parseNum(value);
  return parsed?.toInt();
}
