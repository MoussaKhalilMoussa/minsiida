import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  // textControllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<void> loginMethod({context}) async {
    /*  UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential; */
  }

  //signup method

  Future<void> signupMethod({email, password, context}) async {
    /* UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential; */
  }

  // storing data method
  storeUserData({name, password, email}) async {
    /* 
    DocumentReference store = firestore
        .collection(usersCollection)
        .doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser!.uid,
      'cart_count': "00",
      'whishlist_count': "00",
      'order_count': "00",
    }); */
  }

  //signout method
  signoutMethod(context) async {
    /* try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    } */
  }
}
