import 'package:fb2/consts/firebases_const.dart';
import 'package:fb2/controllers/auth_controller.dart';
import 'package:fb2/main.dart';
import 'package:fb2/views/home_view.dart';
import 'package:fb2/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class SignUPView extends GetView<AuthController> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userController = Get.put(AuthController());

    return Scaffold(
      body: Obx(
        () => Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userNameController,
              decoration: InputDecoration(label: Text("Username")),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(label: Text("Email")),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(label: Text("password")),
            ),
            controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      controller
                          .signUpMethod(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        print("new user is ${currentUser?.uid}");
                        controller.storeUserData(
                            email: emailController.text,
                            password: passwordController.text,
                            username: userNameController.text);

                        controller.isLoading.value = false;
                      }).then((value) {
                        Get.offAll(() => LoginView());
                      });
                    },
                    child: Text("Sign up")),
            SizedBox(
              height: 44,
            ),
            GestureDetector(
              onTap: () {
                Get.to(LoginView());
              },
              child: Text("Already have an account"),
            )
          ],
        )),
      ),
    );
  }
}
