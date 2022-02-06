import 'package:teklifimgelsin/locator.dart';
import 'package:teklifimgelsin/ui/GetOffer/model/offermodel.dart';
import 'package:teklifimgelsin/ui/GetOffer/service/apibase.dart';
import 'package:teklifimgelsin/ui/GetOffer/service/postapi.dart';
import 'package:teklifimgelsin/ui/GetOffer/view/getoffer.dart';

class GetOfferRepo implements APIBase{
  final API _api = locator<API>();
  @override
  Future<OfferModel> getOffer(int amount,int maturity) async {
  
    return await _api.getOffer(amount,maturity);
  }
 
  
}