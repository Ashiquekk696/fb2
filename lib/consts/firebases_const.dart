import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

User? currentUser = firebaseAuth.currentUser;

const usersCollection = "Users";
const gentsCollection = "gents";
const cartsList = 'cartsList';
const carts = 'carts';
