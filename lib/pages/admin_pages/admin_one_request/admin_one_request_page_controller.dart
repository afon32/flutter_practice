import 'package:flutter_practice/data/user.dart';
import 'package:flutter_practice/pages/admin_pages/admin_home/admin_home_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminOneRegistrationPageController extends GetxController {
  Userr user = Userr(id: '', email: '', name: '', post: '', level: '');
  final levelList = ['A', 'B', 'C', 'D'];
  String selectedItem = 'A';

  final adminOneRegistrationPageKey = GlobalKey<FormState>();

  void loadData(BuildContext context) {
    final Map<String, dynamic> jsonData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    user = Userr.fromJson(jsonData);
  }

  Future<void> updateUser() async {
    await FirebaseFirestore.instance.collection('users').doc(user.id).update({
      'username': user.name,
      'post': user.post,
      'email': user.email,
      'level': selectedItem
    });
  }

    void nextPage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Уровень доступа установлен'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    ));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHomePage(),
          ));
    
  }

}
