import 'package:fb2/consts/firebases_const.dart';
import 'package:fb2/controllers/auth_controller.dart';
import 'package:fb2/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class LoginView extends GetView<AuthController> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("curr${currentUser?.uid}");
    var userController = Get.put(AuthController());

    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(label: Text("Email")),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(label: Text("password")),
          ),
          ElevatedButton(
              onPressed: () {
                controller
                    .loginMethod(
                        email: emailController.text,
                        password: passwordController.text)
                    .then((value) {
                  print(value);
                  Get.to(HomePage());
                });
              },
              child: Text("Login"))
        ],
      )),
    );
  }
}
