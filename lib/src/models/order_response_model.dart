import 'dart:convert';

OrderResponseModel orderResponseModelFromJson(String str) =>
    OrderResponseModel.fromJson(json.decode(str));

String orderResponseModelToJson(OrderResponseModel data) =>
    json.encode(data.toJson());

class OrderResponseModel {
  Data? data;
  String? status;
  String? statusCode;
  String? message;

  OrderResponseModel({
    this.data,
    this.status,
    this.statusCode,
    this.message,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderResponseModel(
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
  Order? order;
  Subsidiary? subsidiary;
  Customer? customer;
  Payment? payment;
  List<OtherPaymentOption>? otherPaymentOptions;
  List<dynamic>? savedCards;
  SubsidiaryOrderSummary? subsidiaryOrderSummary;
  bool? isDiscounted;
  double? oldAmount;
  double? newAmount;
  double? discountAmount;
  dynamic mandateCode;

  Data({
    this.order,
    this.subsidiary,
    this.customer,
    this.payment,
    this.otherPaymentOptions,
    this.savedCards,
    this.subsidiaryOrderSummary,
    this.isDiscounted,
    this.oldAmount,
    this.newAmount,
    this.discountAmount,
    this.mandateCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        subsidiary: json["subsidiary"] == null
            ? null
            : Subsidiary.fromJson(json["subsidiary"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        otherPaymentOptions: json["otherPaymentOptions"] == null
            ? []
            : List<OtherPaymentOption>.from(json["otherPaymentOptions"]
                .map((x) => OtherPaymentOption.fromJson(x))),
        savedCards: json["savedCards"] == null
            ? []
            : List<dynamic>.from(json["savedCards"].map((x) => x)),
        subsidiaryOrderSummary: json["subsidiaryOrderSummary"] == null
            ? null
            : SubsidiaryOrderSummary.fromJson(json["subsidiaryOrderSummary"]),
        isDiscounted: json["isDiscounted"],
        oldAmount: json["oldAmount"]?.toDouble(),
        newAmount: json["newAmount"]?.toDouble(),
        discountAmount: json["discountAmount"]?.toDouble(),
        mandateCode: json["mandateCode"],
      );

  Map<String, dynamic> toJson() => {
        "order": order?.toJson(),
        "subsidiary": subsidiary?.toJson(),
        "customer": customer?.toJson(),
        "payment": payment?.toJson(),
        "otherPaymentOptions": otherPaymentOptions == null
            ? []
            : List<dynamic>.from(otherPaymentOptions!.map((x) => x.toJson())),
        "savedCards": savedCards == null
            ? []
            : List<dynamic>.from(savedCards!.map((x) => x)),
        "subsidiaryOrderSummary": subsidiaryOrderSummary?.toJson(),
        "isDiscounted": isDiscounted,
        "oldAmount": oldAmount,
        "newAmount": newAmount,
        "discountAmount": discountAmount,
        "mandateCode": mandateCode,
      };
}

class Customer {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? country;

  Customer({
    this.email,
    this.firstName,
    this.lastName,
    this.mobile,
    this.country,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobile: json["mobile"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "country": country,
      };
}

class Order {
  String? reference;
  String? processorReference;
  dynamic orderPaymentReference;
  double? amount;
  double? fee;
  double? feeRate;
  int? statusId;
  String? status;
  String? currency;
  String? narration;
  dynamic recurringPaymentId;

  Order({
    this.reference,
    this.processorReference,
    this.orderPaymentReference,
    this.amount,
    this.fee,
    this.feeRate,
    this.statusId,
    this.status,
    this.currency,
    this.narration,
    this.recurringPaymentId,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        reference: json["reference"],
        processorReference: json["processorReference"],
        orderPaymentReference: json["orderPaymentReference"],
        amount: json["amount"]?.toDouble(),
        fee: json["fee"]?.toDouble(),
        feeRate: json["feeRate"]?.toDouble(),
        statusId: json["statusId"],
        status: json["status"],
        currency: json["currency"],
        narration: json["narration"],
        recurringPaymentId: json["recurringPaymentId"],
      );

  Map<String, dynamic> toJson() => {
        "reference": reference,
        "processorReference": processorReference,
        "orderPaymentReference": orderPaymentReference,
        "amount": amount,
        "fee": fee,
        "feeRate": feeRate,
        "statusId": statusId,
        "status": status,
        "currency": currency,
        "narration": narration,
        "recurringPaymentId": recurringPaymentId,
      };
}

class OtherPaymentOption {
  String? code;
  String? name;
  String? currency;

  OtherPaymentOption({
    this.code,
    this.name,
    this.currency,
  });

  factory OtherPaymentOption.fromJson(Map<String, dynamic> json) =>
      OtherPaymentOption(
        code: json["code"],
        name: json["name"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "currency": currency,
      };
}

class Payment {
  dynamic code;
  String? source;
  dynamic selectedOption;
  dynamic accountNumber;
  dynamic bankProviderName;

  Payment({
    this.code,
    this.source,
    this.selectedOption,
    this.accountNumber,
    this.bankProviderName,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        code: json["code"],
        source: json["source"],
        selectedOption: json["selectedOption"],
        accountNumber: json["accountNumber"],
        bankProviderName: json["bankProviderName"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "source": source,
        "selectedOption": selectedOption,
        "accountNumber": accountNumber,
        "bankProviderName": bankProviderName,
      };
}

class Subsidiary {
  int? id;
  String? name;
  String? country;
  String? supportEmail;
  List<dynamic>? customization;

  Subsidiary({
    this.id,
    this.name,
    this.country,
    this.supportEmail,
    this.customization,
  });

  factory Subsidiary.fromJson(Map<String, dynamic> json) => Subsidiary(
        id: json["id"],
        name: json["name"],
        country: json["country"],
        supportEmail: json["supportEmail"],
        customization: json["customization"] == null
            ? []
            : List<dynamic>.from(json["customization"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "supportEmail": supportEmail,
        "customization": customization,
      };
}

class SubsidiaryOrderSummary {
  String? orderName;
  double? totalAmount;
  String? reference;
  String? currency;
  dynamic recurringPaymentId;
  List<OrderItem>? orderItems;

  SubsidiaryOrderSummary({
    this.orderName,
    this.totalAmount,
    this.reference,
    this.currency,
    this.recurringPaymentId,
    this.orderItems,
  });

  factory SubsidiaryOrderSummary.fromJson(Map<String, dynamic> json) =>
      SubsidiaryOrderSummary(
        orderName: json["orderName"],
        totalAmount: json["totalAmount"]?.toDouble(),
        reference: json["reference"],
        currency: json["currency"],
        recurringPaymentId: json["recurringPaymentId"],
        orderItems: json["orderItems"] == null
            ? []
            : List<OrderItem>.from(
                json["orderItems"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orderName": orderName,
        "totalAmount": totalAmount,
        "reference": reference,
        "currency": currency,
        "recurringPaymentId": recurringPaymentId,
        "orderItems": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
      };
}

class OrderItem {
  String? name;
  double? amount;

  OrderItem({
    this.name,
    this.amount,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        name: json["name"],
        amount: json["amount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
      };
}
