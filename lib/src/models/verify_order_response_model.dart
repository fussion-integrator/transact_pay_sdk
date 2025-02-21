import 'dart:convert';

VerifyOrderResponseModel verifyOrderResponseModelFromJson(String str) =>
    VerifyOrderResponseModel.fromJson(json.decode(str));

String verifyOrderResponseModelToJson(VerifyOrderResponseModel data) =>
    json.encode(data.toJson());

class VerifyOrderResponseModel {
  Data? data;
  String? status;
  String? statusCode;
  String? message;

  VerifyOrderResponseModel({
    this.data,
    this.status,
    this.statusCode,
    this.message,
  });

  factory VerifyOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      VerifyOrderResponseModel(
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
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
  String? orderReference;
  String? paymentReference;
  String? productName;
  num? totalAmountCharged;
  int? statusId;
  String? status;
  String? paymentMethod;
  String? paymentResponseCode;
  String? paymentResponseMessage;
  String? narration;
  String? remarks;
  int? currencyId;
  String? currencyName;
  num? fee;
  num? feeRate;
  num? subsidiaryFee;
  num? customerFee;
  DateTime? dateCreated;
  DateTime? dateUpdated;
  dynamic datePaymentConfirmed;
  List<OrderPayment>? orderPayments;
  Customer? customer;
  List<CardDetail>? cardDetails;
  dynamic paymentLink;

  Data({
    this.orderReference,
    this.paymentReference,
    this.productName,
    this.totalAmountCharged,
    this.statusId,
    this.status,
    this.paymentMethod,
    this.paymentResponseCode,
    this.paymentResponseMessage,
    this.narration,
    this.remarks,
    this.currencyId,
    this.currencyName,
    this.fee,
    this.feeRate,
    this.subsidiaryFee,
    this.customerFee,
    this.dateCreated,
    this.dateUpdated,
    this.datePaymentConfirmed,
    this.orderPayments,
    this.customer,
    this.cardDetails,
    this.paymentLink,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderReference: json["orderReference"],
        paymentReference: json["paymentReference"],
        productName: json["productName"],
        totalAmountCharged: _parseNum(json["totalAmountCharged"]),
        statusId: json["statusId"],
        status: json["status"],
        paymentMethod: json["paymentMethod"],
        paymentResponseCode: json["paymentResponseCode"],
        paymentResponseMessage: json["paymentResponseMessage"],
        narration: json["narration"],
        remarks: json["remarks"],
        currencyId: json["currencyId"],
        currencyName: json["currencyName"],
        fee: _parseNum(json["fee"]),
        feeRate: _parseNum(json["feeRate"]),
        subsidiaryFee: _parseNum(json["subsidiaryFee"]),
        customerFee: _parseNum(json["customerFee"]),
        dateCreated: _parseDate(json["dateCreated"]),
        dateUpdated: _parseDate(json["dateUpdated"]),
        datePaymentConfirmed: json["datePaymentConfirmed"],
        orderPayments: json["orderPayments"] == null
            ? []
            : List<OrderPayment>.from(
                json["orderPayments"].map((x) => OrderPayment.fromJson(x))),
        customer: json["customer"] != null
            ? Customer.fromJson(json["customer"])
            : null,
        cardDetails: json["cardDetails"] == null
            ? []
            : List<CardDetail>.from(
                json["cardDetails"].map((x) => CardDetail.fromJson(x))),
        paymentLink: json["paymentLink"],
      );

  Map<String, dynamic> toJson() => {
        "orderReference": orderReference,
        "paymentReference": paymentReference,
        "productName": productName,
        "totalAmountCharged": totalAmountCharged,
        "statusId": statusId,
        "status": status,
        "paymentMethod": paymentMethod,
        "paymentResponseCode": paymentResponseCode,
        "paymentResponseMessage": paymentResponseMessage,
        "narration": narration,
        "remarks": remarks,
        "currencyId": currencyId,
        "currencyName": currencyName,
        "fee": fee,
        "feeRate": feeRate,
        "subsidiaryFee": subsidiaryFee,
        "customerFee": customerFee,
        "dateCreated": dateCreated?.toIso8601String(),
        "dateUpdated": dateUpdated?.toIso8601String(),
        "datePaymentConfirmed": datePaymentConfirmed,
        "orderPayments": orderPayments?.map((x) => x.toJson()).toList() ?? [],
        "customer": customer?.toJson(),
        "cardDetails": cardDetails?.map((x) => x.toJson()).toList() ?? [],
        "paymentLink": paymentLink,
      };
}

class OrderPayment {
  int? orderId;
  String? orderPaymentReference;
  int? paymentOptionId;
  String? paymentOption;
  int? statusId;
  String? status;
  String? responseCode;
  String? responseMessage;
  dynamic orderPaymentInstrument;
  String? remarks;
  DateTime? dateCreated;
  DateTime? dateUpdated;

  OrderPayment({
    this.orderId,
    this.orderPaymentReference,
    this.paymentOptionId,
    this.paymentOption,
    this.statusId,
    this.status,
    this.responseCode,
    this.responseMessage,
    this.orderPaymentInstrument,
    this.remarks,
    this.dateCreated,
    this.dateUpdated,
  });

  factory OrderPayment.fromJson(Map<String, dynamic> json) => OrderPayment(
        orderId: json["orderId"],
        orderPaymentReference: json["orderPaymentReference"],
        paymentOptionId: json["paymentOptionId"],
        paymentOption: json["paymentOption"],
        statusId: json["statusId"],
        status: json["status"],
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        orderPaymentInstrument: json["orderPaymentInstrument"],
        remarks: json["remarks"],
        dateCreated: _parseDate(json["dateCreated"]),
        dateUpdated: _parseDate(json["dateUpdated"]),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderPaymentReference": orderPaymentReference,
        "paymentOptionId": paymentOptionId,
        "paymentOption": paymentOption,
        "statusId": statusId,
        "status": status,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "orderPaymentInstrument": orderPaymentInstrument,
        "remarks": remarks,
        "dateCreated": dateCreated?.toIso8601String(),
        "dateUpdated": dateUpdated?.toIso8601String(),
      };
}

class Customer {
  String? customerId;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? countryShortName;
  String? customerGroup;
  int? countryId;
  int? globalStatusId;
  String? globalStatus;
  String? mobileNumber;
  bool? isBlacklisted;
  dynamic reasonBlacklisted;
  DateTime? dateCreated;
  dynamic dateUpdated;

  Customer({
    this.customerId,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.countryShortName,
    this.customerGroup,
    this.countryId,
    this.globalStatusId,
    this.globalStatus,
    this.mobileNumber,
    this.isBlacklisted,
    this.reasonBlacklisted,
    this.dateCreated,
    this.dateUpdated,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customerId: json["customerId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        emailAddress: json["emailAddress"],
        countryShortName: json["countryShortName"],
        customerGroup: json["customerGroup"],
        countryId: json["countryId"],
        globalStatusId: json["globalStatusId"],
        globalStatus: json["globalStatus"],
        mobileNumber: json["mobileNumber"],
        isBlacklisted: json["isBlacklisted"],
        reasonBlacklisted: json["reasonBlacklisted"],
        dateCreated: _parseDate(json["dateCreated"]),
        dateUpdated: json["dateUpdated"],
      );

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "firstName": firstName,
        "lastName": lastName,
        "emailAddress": emailAddress,
        "countryShortName": countryShortName,
        "customerGroup": customerGroup,
        "countryId": countryId,
        "globalStatusId": globalStatusId,
        "globalStatus": globalStatus,
        "mobileNumber": mobileNumber,
        "isBlacklisted": isBlacklisted,
        "reasonBlacklisted": reasonBlacklisted,
        "dateCreated": dateCreated?.toIso8601String(),
        "dateUpdated": dateUpdated,
      };
}

class CardDetail {
  int? orderPaymentId;
  bool? status;
  String? country;
  String? cardToken;
  String? cardExpiryMonth;
  String? cardExpiryYear;
  String? cardType;
  String? cardIssuer;
  String? cardFirstSixDigits;
  String? cardLastFourDigits;
  DateTime? dateCreated;
  int? appEnvironmentId;

  CardDetail({
    this.orderPaymentId,
    this.status,
    this.country,
    this.cardToken,
    this.cardExpiryMonth,
    this.cardExpiryYear,
    this.cardType,
    this.cardIssuer,
    this.cardFirstSixDigits,
    this.cardLastFourDigits,
    this.dateCreated,
    this.appEnvironmentId,
  });

  factory CardDetail.fromJson(Map<String, dynamic> json) => CardDetail(
        orderPaymentId: json["orderPaymentId"],
        status: json["status"],
        country: json["country"],
        cardToken: json["cardToken"],
        cardExpiryMonth: json["cardExpiryMonth"],
        cardExpiryYear: json["cardExpiryYear"],
        cardType: json["cardType"],
        cardIssuer: json["cardIssuer"],
        cardFirstSixDigits: json["cardFirstSixDigits"],
        cardLastFourDigits: json["cardLastFourDigits"],
        dateCreated: _parseDate(json["dateCreated"]),
        appEnvironmentId: json["appEnvironmentId"],
      );

  Map<String, dynamic> toJson() => {
        "orderPaymentId": orderPaymentId,
        "status": status,
        "country": country,
        "cardToken": cardToken,
        "cardExpiryMonth": cardExpiryMonth,
        "cardExpiryYear": cardExpiryYear,
        "cardType": cardType,
        "cardIssuer": cardIssuer,
        "cardFirstSixDigits": cardFirstSixDigits,
        "cardLastFourDigits": cardLastFourDigits,
        "dateCreated": dateCreated?.toIso8601String(),
        "appEnvironmentId": appEnvironmentId,
      };
}

// Helper functions for dynamic parsing
num _parseNum(dynamic value) =>
    value is num ? value : num.tryParse(value.toString()) ?? 0;

DateTime? _parseDate(dynamic value) =>
    value != null ? DateTime.tryParse(value) : null;
