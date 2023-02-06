import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb2/consts/firebases_const.dart';
import 'package:fb2/services/response.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CartItemServices {
  getCartItems() {
    return firestore.collection(carts).snapshots();
  }

  createItemRecord({name, price}) async {
    Response response = Response();
    DocumentReference documentReference = firestore.collection(carts).doc();

    var result = await documentReference
        .set({"name": name, "price": price}).whenComplete(() {
      response.code == 200;
      response.message == "Succesfully added to database";
    }).catchError((e) {
      response.code == 500;
      response.message = e;
    });
    return response;
  }

  uploadImage({fileName, filePath}) async {
    String fileTime = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    Reference referenceImageToUpload =
        referenceDirImages.child("${fileName}-$fileTime");

    try {
      await referenceImageToUpload.putFile(File(filePath));

      return await referenceImageToUpload.getDownloadURL();
    } catch (e) {}
  }
}
