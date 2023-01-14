import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebaseCore;
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadProgressController extends GetxController {
  var imagesUploaded = 0.obs;
  var isUploading = false.obs;

  static var fileName;
  void increment() => imagesUploaded++;
  var isDoneUploading = false.obs;
  var totalImagesToUpload = 0.obs;
}
final uploadProgressController = Get.put(UploadProgressController());
final ImagePicker imagePicker = ImagePicker();
List<XFile>? imageFiles = [];
final imagesDatabaseRef = FirebaseDatabase.instance.ref().child("images");
final datastoreRef = FirebaseStorage.instance.ref();
Future SelectAndUploadImages() async {
  final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
  if (selectedImages!.isNotEmpty) {
    debugPrint("Number of images selected = ${selectedImages.length}");
    //   int latestImageNumber =await getLastImageNumber();
    uploadProgressController.totalImagesToUpload.value = selectedImages.length;
    for (var image in selectedImages) {
      uploadProgressController.isUploading.value = true;
      File imageFileToUpload = await File(image.path); // selectedImages as Xfile
      String fileName = await basename(image.path); //getting file name from the path
      fileName = fileName.substring(12, fileName.length - 4); //removing "image_picker" from start and ".jpg" from the end of file name
      fileName=fileName.replaceAll(RegExp('[^A-Za-z0-9]'), '');// removing special characters expect alphabets and numbers
      debugPrint("FILE NAME IS : ${fileName}");
      try {
        await datastoreRef
            .child('images/${fileName}')
            .putFile(imageFileToUpload)
            .whenComplete(() async {
          // imagesUploaded++;
          uploadProgressController.increment();
          await datastoreRef
              .child('images/${fileName}')
              .getDownloadURL()
              .then((imageURL) async {
            debugPrint("DOWNLOAD URL: ${imageURL}");
            await imagesDatabaseRef.child("${fileName}").set({
              "imageName": "${fileName}",
              "dateUploaded": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
              "imageURL": "${imageURL}",
              "isCategorized":"false",
              "categoryId":"unknown",
            });
          }).whenComplete(() => () {
                    debugPrint(
                        "Image Data saved to Realtime Database: ${fileName}");
                  });
        });
      } on firebaseCore.FirebaseException catch (e) {
        debugPrint("Error in Uploading File $e");
      }
    }
    uploadProgressController.isUploading.value = false;
    uploadProgressController.isDoneUploading.value = true;
  } else {
    debugPrint("No picture Selected");
  }
}
