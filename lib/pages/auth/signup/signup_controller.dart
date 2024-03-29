import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/pages/auth/auth_page.dart';
import 'package:flutter_practice/utils/utils.dart';
import 'package:get/get.dart';


class SignUpController extends GetxController {
   final signUpKey = GlobalKey<FormState>();
   final emailController = TextEditingController();
   final passController = TextEditingController();
   final nameController = TextEditingController();
   final postController = TextEditingController();

  get signUpVisible => null;

  Future signUp(BuildContext context) async {
    final isValid = signUpKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passController.text.trim(),
      );
      onTapSignIn(context);
    }
      on FirebaseAuthException catch (e) {
        print(e);
        Utils.showSnackBar(e.message);
    }
  }

    Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passController.text.trim(),
      );
    }
      on FirebaseAuthException catch (e) {
        print(e);
        Utils.showSnackBar(e.message);
    }
  }


  Future addToDB() async{
    final docUsers = FirebaseFirestore.instance.collection('users').doc();
    
    final jsonUser = {
      'username': nameController.text.trim(),
      'email' : emailController.text.trim(),
      'password' : passController.text.trim(),
      'post' : postController.text.trim(),
      'level': 'none',
    };

    await docUsers.set(jsonUser);
  }


  void onTapSignIn(BuildContext context){
    addToDB();
    Utils.showGreenSnackBar('Регистрация прошла успешно!');
    Navigator.pop(context);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthPage()
    // ));
  }
}
