import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentready/DataManger/RealEstate_provider.dart';
import 'package:rentready/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Rent Ready',
      home: ChangeNotifierProvider(
      create: (_)=>RealEstate(),
        child: HomePage(),
      ),
    );
  }
}


