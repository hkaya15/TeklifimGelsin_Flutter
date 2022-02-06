// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:teklifimgelsin/ui/GetOffer/model/offermodel.dart';
import 'dart:convert' as convert;
import 'apibase.dart';

class API implements APIBase {
  var jsonResponse;
  @override
  Future<OfferModel> getOffer(int amount, int maturity) async {
    var _url = Uri.parse('https://teklifimgelsin.com/api/briefLoanOffer');
    var _response = await http.post(
      _url,
      body: jsonEncode({
        'amount': amount,
        "maturity": maturity,
        "type": 0,
        "offer_count": 3
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (_response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(_response.body) as Map<String, dynamic>;

      // print('$jsonResponse');
    } else {
      print('Request failed with status: ${_response.statusCode}.');
    }

    return OfferModel.fromJson(jsonResponse);
  }
}
