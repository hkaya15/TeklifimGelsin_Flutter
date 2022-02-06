// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:teklifimgelsin/ui/GetOffer/model/bankmodel.dart';

class OfferModel {
  Null? id;
  int? amount;
  Null? createdAt;
  Null? clientId;
  int? type;
  int? maturity;
  Null? carCondition;
  int? totalOffers;
  List<BankModel>? offers;

  OfferModel(
      {this.id,
      this.amount,
      this.createdAt,
      this.clientId,
      this.type,
      this.maturity,
      this.carCondition,
      this.totalOffers,
      this.offers});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    createdAt = json['created_at'];
    clientId = json['client_id'];
    type = int.parse(json['type']);
    maturity = json['maturity'];
    carCondition = json['carCondition'];
    totalOffers = json['total_offers'];
    if (json['offers'] != null) {
      offers = <BankModel>[];
      json['offers'].forEach((v) {
        offers!.add(new BankModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['client_id'] = this.clientId;
    data['type'] = this.type;
    data['maturity'] = this.maturity;
    data['carCondition'] = this.carCondition;
    data['total_offers'] = this.totalOffers;
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  @override
  String toString() {
    return 'OfferModel{ id:$id,amount:$amount,maturity:$maturity,total_offers: $totalOffers, offers: $offers}';
  }
}