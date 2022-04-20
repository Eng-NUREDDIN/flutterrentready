

import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:oauth_dio/oauth_dio.dart';
import '../Widgets/testJSONFile.dart';

class RealEstate extends ChangeNotifier{
bool isDataLoading=true;
List<Map> temp=[];
bool isFromLocal=true;
bool noData=false;
DatabaseReference dataRef =FirebaseDatabase.instance.ref("Data");


  getData<List>()async{
    temp.clear();
dataRef.once().then((value) {
  value.snapshot.value;
});
    try {
      await dataRef.once().then((value) {
        if (value.snapshot.exists) {
          Map apiResponse = value.snapshot.value as dynamic;
          apiResponse.forEach((key, value) {
            temp.add({
              "image": value["image"],
              "title": value["title"],
              "description": value["description"],
              "state": value["state"],
              "accountNumber": value["accountNumber"] .toString(),
              "owner": value["owner"],
              "stateCode": value["stateCode"] .toString(),
              "key":value[ "key"]
            }
            );
          });

          if(apiResponse.length==temp.length){
            if(temp.isEmpty){
              noData=true;
              notifyListeners();
            }
            isFromLocal=false;
            isDataLoading=false;
            notifyListeners();
            return temp;
          }
        }});
    } catch (e) {
      //debugPrint(e.toString());
    }
  }

deleteData(int index, String key){
    temp.removeAt(index);
    dataRef.child(key).remove();
    notifyListeners();
}
  editData(String image,String title,String description,String owner,String accountNumber,String state,String stateCode,String key,int index) async {
    await dataRef.child(key).set({
      "image": image,
      "title": title,
      "description": description,
      "state": state,
      "accountNumber": accountNumber .toString(),
      "owner": owner,
      "stateCode": stateCode.toString(),
      "key":key
    });
notifyListeners();
  }


createNewData(String image,String title,String description,String owner,String accountNumber,String state,String stateCode) async {
  String? key=await dataRef.push().key;
  await dataRef.child(key!).set({
    "image": image,
    "title": title,
    "description": description,
    "state": state,
    "accountNumber": accountNumber .toString(),
    "owner": owner,
    "stateCode": stateCode.toString(),
    "key":key
  });
  temp.add(
      {
        "image": image,
        "title": title,
        "description": description,
        "state": state,
        "accountNumber": accountNumber .toString(),
        "owner": owner,
        "stateCode": stateCode.toString(),
        "key":key
      }
  );
notifyListeners();
}

}