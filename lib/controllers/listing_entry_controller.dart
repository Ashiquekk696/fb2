import 'package:fb2/services/cart_items_services.dart';
import 'package:fb2/services/firestore_services.dart';
import 'package:fb2/services/response.dart' as res;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ListingEntryController extends GetxController {
  TextEditingController nameController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  CartItemServices cartItemServices = CartItemServices();
 XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
 
      image = img;
 
  }

  addItem() async {
    return cartItemServices.createItemRecord(
        name: nameController.text, price: priceController.text);
  }
}
