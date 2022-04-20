import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rentready/Screens/HomePage.dart';
import 'package:rentready/Utilities/AddData_Methods.dart';
import '../Providers_DataManager/RealEstate_provider.dart';
import '../Widgets/TextBox.dart';

import 'dart:io';
import 'dart:io' as io;
class AddData extends StatefulWidget with AddDataMethods {
  bool edit;
  int ?index;
  String? image;
  String ?title;String ?description;String ?owner;String ?accountNumber;String ?state;String ?stateCode;
  String ?dataKey;
   AddData(this.edit,{this.image,this.title,this.description,this.owner,this.accountNumber,this.state,this.stateCode,this.dataKey,this.index,Key? key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController titleController=TextEditingController();
  TextEditingController decController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController codeController=TextEditingController();
  TextEditingController stateController=TextEditingController();
  TextEditingController stateCodeController=TextEditingController();
  XFile? imageFile;

  @override
  void initState() {
    if(widget.edit==true){
      titleController.text=widget.title!;
      decController.text=widget.description!;
      nameController.text==widget.owner;
      codeController.text=widget.accountNumber!;
      stateCodeController.text=widget.stateCode!;
      stateController.text=widget.state!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   SizedBox(width: width*0.01,),
                  IconButton(icon:Icon (Icons.arrow_back_outlined,color: Colors.green), onPressed: () {
                    Navigator.pop(context);
                  },)
                 , SizedBox(width: width*0.18,)
                  ,Container(
                    alignment: Alignment.center,
                    width: width*0.4,
                    height: height*0.05,
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.5),
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
                    child: Text("Add Data"),
                  ),
                  Spacer()
                ],
              )
              ,Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.5),
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
                alignment: Alignment.center,
                width: width*0.8,
                height: height*0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextBox(controller: titleController,hintText:widget.edit==true?widget.title:"title"),
                    TextBox(controller: decController,hintText:widget.edit==true?widget.description: "description"),
                    TextBox(controller: nameController,hintText:widget.edit==true?widget.owner: "owner"),
                    TextBox(controller: codeController,hintText:widget.edit==true?widget.accountNumber: "accountNumber"),
                    TextBox(controller: stateController,hintText:widget.edit==true?widget.state: "state"),
                    TextBox(controller: stateCodeController,hintText:widget.edit==true?widget.stateCode: "stateCode"),
                    TextButton(onPressed: () async {
                      imageFile= await ImagePicker().pickImage(source: ImageSource.gallery);
                      if(imageFile!=null){
                        setState(() {

                        });
                      }

                    }, child:Container(alignment: Alignment.center,width:width*0.7,height: height*0.2,decoration:  BoxDecoration(
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
                    ),child: Container(
                      width: width*0.7,
                      height: height*0.2,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        image: DecorationImage(
                          image:widget.image==null?AssetImage("Images/defaultNewPost.png"):NetworkImage(widget.image!) as ImageProvider ,
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: imageFile==null?Icon(Icons.add_circle_outline_outlined):Image.file(File((imageFile)!.path)),
                    ))),
                  ],
                ),
              ),
              TextButton(onPressed: () async {
                  addData();
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
              ),child: const Text("Submit"))),
            ],
          ),
        ),
      ),
    );
  }

  addData() async {
    Reference imageRef= FirebaseStorage.instance.ref().child("DataImage").child(AddDataMethods().getFullDateWithSeconds());
    if(widget.edit==true){
      if(imageFile!=null){
        String image =await AddDataMethods().uploadImage(imageRef,imageFile!);
        await Provider.of<RealEstate>(context, listen: false).editData(image, titleController.text, decController.text,
            nameController.text, codeController.text, stateController.text, stateCodeController.text, widget.dataKey!, widget.index!);
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) =>
                HomePage( )));
      }
      else{
        await Provider.of<RealEstate>(context, listen: false).editData(widget.image!, titleController.text, decController.text,
            nameController.text, codeController.text, stateController.text, stateCodeController.text, widget.dataKey!, widget.index!);
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) =>
                HomePage( )));
      }
    }else{
      String image =await AddDataMethods().uploadImage(imageRef,imageFile!);
   await Provider.of<RealEstate>(context, listen: false).createNewData(image, titleController.text, decController.text,
      nameController.text, codeController.text, stateController.text, stateCodeController.text);
  Navigator.pop(context);
  Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) =>
          HomePage( )));

}}


}
