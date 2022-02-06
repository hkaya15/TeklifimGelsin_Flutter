// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, avoid_unnecessary_containers, avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:teklifimgelsin/ui/GetOffer/viewmodel/getoffer_viewmodel.dart';

class GetOffer extends StatelessWidget {
  const GetOffer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<OfferViewModel>(builder: (context, viewmodel, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: viewmodel.angle),
                duration: Duration(seconds: 1),
                builder: (BuildContext context, double value, __) {
                  Future.delayed(Duration(milliseconds: 10), () {
                    value >= (pi / 2)
                        ? viewmodel.setChecked(false)
                        : viewmodel.setChecked(true);
                  });

                  return (Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(value),
                      child: searchBox(size, viewmodel, context)));
                }),
          ],
        )),
      );
    });
  }

  AppBar get appBar => AppBar(
        title: Text("Teklifim Gelsin!"),
        centerTitle: true,
      );

  SizedBox searchBox(
          Size size, OfferViewModel viewmodel, BuildContext context) =>
      SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.6,
        child: viewmodel.isChecked
            ? calculate(viewmodel, context)
            : viewmodel.offerModel.offers != null
                ? result(viewmodel)
                : null,
      );
  Material calculate(OfferViewModel viewmodel, BuildContext context) =>
      Material(
        type: MaterialType.transparency,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 1, color: Colors.black),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                head,
                //First SumPrice
                sumOffer(viewmodel),
                sumOfferSlider(viewmodel, context),
                //Second Maturity
                maturity(viewmodel),
                maturitySlider(viewmodel, context),
                //Info
                info(viewmodel),
                //Button
                getOfferButton(viewmodel, context)
              ],
            )),
      );
  //Head
  Padding get head => Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Center(
          child: Text(
            "Kredi Hesaplama",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
  //Total
  Padding sumOffer(OfferViewModel viewmodel) => Padding(
        padding: const EdgeInsets.only(top: 45.0, left: 15.0, right: 15.0),
        child: TextFormField(
          focusNode: viewmodel.f1,
          onChanged: (value) => {
            if (value != null && value!="")
              {
                viewmodel.searchAmount = int.parse(value),
                if (viewmodel.searchAmount != null &&
                    viewmodel.searchAmount >= 1000 &&
                    viewmodel.searchAmount <= 100000)
                  {
                    viewmodel.setAmount(viewmodel.searchAmount),
                  }
              }
          },
          controller: viewmodel.amountController,
          keyboardType: TextInputType.number,
          //onSaved: (String? value) => viewmodel.setAmount(int.parse(value!)),
          decoration: InputDecoration(
            labelText: "Toplam Tutar",
            hintText: viewmodel.amount.toStringAsFixed(0),
            suffixIcon: Icon(Icons.edit),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      );
  //Total Slider
  Slider sumOfferSlider(OfferViewModel viewmodel, BuildContext context) =>
      Slider(
        activeColor: Colors.black,
        value: viewmodel.amount.toDouble(),
        min: 1000,
        max: 100000,
        divisions: 10,
        onChanged: (double value) {
          FocusScope.of(context).requestFocus(viewmodel.f1);

          var newvalue = value.round();
          viewmodel.setAmount(newvalue);
          viewmodel.setControllerText(viewmodel.amount.toStringAsFixed(0));
        },
      );
  //Maturity
  Padding maturity(OfferViewModel viewmodel) => Padding(
        padding: const EdgeInsets.only(top: 25.0, left: 15.0, right: 15.0),
        child: TextFormField(
          focusNode: viewmodel.f2,
          onChanged: (value) => {
            if (value != null && value!="")
              {
                viewmodel.searchMaturity = int.parse(value),
                if (viewmodel.searchMaturity != null &&
                    viewmodel.searchMaturity >= 3 &&
                    viewmodel.searchMaturity <= 36)
                  {viewmodel.setMaturity(viewmodel.searchMaturity)}
              }
          },
          controller: viewmodel.maturityController,
          keyboardType: TextInputType.number,
        //  onSaved: (String? value) => viewmodel.setAmount(int.parse(value!)),
          decoration: InputDecoration(
            labelText: "Vade Süresi",
            hintText: viewmodel.maturity.toStringAsFixed(0),
            suffixIcon: Icon(Icons.edit),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      );
  // Maturity Slider
  Slider maturitySlider(OfferViewModel viewmodel, BuildContext context) =>
      Slider(
        activeColor: Colors.black,
        value: viewmodel.maturity.toDouble(),
        min: 3,
        max: 36,
        divisions: 12,
        onChanged: (double value) {
          FocusScope.of(context).requestFocus(viewmodel.f2);
          viewmodel.setMaturity(value.toInt());
          viewmodel
              .setMaturityControllerText(viewmodel.maturity.toStringAsFixed(0));
        },
      );
  // Info
  Padding info(OfferViewModel viewmodel) => Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Center(
          child: Text(
            "₺${viewmodel.amount.toStringAsFixed(0)} ${viewmodel.maturity.toStringAsFixed(0)} Ay Vadeli",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
  //Offer Button
  Container getOfferButton(OfferViewModel viewmodel, BuildContext context) =>
      Container(
        margin: EdgeInsets.only(top: 30),
        height: 50.0,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ))),
          onPressed: () async {
            var amount = viewmodel.amount;
            var maturity = viewmodel.maturity;
            final _getOfferViewModel =
                Provider.of<OfferViewModel>(context, listen: false);
            if (amount > 50000 && maturity >= 25) {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Center(child: Text("Teklif Bulunamadı")),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: const <Widget>[
                          Text(
                              'Bankacılık Düzenleme ve Denetleme Kurumu(BDDK), 04.09.2020 tarihli kurul kararı ile 50.000 TL üzeri tüketici kredilerinde vade sınırını 36 aydan 24 aya indirmiştir. Lütfen aramanızı güncelleyin.'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Tamam'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              try{
                await _getOfferViewModel.getOffer(amount, maturity).then((a) {
                if (a!= null) {
                  viewmodel.flip();
                }
              });
               }catch(e){
                 print(e.toString());
               }
              
            }
          },
          child: const Text('TeklifimGelsin'),
        ),
      );

  // Result Page
  Transform result(OfferViewModel viewmodel) => Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(pi),
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 1, color: Colors.black),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                infoResult(viewmodel),
                resultList(viewmodel),
                moreDetails(viewmodel),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [backButton(viewmodel), continueButton(viewmodel)],
                )
              ],
            ),
          ),
        ),
      );
  // Result Info
  Padding infoResult(OfferViewModel viewmodel) => Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Center(
          child: Text(
            viewmodel.offerModel.maturity.toString() +
                " ay vadeli " +
                viewmodel.offerModel.amount.toString() +
                "₺ için",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
  // Results

  Widget resultList(OfferViewModel viewmodel) => ListView.builder(
      key: viewmodel.key,
      controller: viewmodel.scrollController,
      itemCount: 3,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Center(
                        child: Text(viewmodel.offerModel.offers![index].bank
                            .toString())),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Yıllık Faiz Oranı: ' +
                              viewmodel.offerModel.offers![index].annualRate!
                                  .toStringAsFixed(2)),
                          Text('Aylık Faiz Oranı: ' +
                              viewmodel.offerModel.offers![index].interestRate!
                                  .toStringAsFixed(2)),
                          Text('Miktar: ' +
                              viewmodel.offerModel.amount.toString()),
                          Text('Vade: ' +
                              viewmodel.offerModel.maturity.toString()),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Tamam'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: ListTile(
              tileColor: Colors.transparent,
              contentPadding: EdgeInsets.all(8.0),
              horizontalTitleGap: 10.0,
              title:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.monetization_on),
                ),
                Center(
                    child: Text(
                        viewmodel.offerModel.offers![index].bank.toString())),
              ]),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Oran",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                              "%${viewmodel.offerModel.offers![index].interestRate}"),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Maliyet",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                              "₺${viewmodel.calculateMonthlyPayment(viewmodel.offerModel.offers![index].interestRate, viewmodel.offerModel) * 36}"),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Aylık Taksit",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                              "₺${viewmodel.calculateMonthlyPayment(viewmodel.offerModel.offers![index].interestRate, viewmodel.offerModel)}"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      });
  //Details
  Padding moreDetails(OfferViewModel viewmodel) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          height: 30.0,
          width: 300.0,
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ))),
            onPressed: () async {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Size Özel ${viewmodel.offerModel.totalOffers} farklı teklimiz daha var'),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      );
  // Back Button
  Padding backButton(OfferViewModel viewmodel) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          height: 30.0,
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ))),
            onPressed: () async {
              viewmodel.flip();
            },
            child: Text('Geri'),
          ),
        ),
      );
  // Continue Button
  Padding continueButton(OfferViewModel viewmodel) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          height: 30.0,
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ))),
            onPressed: () async {},
            child: Text('Devam Et'),
          ),
        ),
      );
}
