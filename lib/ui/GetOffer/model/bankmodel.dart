// ignore_for_file: prefer_collection_literals

class BankModel {
  int? bankId;
  String? bank;
  double? interestRate;
  double? sponsoredRate;
  String? bankType;
  String? url;
  double? hypothecFee;
  double? expertise;
  double? annualRate;

  BankModel(
      {this.bankId,
      this.bank,
      this.interestRate,
      this.sponsoredRate,
      this.bankType,
      this.url,
      this.hypothecFee,
      this.expertise,
      this.annualRate});

  BankModel.fromJson(Map<String, dynamic> json) {
    bankId = json['bank_id'];
    bank = json['bank'];
    interestRate = json['interest_rate'].toDouble();
    sponsoredRate =json['sponsored_rate'].toDouble();
    bankType = json['bank_type'];
    url = json['url'];
    hypothecFee = json['hypothec_fee'].toDouble();
    expertise = json['expertise'].toDouble();
    annualRate = json['annual_rate'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['bank_id'] = bankId;
    data['bank'] = bank;
    data['interest_rate'] = interestRate;
    data['sponsored_rate'] = sponsoredRate;
    data['bank_type'] = bankType;
    data['url'] = url;
    data['hypothec_fee'] = hypothecFee;
    data['expertise'] = expertise;
    data['annual_rate'] = annualRate;
    return data;
  }

  @override
  String toString() {
    return 'BankModel{ bank_id:$bankId,bank:$bank,interest_rate:$interestRate,url: $url, annual_rate: $annualRate}';
  }
}
