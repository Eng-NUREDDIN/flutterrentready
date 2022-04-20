import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;
import 'package:intl/intl.dart';

class AddDataMethods{
  getFullDateWithSeconds() {
    final now = DateTime.now();
    String fullDate = DateFormat('yyyy-MM-dd h:mm:ss').format(now);
    return fullDate;
  }

  Future<String> uploadImage(Reference ref,XFile imageFile) async {
    String timeStamp="${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().microsecond}";
    String link="https://thumbs.dreamstime.com/b/nice-new-apartment-building-night-view-city-mo-usa-nice-new-appartment-building-night-view-city-123686526.jpg";
    //firebase_storage.UploadTask uploadTask;
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': imageFile.path});
    final uploadTask =await ref.putFile(io.File(imageFile.path), metadata).then((value) async {

      link = await ref.getDownloadURL();

    });
    return link;
  }
}