
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentready/Screens/AddData.dart';
import 'package:rentready/Utilities/HomePage_Methods.dart';
import 'package:rentready/ViewModels/GridViewWidget.dart';
import 'package:rentready/ViewModels/ListViewWidget.dart';


import '../Providers_DataManager/RealEstate_provider.dart';







class HomePage extends StatefulWidget with HomePageMethods{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  {
  bool switchView=false;
  late final providerData=Provider.of<RealEstate>(context);
  final ValueNotifier<int> update = ValueNotifier<int>(0);
  TextEditingController searchController=TextEditingController();
  List<Map> data=[];
  List<Map> dbData=[];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
       await Provider.of<RealEstate>(context, listen: false).getData();
      dbData=Provider.of<RealEstate>(context, listen: false).temp;
      data=dbData;


    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              toolsBar(),
              Provider.of<RealEstate>(context, listen: true).isDataLoading==true?Center(child: CircularProgressIndicator(),)
                  :Provider.of<RealEstate>(context, listen: true).noData==true?Center(child:Text("No Data")):Expanded(
                key: Key("body widget"),
                    child:ValueListenableBuilder(valueListenable: update, builder: (BuildContext context, value, Widget? child) {
                    return body(switchView);
                  },)),
              TextButton(onPressed: () async {
                Navigator.of(context).push( MaterialPageRoute(
                    builder: (ctx) =>  AddData( false)));



              }, child:Container(alignment: Alignment.center,width:80,height: 30,decoration:  BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),child: const Text("Add"))),
            ],
          ),
        ),
      ),
    );
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
              data= HomePageMethods().stateCodeFilter(data);
              update.value+=1;
              break;
            case "State Code":
             data= HomePageMethods().stateFilter(data);
             update.value+=1;
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
          hintText: hintText ,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(top: 10.0, left:5),
            child: Container(
              child:InkWell(child: const Icon(Icons.search,color: Colors.black,),onTap:() {
                data=HomePageMethods().search(searchController.text, dbData);
                update.value+=1;
                //search(searchController.text);
              },) ,
              height: 0.035,
              width: 0.075,
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 10.0, right:10),
        ),
      ),
    );
  }









}
