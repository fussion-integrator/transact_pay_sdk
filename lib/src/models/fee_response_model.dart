// To parse this JSON data, do
//
//     final feeResponseModel = feeResponseModelFromJson(jsonString);

import 'dart:convert';

FeeResponseModel feeResponseModelFromJson(String str) =>
    FeeResponseModel.fromJson(json.decode(str));

String feeResponseModelToJson(FeeResponseModel data) =>
    json.encode(data.toJson());

class FeeResponseModel {
  Data? data;
  String? status;
  String? statusCode;
  String? message;

  FeeResponseModel({
    this.data,
    this.status,
    this.statusCode,
    this.message,
  });

  factory FeeResponseModel.fromJson(Map<String, dynamic> json) =>
      FeeResponseModel(
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
  double? fee;
  double? amount;
  double? subsidiaryFee;
  double? customerFee;
  double? totalChargedAmount;
  String? paymentOption;

  Data({
    this.fee,
    this.amount,
    this.subsidiaryFee,
    this.customerFee,
    this.totalChargedAmount,
    this.paymentOption,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fee: double.tryParse(json["fee"].toString()) ?? 0.0,
        amount: double.tryParse(json["amount"].toString()) ?? 0.0,
        subsidiaryFee: double.tryParse(json["subsidiaryFee"].toString()) ?? 0.0,
        customerFee: double.tryParse(json["customerFee"].toString()) ?? 0.0,
        totalChargedAmount:
            double.tryParse(json["totalChargedAmount"].toString()) ?? 0.0,
        paymentOption: json["paymentOption"],
      );

  Map<String, dynamic> toJson() => {
        "fee": fee?.toString(),
        "amount": amount?.toString(),
        "subsidiaryFee": subsidiaryFee?.toString(),
        "customerFee": customerFee?.toString(),
        "totalChargedAmount": totalChargedAmount?.toString(),
        "paymentOption": paymentOption,
      };
}
