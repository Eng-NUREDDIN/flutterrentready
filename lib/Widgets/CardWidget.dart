

import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  bool isGrid;
   CardWidget(this.isGrid,{Key? key}) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  String src="https://thumbs.dreamstime.com/b/nice-new-apartment-building-night-view-city-mo-usa-nice-new-appartment-building-night-view-city-123686526.jpg";
  @override
  Widget build(BuildContext context) {
    return body(widget.isGrid);
  }
  Widget gridCard(){
    return body(widget.isGrid);
  }
  Widget listCard(){
    return Container(color: Colors.green,child: Text("nour"),);
  }
  body(bool view){
    switch (view){
      case true:
        return gridCard();

      case false:
        return listCard();
    }
  }
}
