import 'package:flutter/material.dart';
import 'package:flutter_practice/data/user.dart';
import 'package:flutter_practice/pages/admin_pages/admin_one_request/admin_one_request_page.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AdminRequestPageController extends GetxController{

  final adminRequestPageKey = GlobalKey<FormState>();

  Stream<List<Userr>> readUsers() =>
    FirebaseFirestore.instance
    .collection('users')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          data['id'] = doc.id; 
          return Userr.fromJson(data);
        }).toList());

  Widget buildUser(Userr user){
    if (user.level == 'none'){
      return ListTile(
        title: Text(user.name),
        subtitle: Text(user.post),
      );
    }
    else{
      return const SizedBox(height: 0.0,);
    }
  }

   void onTapOnRequest(Userr user){
    Navigator.push(
      adminRequestPageKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => const AdminOneRegistrationPage(),
        settings: RouteSettings(
          arguments: user.toJson(),
        ),
      ),
    );
  }
}