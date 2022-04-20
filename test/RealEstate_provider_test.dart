
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentready/Providers_DataManager/RealEstate_provider.dart';

import 'package:rentready/Screens/HomePage.dart';

class MockRealEsate extends  Mock implements RealEstate{}

void main(){
 late RealEstate classSUT;
 late MockRealEsate mockProvider;
 late HomePage homeSUT;
 setUp((){
   classSUT=RealEstate();
   mockProvider=MockRealEsate();
   homeSUT=const HomePage();
 });
 test("test initial data",
         (){
      expect(classSUT.temp, []);
      expect(classSUT.isDataLoading, true);
         });
 group("test functions that get data from server", (){
   test("is there data", (){
     classSUT.getData();
     expect(classSUT.isDataLoading, true);
     expect(classSUT.temp.isNotEmpty, [].isNotEmpty);
   });
 });


}