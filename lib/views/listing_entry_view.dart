import 'dart:io';

import 'package:fb2/controllers/listing_entry_controller.dart';
import 'package:fb2/services/cart_items_services.dart';
import 'package:fb2/services/firestore_services.dart';
import 'package:fb2/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ListingEntryView extends GetView<ListingEntryController> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ListingEntryController());
    controller.nameController.text = "Name";
    controller.priceController.text = "Price";
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 13,
          ),
          TextFieldWidget(
            controller: controller.nameController,
            //label: "Name",
          ),
          SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            controller: controller.priceController,
            // label: "price",
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              controller.getImage(ImageSource.gallery);
            },
            child: Container(
              height: 40,
              width: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Center(child: Text("Select image")),
            ),
          ),
          controller.image != null
              ? Container(
                  height: 40,
                  width: 40,
                  child: Image.file(File(controller.image?.path ?? "")),
                )
              : Container(),
          ElevatedButton(
              onPressed: () async {
                var response = await CartItemServices().createItemRecord(
                    name: controller.nameController.text,
                    price: controller.priceController.text);
                // showDialog(
                //     context: context,
                //     builder: (_) {
                //       return Container(
                //         child: Text(response.message),
                //       );
                //     });
              },
              child: Text("ADD ITEM"))
        ],
      ),
    );
  }
}
