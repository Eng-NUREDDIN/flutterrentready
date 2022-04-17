import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:rentready/DataManger/RealEstate_provider.dart';
import 'package:rentready/HomePage.dart';
import 'package:rentready/Widgets/ListViewWidget.dart';

void main(){
  setUp((){});
  Widget initialWidget(){
    return  MaterialApp(
      title: 'Rent Ready',
      home: ChangeNotifierProvider(
        create: (_)=>RealEstate(),
        child: HomePage(),
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