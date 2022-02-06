// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:teklifimgelsin/locator.dart';
import 'package:teklifimgelsin/ui/GetOffer/model/offermodel.dart';
import 'package:teklifimgelsin/ui/GetOffer/repository/getofferrepo.dart';
import 'package:teklifimgelsin/ui/GetOffer/service/apibase.dart';
import 'dart:math';

class OfferViewModel with ChangeNotifier implements APIBase {
  final GetOfferRepo _getOfferRepo = locator<GetOfferRepo>();
  bool _isChecked = false;
  double _angle = 0;
  int _amount = 20000;
  int _maturity = 36;
  late int searchAmount;
  late int searchMaturity;
  TextEditingController _amountController =
      TextEditingController(text: "20.000");
  TextEditingController _maturityController = TextEditingController(text: "36");
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  OfferModel _offerModel = OfferModel();
  Key _key = const Key("Key");
  ScrollController _scrollController = ScrollController();

  bool get isChecked => _isChecked;
  double get angle => _angle;
  int get amount => _amount;
  int get maturity => _maturity;
  TextEditingController get amountController => _amountController;
  TextEditingController get maturityController => _maturityController;
  OfferModel get offerModel => _offerModel;
  Key get key => _key;
  ScrollController get scrollController => _scrollController;

  setChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  setAmount(int value) {
    _amount = value;
    notifyListeners();
  }

  setMaturity(int value) {
    _maturity = value;
    notifyListeners();
  }

  setControllerText(String value) {
    _amountController.text = value;
    notifyListeners();
  }

  setMaturityControllerText(String value) {
    _maturityController.text = value;
    notifyListeners();
  }

  @override
  Future<OfferModel> getOffer(int amount, int maturity) async {
    _offerModel = await _getOfferRepo.getOffer(amount, maturity);
    return _offerModel;
  }

  void flip() {
    _angle = (_angle + pi) % (2 * pi);
    _isChecked = _isChecked == true ? false : true;
    notifyListeners();
  }

  calculateMonthlyPayment(double? interestRate, OfferModel offerModel) {
    var totalInterestRate = (interestRate!) * (0.012);
    var monthlyPayment = (offerModel.amount! *
            totalInterestRate *
            pow(1 + totalInterestRate, offerModel.maturity!)) /
        (pow(1 + totalInterestRate, offerModel.maturity!) - 1);
    return monthlyPayment.round();
  }
}
