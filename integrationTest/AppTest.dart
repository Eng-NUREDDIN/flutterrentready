



import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:rentready/DataManger/RealEstate_provider.dart';
import 'package:rentready/HomePage.dart';
import 'package:integration_test/integration_test.dart';


void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Widget initialWidget(){
    return  MaterialApp(
      title: 'Rent Ready',
      home: ChangeNotifierProvider(
        create: (_)=>RealEstate(),
        child: HomePage(),
      ),
    );
  }

  testWidgets("grid view widget taped", (WidgetTester tester)async{
    await tester.pumpWidget(initialWidget());
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.grid_view));
    await tester.pump();
     expect(find.byType(GridView), findsWidgets);
  });
}