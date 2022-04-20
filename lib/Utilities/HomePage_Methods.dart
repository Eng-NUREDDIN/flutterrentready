import 'package:rentready/Screens/HomePage.dart';

class HomePageMethods {

 List<Map> stateCodeFilter(List<Map> data){
    data.sort((a, b) => a["stateCode"].toString().compareTo(b["stateCode"].toString()));
    return data;
  }

  List<Map> stateFilter(List<Map> data){
    data.sort((a, b) => a["state"].compareTo(b["state"]));
    return data;
  }

  List<Map> search(String value,List<Map> dbData) {
    List<Map> data  =dbData.where((element) {
      return ((element["accountNumber"].toString().contains(value.toString()))||(element["owner"].toString().contains(value.toString())));
    }).toList();
   return data;
  }

}