import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  TextEditingController? searchController = TextEditingController();
  void Function(String)? onChanged;
  void Function()? onEditingComplete;
  Widget? rightIcon;
  String? hintText;
  void Function()? searchOnTap;
   SearchBox({this.searchController,this.onChanged,this.onEditingComplete,this.rightIcon,this.hintText,this.searchOnTap}) ;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
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
        controller:widget.searchController ,
        onEditingComplete: widget.onEditingComplete,
        onChanged: widget.onChanged,
        decoration: InputDecoration(enabled: true,
          //enabledBorder:,
          //border: OutlineInputBorder(
             // borderSide: BorderSide(color: Colors.red, width: 1)),
         // focusedBorder: OutlineInputBorder(
            //  borderSide: BorderSide(color: Colors.green, width: 1)),
          hintText: widget.hintText ,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(top: 10.0, left:5),
            child: Container(
              child:InkWell(child: const Icon(Icons.search,color: Colors.black,),onTap:()=> widget.searchOnTap,) ,
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
