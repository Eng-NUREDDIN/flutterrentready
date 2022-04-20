import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentready/Widgets/CardWidget.dart';

import '../Providers_DataManager/RealEstate_provider.dart';
import '../Screens/AddData.dart';

class GridViewWidget extends StatefulWidget {
  List<Map> data;
   GridViewWidget(this.data, {Key? key}) : super(key: key);

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
          itemCount: widget.data.length,
      itemBuilder: (BuildContext context, index){
        return  card(widget.data[index]["image"],widget.data[index]["title"],widget.data[index]["description"]
            ,widget.data[index]["owner"],widget.data[index]["accountNumber"],
            widget.data[index]["state"],widget.data[index]["stateCode"],widget.data[index]["key"],index);
      }),
    );
  }
  Widget card(String image,String title,String description,String owner,String accountNumber,String state,String stateCode,String key,int index){
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        detailsView( image, title, description);
      },
      child: Container(
        //width: width*0.4,
       // height: height*0.2,
        decoration: BoxDecoration(
            color: Colors.white,
           image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
           ),
        padding: EdgeInsets.all(5),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textWithBackground("$owner/${accountNumber.toString()}"),
                textWithBackground(state),

              ],
            ),
            textWithBackground(title)
            ,textWithBackground(description),
            Row(
              children: [
                textWithBackground(stateCode.toString()),
                Spacer(),
                IconButton(onPressed: (){
                  Provider.of<RealEstate>(context, listen: false).deleteData(index,key);

                }, icon: Icon(Icons.delete,color: Colors.white)),
                IconButton(onPressed: (){

                  Navigator.of(context).push( MaterialPageRoute(
                      builder: (ctx) =>  AddData( true,index: index,title: title,description: description,
                        state: state,stateCode: stateCode,image: image,
                        owner: owner,accountNumber: accountNumber,dataKey: key,
                      )));
                }, icon: Icon(Icons.edit,color: Colors.white,)),

              ],
            )
          ],
        ),
      ),
    );
  }
  Widget textWithBackground(String text){
    return Container(
      padding: EdgeInsets.all(5),
      color: Colors.blueAccent.withOpacity(0.8),
      child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
    );
  }
  Future detailsView(String image,String title,String description){
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
   return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: Container(
            // height: H*0.6,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: height * 0.01),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 40,
                      bottom: 10,
                      left: 10,
                      right: 10,
                    ),
                    margin: EdgeInsets.only(top: 50),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // To make the card compact
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              title,
                              textAlign: TextAlign.justify,
                          ),
                        ),
                        SingleChildScrollView(
                          child: Text(
                            description,
                             softWrap: true,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 24.0),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(); // To close the dialog
                            },
                            child: Text(
                              "Ok",
                              style: TextStyle(color: Colors.amber),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                            child: Image.network(
                              image,
                              fit: BoxFit.fill,
                            ))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
