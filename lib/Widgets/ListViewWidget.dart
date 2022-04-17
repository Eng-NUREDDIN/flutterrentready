import 'package:flutter/material.dart';

import 'CardWidget.dart';

class ListViewWdiget extends StatefulWidget {
  List <Map> data;
   ListViewWdiget(this.data,{Key? key}) : super(key: key);

  @override
  State<ListViewWdiget> createState() => _ListViewWdigetState();
}

class _ListViewWdigetState extends State<ListViewWdiget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: widget.data.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, index){
          return card(widget.data[index]["image"],widget.data[index]["title"],widget.data[index]["description"]
              ,widget.data[index]["owner"],widget.data[index]["accountNumber"],widget.data[index]["state"],widget.data[index]["stateCode"]);
           // Container(color:Colors.red,child: Text("data"));
            //CardWidget( true);
        }, separatorBuilder: (BuildContext context, int index) {
        return Padding(
            padding: EdgeInsets.only(top: 10));



      },

      ),
    );
  }
  Widget card(String image,String title,String description,String owner,String accountNumber,String state,String stateCode){
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        detailsView( image, title, description);
      },
      child: Container(
        width: double.infinity,
        height: height*0.13,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 2,
                //offset: Offset(0, 3), // changes position of shadow
              )
            ]),
        padding: EdgeInsets.all(5),
        child: Row(
         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(child: ClipRRect( borderRadius: BorderRadius.circular(15),child: Image.network(image))),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Container(
                      width: width*0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(title),
                          Text("$owner/${accountNumber.toString()}"),
                        ],
                      ),
                    )
                    ,Text(description)
                    ,Container(
                      width: width*0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(state),
                          Text("Code: ${stateCode.toString()}"),


                        ],
                      ),
                    )]
              ),
            ),
          ],
        ),
      ),
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
