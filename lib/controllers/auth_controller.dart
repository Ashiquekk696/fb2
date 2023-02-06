import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb2/consts/firebases_const.dart';
import 'package:fb2/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  Future<UserCredential?> loginMethod({email, password}) async {
    UserCredential? userCredential;

    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("", e.toString());
    }
  }

  Future<UserCredential?> signUpMethod({email, password}) async {
    UserCredential? userCredential;
    isLoading.value = true;
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await Future.delayed(Duration(seconds: 5));
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString());

      isLoading.value = false;
    }
    return userCredential;
  }

  storeUserData({username, email, password}) async {
    DocumentReference store =
        await firestore.collection(usersCollection).doc(currentUser?.uid);
    store.set({
      'name': username,
      "password": password,
      "email": email,
      "imageUrl": "",
      "id": currentUser?.uid
    });
  }

  updateProfile({name, password}) async {
    isLoading(true);
    var store = firestore.collection(usersCollection).doc(currentUser?.uid);
    store.set({"name": name, "password": password}, SetOptions(merge: true));
    isLoading(false);
  }

  void onInit() {
    FirestoreServices.getGentsItems();
    super.onInit();
  }

  signOut() async {
    await firebaseAuth.signOut();
  }
}
