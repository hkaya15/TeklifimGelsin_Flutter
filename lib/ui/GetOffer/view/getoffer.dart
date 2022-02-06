// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:provider/provider.dart';
import 'package:teklifimgelsin/ui/GetOffer/viewmodel/getoffer_viewmodel.dart';

class GetOffer extends StatelessWidget {
  const GetOffer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OfferViewModel>(builder: (context, viewmodel, child) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: viewmodel.flip,
              child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: viewmodel.angle),
                  duration: Duration(seconds: 1),
                  builder: (BuildContext context, double value, __) {
                    Future.delayed(Duration(milliseconds: 10),(){
                      value>=(pi/2) ? viewmodel.setChecked(false) : viewmodel.setChecked(true);
                    });
                    
                    return (Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(value),
                      child: SizedBox(
                        width: 309,
                        height: 474,
                        child: viewmodel.isChecked
                            ? Material(
                              type: MaterialType.transparency,
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top:18.0),
                                        child: Center(child: Text("Kredi Hesaplama",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),),
                                      ),
                                    Padding(
                                    padding: const EdgeInsets.only(top:25.0,left: 15.0,right: 15.0),
                                    child: TextFormField(
                                      focusNode: viewmodel.f1,
                        onChanged: (value) =>{
                          if(value!=null){
                            viewmodel.searchAmount= double.tryParse(value),
                          if( viewmodel.searchAmount!=null&&viewmodel.searchAmount >= 1000 && viewmodel.searchAmount<=100000 ){
                            viewmodel.setAmount(viewmodel.searchAmount),
                            
                          }
                          }
                        } ,              
            controller: viewmodel.amountController,
            keyboardType: TextInputType.number,
            onSaved: (String ?value) => viewmodel.setAmount(double.parse(value!)),
            decoration: InputDecoration(
              labelText: "Toplam Tutar",
                hintText: viewmodel.amount.toStringAsFixed(0),
                suffixIcon: Icon(Icons.edit),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
),
                                  ),
                                 Slider(
                                   activeColor: Colors.black,
                                   value: viewmodel.amount,
              min: 1000,
              max: 100000,
              divisions: 10, onChanged: (double value) {
                  FocusScope.of(context).requestFocus(viewmodel.f1);

                var newvalue=value.round(); 
                viewmodel.setAmount(newvalue.toDouble());
                viewmodel.setControllerText(viewmodel.amount.toStringAsFixed(0));
               },
                                 ),

                                 ///Seconf
                                 Padding(
                                    padding: const EdgeInsets.only(top:25.0,left: 15.0,right: 15.0),
                                    child: TextFormField(
                                      focusNode: viewmodel.f2,
                        onChanged: (value) =>{
                          if(value!=null){
                            viewmodel.searchMaturity= double.tryParse(value),
                          if( viewmodel.searchMaturity!=null && viewmodel.searchMaturity >= 3 && viewmodel.searchMaturity<=36 ){
                            viewmodel.setMaturity(viewmodel.searchMaturity)
                          }
                          }
                        } ,              
            controller: viewmodel.maturityController,
            keyboardType: TextInputType.number,
            onSaved: (String ?value) => viewmodel.setAmount(double.parse(value!)),
            decoration: InputDecoration(
              labelText: "Vade Süresi",
                hintText: viewmodel.maturity.toStringAsFixed(0),
                suffixIcon: Icon(Icons.edit),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
),
                                  ),
                                 Slider(
                                   activeColor: Colors.black,
                                   value: viewmodel.maturity,
              min: 3,
              max: 36,
              divisions: 12, onChanged: (double value) {
                FocusScope.of(context).requestFocus(viewmodel.f2);
               
                //var newvalue=value.round(); 
                viewmodel.setMaturity(value.toDouble());
                 viewmodel.setMaturityControllerText(viewmodel.maturity.toStringAsFixed(0));
               },
                                 ),
                                 //Text
                                 Padding(
                                   padding: const EdgeInsets.only(top:28.0),
                                   child: Center(child: Text("₺${viewmodel.amount.toStringAsFixed(0)} ${viewmodel.maturity.toStringAsFixed(0)} Ay Vadeli"),),
                                 ),
  //Button

  Container(
              margin: EdgeInsets.only(top:10),
              height: 50.0,
              child:ElevatedButton(
            style:  ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: BorderSide(color: Colors.red)
    )
  )
),
            onPressed: () async{
             // print(viewmodel.amount.toInt());
             // print(viewmodel.maturity.toInt());
              var amount=viewmodel.amount.toInt();
              var maturity=viewmodel.maturity.toInt();
               final _getOfferViewModel =
                  Provider.of<OfferViewModel>(context, listen: false);
                 var x= await _getOfferViewModel.getOffer(amount, maturity);
                 print(x);
            },
            child: const Text('TeklifimGelsin'),
          ),
            ),
   
                                  ],)
                                ),
                            )
                            : Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(pi),
                              child: Material(
                                type: MaterialType.transparency,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                              ),
                            ),
                      ),
                    ));
                  }),
            )
          ],
        )),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(Icons.navigation),
            onPressed: () {
              final _getOfferViewModel =
                  Provider.of<OfferViewModel>(context, listen: false);
             // _getOfferViewModel.getOffer();
            }),
      );
    });
  }
  
}
