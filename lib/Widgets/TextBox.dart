
import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final TextEditingController controller;

  String ?hintText;
   TextBox({required this.controller,this.hintText,Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      height: 40,
       decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.5),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
           child: TextFormField(
             controller: controller,
             decoration: new InputDecoration.collapsed(
                 hintText: hintText,
             ),

           ),

    );
  }
}
