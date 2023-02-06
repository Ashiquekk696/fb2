import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb2/consts/firebases_const.dart';
import 'package:fb2/controllers/auth_controller.dart';
import 'package:fb2/services/cart_items_services.dart';
import 'package:fb2/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController userNameCOntroller = TextEditingController();
    var contoller = Get.put(AuthController());
    print("curr${currentUser?.uid}");
    return Scaffold(
        body: StreamBuilder(
      stream: CartItemServices().getCartItems(),
      // stream: FirestoreServices.getCartData(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == null) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          return Container(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data?.docs.length ?? 0,
                        itemBuilder: (context, i) {
                          var data = snapshot.data!.docs[i];
                          return Column(
                            children: [
                              SizedBox(
                                height: 66,
                              ),
                              Card(
                                child: Container(
                                  width: 333,
                                  height: 122,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text("Item name"),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text(data['name'] ?? ""),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text("Prize"),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text(data['price'] ?? ""),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  TextField(
                    controller: userNameCOntroller,
                    decoration: InputDecoration(label: Text("price")),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(label: Text("password")),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        contoller.updateProfile(
                            name: userNameCOntroller.text,
                            password: passwordController.text);
                      },
                      child: Text("Edit profile"))
                ],
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    ));
  }
}
