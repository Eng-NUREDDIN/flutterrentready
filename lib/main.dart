import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers_DataManager/RealEstate_provider.dart';
import 'package:rentready/Screens/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<RealEstate>(
    create: (_)=>RealEstate(),
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Rent Ready',
      home: ChangeNotifierProvider<RealEstate>(
      create: (_)=>RealEstate(),
        child: const HomePage(),
      ),
    );
  }
}


