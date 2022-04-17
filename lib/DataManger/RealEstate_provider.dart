

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:oauth_dio/oauth_dio.dart';
import '../Widgets/testJSONFile.dart';

class RealEstate extends ChangeNotifier{
bool isDataLoading=true;
List<Map> temp=[];
//List<Map> mapFromApi =[];
String apiToken="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImpTMVhvMU9XRGpfNTJ2YndHTmd2UU8yVnpNYyIsImtpZCI6ImpTMVhvMU9XRGpfNTJ2YndHTmd2UU8yVnpNYyJ9.eyJhdWQiOiJodHRwczovL29yZzg3YTY1ZDcxLmFwaS5jcm00LmR5bmFtaWNzLmNvbS8iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC83OTVlNGNmYy0yNjA4LTQ2Y2EtYTI0OS02MzEzNjdiZjU2ZTYvIiwiaWF0IjoxNjUwMTk0Mzk0LCJuYmYiOjE2NTAxOTQzOTQsImV4cCI6MTY1MDE5OTM3MiwiYWNyIjoiMSIsImFpbyI6IkFWUUFxLzhUQUFBQUhtcFJib2ZsdUJwWkhkajJRUkgrUlYxSFA3dzVDVGpDNVZ2WDdjeHVTeFoyczJkMDk5OHI1OWV3ai8yZ2ZoQ1V2endCS2t5d2gzMGlKaDZsc0NRZWNlbmVtdTNHTTFGdWNkYyt1SnQyM1RNPSIsImFtciI6WyJwd2QiLCJtZmEiXSwiYXBwaWQiOiI1MWY4MTQ4OS0xMmVlLTRhOWUtYWFhZS1hMjU5MWY0NTk4N2QiLCJhcHBpZGFjciI6IjAiLCJmYW1pbHlfbmFtZSI6IkhhbW91ZGVoIiwiZ2l2ZW5fbmFtZSI6Ik5vdXJFZGluIiwiaXBhZGRyIjoiNzguMTYzLjExNS4yNDciLCJuYW1lIjoiTm91ckVkaW4gSGFtb3VkZWgiLCJvaWQiOiI5Nzg5NWFlOS0wODNiLTRiZTQtYWZjNC01NzM2NDYzZDM3OWYiLCJwdWlkIjoiMTAwMzIwMDE1ODZDNTZEOCIsInJoIjoiMC5BWUVBX0V4ZWVRZ215a2FpU1dNVFo3OVc1Z2NBQUFBQUFBQUF3QUFBQUFBQUFBQ0JBSmsuIiwic2NwIjoidXNlcl9pbXBlcnNvbmF0aW9uIiwic3ViIjoiOEJIMEN1RkhjTFh5QmVBNE4wR2Z5TUd1NXpTZW5CSVl0S2JZS3RrSC1lcyIsInRpZCI6Ijc5NWU0Y2ZjLTI2MDgtNDZjYS1hMjQ5LTYzMTM2N2JmNTZlNiIsInVuaXF1ZV9uYW1lIjoiTm91ckVkZGluLkhhbW1vZGFAZmlyZWlkZWFzLmNvbSIsInVwbiI6Ik5vdXJFZGRpbi5IYW1tb2RhQGZpcmVpZGVhcy5jb20iLCJ1dGkiOiJqQnR4WUd2dVZFeTViV01FRXdGWUFBIiwidmVyIjoiMS4wIn0.ZU_17UsdpcFstBblSi9OOwyLgR_tjZimINTm4EAHFnvS0WyEaXr4TyhzW--AJX0vTeaLS2XUTTusWnXg54f6Z6jcgTY04Nythnw3yjERVt4G8uzaYF_S1zLiYydZouovzamqIvv9GzL0wc73YDYSC3rKMllOAKTk9ygc2zIkZ3Um-Gf1UeBNbacONOPzZNyyjgKIIrHfN3Aah5Wz8RrpnYT97Kw4iaAud3i40P2la9A9nsUZEmZaAfg5nAqI-nIROFjW4EU9W8hRqD6WaRp8fGkF5A5t5TKdFPwMvUfrR_9sjf2s743AAMU4n0dc56k3MYv7-6CRc2nPUT3lRc-iUw";
String url = 'https://org87a65d71.api.crm4.dynamics.com//api/data/v9.2/cr628_rentreadytables';
var response;
bool needAuth=false;
bool isFromLocal=true;

  getData<List>()async{
  Map<String, dynamic> headers = {
   "url": "https://org87a65d71.api.crm4.dynamics.com/",
   "clientid": "51f81489-12ee-4a9e-aaae-a2591f45987d",
   "version": "9.2",
   "webapiurl": "{{url}}/api/data/v{{version}}/",
   "callback": "https://callbackurl",
   "authurl": "https://login.microsoftonline.com/common/oauth2/authorize?resource={{url}}",
   "authorization": apiToken
  };

  try {
   response = await Dio().get(url,options: Options(
       headers: headers
   ));
   Map apiResponse = response.data;
   for(int i=0;i<apiResponse["value"].length;i++){
    temp.add({
     "image":apiResponse["value"][i]["cr628_image"],
     "title":apiResponse["value"][i]["cr628_title"],
     "description":apiResponse["value"][i]["cr628_description"],
     "state":apiResponse["value"][i]["cr628_state"],
     "accountNumber":apiResponse["value"][i]["cr628_accountnumber"].toString(),
     "owner":apiResponse["value"][i]["cr628_name"],
     "stateCode":apiResponse["value"][i]["cr628_statenumber"].toString(),
    }
    );
    isFromLocal=false;
   }
  } catch (e) {

    needAuth=true;
    notifyListeners();
   //debugPrint(e.toString());
  }
  isDataLoading=false;
  notifyListeners();
  return temp.isEmpty? dbData:temp;
}

refreshData() async {
  isDataLoading=true;
  notifyListeners();
  await getData();
}

}