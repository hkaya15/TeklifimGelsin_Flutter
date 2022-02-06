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
    interestRate = json['interest_rate'];
    sponsoredRate = json['sponsored_rate'];
    bankType = json['bank_type'];
    url = json['url'];
    hypothecFee = json['hypothec_fee'];
    expertise = json['expertise'];
    annualRate = json['annual_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_id'] = this.bankId;
    data['bank'] = this.bank;
    data['interest_rate'] = this.interestRate;
    data['sponsored_rate'] = this.sponsoredRate;
    data['bank_type'] = this.bankType;
    data['url'] = this.url;
    data['hypothec_fee'] = this.hypothecFee;
    data['expertise'] = this.expertise;
    data['annual_rate'] = this.annualRate;
    return data;
  }
   @override
  String toString() {
    return 'BankModel{ bank_id:$bankId,bank:$bank,interest_rate:$interestRate,url: $url, annual_rate: $annualRate}';
  }
}