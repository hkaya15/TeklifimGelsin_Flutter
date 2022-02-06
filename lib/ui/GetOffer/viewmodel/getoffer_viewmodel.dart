// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:teklifimgelsin/locator.dart';
import 'package:teklifimgelsin/ui/GetOffer/model/offermodel.dart';
import 'package:teklifimgelsin/ui/GetOffer/repository/getofferrepo.dart';
import 'package:teklifimgelsin/ui/GetOffer/service/apibase.dart';
import 'dart:math';

class OfferViewModel with ChangeNotifier implements APIBase{
   final GetOfferRepo _getOfferRepo = locator<GetOfferRepo>();
   bool _isChecked = false;
   double _angle= 0;
   double _amount=20000;
   double _maturity=36;
   var searchAmount;
   var searchMaturity;
   TextEditingController _amountController = TextEditingController(text:"20.000");
   TextEditingController _maturityController = TextEditingController(text:"36");
    FocusNode f1 = FocusNode();
    FocusNode f2 = FocusNode();


   bool get isChecked=>_isChecked;
   double get angle=>_angle;
   double get amount=>_amount;
   double get maturity=>_maturity;
  TextEditingController get amountController => _amountController;
  TextEditingController get maturityController => _maturityController;

   setChecked(bool value){
     _isChecked=value;
     notifyListeners();
   }

   setAmount(double value){
     _amount=value;
     notifyListeners();
   }

   setMaturity(double value){
      _maturity=value;
     notifyListeners();
   }

   setControllerText(String value){
     _amountController.text=value;
     notifyListeners();
   }
    setMaturityControllerText(String value){
     _maturityController.text=value;
     notifyListeners();
   }
  @override
  Future<OfferModel> getOffer(int amount, int maturity) async{
    return await _getOfferRepo.getOffer(amount, maturity);
  }

  void flip(){
    _angle=(_angle+pi) %(2*pi);
    _isChecked= _isChecked == true ? false : true;
    notifyListeners();
  }

}