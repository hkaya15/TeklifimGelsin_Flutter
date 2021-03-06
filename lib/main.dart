import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teklifimgelsin/locator.dart';
import 'package:teklifimgelsin/ui/GetOffer/view/getoffer.dart';
import 'package:teklifimgelsin/ui/GetOffer/viewmodel/getoffer_viewmodel.dart';

void main() {
  runApp(const MyApp());
  setupLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OfferViewModel()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Teklifim Gelsin',
          theme: ThemeData(
            primarySwatch: Colors.cyan,
          ),
          home: const GetOffer()),
    );
  }
}
