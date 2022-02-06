import 'package:teklifimgelsin/ui/GetOffer/model/offermodel.dart';

abstract class APIBase {
   Future<OfferModel> getOffer(int amount, int maturity);
}