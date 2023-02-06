import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb2/services/response.dart';

import '../consts/firebases_const.dart';

class FirestoreServices {
  static getUserId(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getGentsItems() {
    print(
        "firestore data ${currentUser?.displayName}${firestore.collection(gentsCollection).snapshots()}");
    return firestore.collection(gentsCollection);
  }

  // static getCartData() {
  //   return firestore.collection(cartsList).snapshots();
  // }

 
}
