import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentready/Widgets/GridViewWidget.dart';
import 'package:rentready/Widgets/ListViewWidget.dart';
import 'package:http/http.dart' as http;
import 'DataManger/RealEstate_provider.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


//import 'Widgets/SearchBox.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool switchView=false;
  late final providerData=Provider.of<RealEstate>(context);
  final ValueNotifier<int> update = ValueNotifier<int>(0);
  String ?searchText;
  TextEditingController searchController=TextEditingController();
  List<Map> data=[];
  List<Map> dbData=[];
  String? token;
  String url = 'https://org87a65d71.api.crm4.dynamics.com//api/data/v9.2/cr628_rentreadytables';
  List<Map> mapTest =[];
  var response;

  @override
  void initState() {
   loginPage();
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      dbData= await Provider.of<RealEstate>(context, listen: false).getData();
      data=dbData;

    });
  }
  @override
  void dispose() {
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
  String loginUrl = "https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=51f81489-12ee-4a9e-aaae-a2591f45987d&response_type=code&redirect_uri=https://login.microsoftonline.com/common&response_mode=query&scope=User.Read";
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  late StreamSubscription _onDestroy;
  late StreamSubscription<String> _onUrlChanged;
  late StreamSubscription<WebViewStateChanged> _onStateChanged;
loginPage(){
  flutterWebviewPlugin.close();
  // Add a listener to on destroy WebView, so you can make came actions.
  _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
    //print("destroy");
  });

  _onStateChanged =
      flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
        //print("onStateChanged: ${state.type} ${state.url}");
      });

  // Add a listener to on url changed
  _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
    if (mounted) {
      setState(() {
        // print("URL changed: $url");
        if (url.startsWith("https://login.microsoftonline.com/common/oauth")) {
          RegExp regExp = new RegExp("#token&state==(.*)");
          this.token = regExp.firstMatch(url)?.group(1);
          Future.delayed(const Duration(milliseconds: 5000), () {
            setState(() {
              Provider.of<RealEstate>(context, listen: false).needAuth=false;
            });
          });

        }
      });
    }
  });
}
  @override
  Widget build(BuildContext context) {

    return Provider.of<RealEstate>(context, listen: true).needAuth==false? Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              toolsBar(),
              TextButton(onPressed: () async {
                if(Provider.of<RealEstate>(context, listen: false).isFromLocal!=true){
                  dbData.clear();
                  Provider.of<RealEstate>(context, listen: false).refreshData();
                  if(Provider.of<RealEstate>(context, listen: false).isFromLocal==true){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("token expired, this data is locally"),
                    ));
                }

                }


              }, child:const Text("Refresh")),
              Provider.of<RealEstate>(context, listen: true).isDataLoading==true?Center(child: CircularProgressIndicator(),)
                  :Expanded(
                key: Key("body widget"),
                    child:ValueListenableBuilder(valueListenable: update, builder: (BuildContext context, value, Widget? child) {
                    return body(switchView);
                  },)),
            ],
          ),
        ),
      ),
    )
        :new WebviewScaffold(
        url: loginUrl,
        appBar: new AppBar(
          title: new Text("Login to Microsoft To get Token"),
        ));;
  }
  Widget toolsBar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        searchBox("Search"),
        filterMenu(),
        //IconButton(onPressed: (){}, icon: const Icon(Icons.filter_alt_outlined)),
        IconButton(onPressed: (){switchView=false;update.value+=1; }, icon: const Icon(Icons.list)),
        IconButton(onPressed: (){switchView=true;update.value+=1;}, icon: const Icon(Icons.grid_view))

      ],
    );
  }
   body(bool viewSwitch){
     switch(viewSwitch){
      case true:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridViewWidget(data),
        );

      case false:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListViewWdiget(data),
        );

    }
  }
  Widget filterMenu(){
    return Expanded(
      child: DropdownButton(
        icon: const Icon(Icons.filter_alt),
        underline: SizedBox(),
        isExpanded: true,
        onChanged: (value) {
          switch (value){
            case "State":
              stateFilter();
              break;
            case "State Code":
              stateCodeFilter();
              break;
          }
        },
        items:<String>['State', 'State Code',].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),),
    );
  }
  Widget searchBox(String hintText){
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Container(
      width: width*0.6,
      height: height*0.07,
      decoration: BoxDecoration(
        //color: Colors.white,
        borderRadius: BorderRadius.circular( 7 ),

      ),

      child: TextFormField(
        textAlignVertical:TextAlignVertical.center ,
        textAlign: TextAlign.start,
        controller:searchController ,
        onChanged: (value){if(value.isEmpty){data=dbData;update.value+=1;}},
        decoration: InputDecoration(enabled: true,
          //enabledBorder:,
          //border: OutlineInputBorder(
          // borderSide: BorderSide(color: Colors.red, width: 1)),
          // focusedBorder: OutlineInputBorder(
          //  borderSide: BorderSide(color: Colors.green, width: 1)),
          hintText: hintText ,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(top: 10.0, left:5),
            child: Container(
              child:InkWell(child: const Icon(Icons.search,color: Colors.black,),onTap:()=> search(searchController.text),) ,
              height: 0.035,
              width: 0.075,
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 10.0, right:10),
        ),
      ),
    );
  }

  void search(String value) {
data=dbData.where((element) {
return ((element["accountNumber"].toString().contains(value.toString()))||(element["owner"].toString().contains(value.toString())));
}).toList();
update.value+=1;
  }
  stateFilter(){
    data.sort((a, b) => a["state"].compareTo(b["state"]));
    update.value+=1;
  }

  stateCodeFilter(){
    data.sort((a, b) => a["stateCode"].toString().compareTo(b["stateCode"].toString()));
    update.value+=1;
  }


}
