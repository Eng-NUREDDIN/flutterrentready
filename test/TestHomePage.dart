import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:rentready/Providers_DataManager/RealEstate_provider.dart';

import 'package:rentready/Screens/HomePage.dart';
import 'package:rentready/ViewModels/ListViewWidget.dart';
import 'package:rentready/main.dart';

void main(){
  setUp((){});
  Widget initialWidget(){
    return  MaterialApp(
      title: 'Rent Ready',
      home: ChangeNotifierProvider(
        create: (_)=>RealEstate(),
        child: MyApp(),
      ),
    );
  }
  testWidgets("tools bar", (WidgetTester tester)async{
    await tester.runAsync(() async {
      await tester.pumpWidget(initialWidget());
      expect(find.widgetWithIcon(IconButton, Icons.grid_view), findsWidgets);
    });

  });
  testWidgets("CircularProgressIndicator", (WidgetTester tester)async{
    await tester.runAsync(() async {
      await tester.pumpWidget(initialWidget());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

  });

  testWidgets("List view widget", (WidgetTester tester)async{
    await tester.runAsync(() async {
      await tester.pumpWidget(initialWidget());
      await tester.pump();
      expect(find.byType(Expanded), findsWidgets);
    });

  });

}