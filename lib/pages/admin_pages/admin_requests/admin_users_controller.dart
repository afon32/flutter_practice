import 'package:flutter/material.dart';
import 'package:flutter_practice/data/user.dart';
import 'package:flutter_practice/pages/admin_pages/admin_one_request/admin_one_request_page.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUsersPageController extends GetxController {
  final adminUsersPageKey = GlobalKey<FormState>();

  Stream<List<Userr>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data();
            data['id'] = doc.id;
            return Userr.fromJson(data);
          }).toList());

  Widget buildUser(Userr user) {
    if (user.email != 'master@mail.ru' && user.email != 'dsspec@mail.ru') {
      return ListTile(
        title: Text(user.name),
        subtitle: Text(user.post),
      );
    } else {
      return const SizedBox(
        height: 0.0,
      );
    }
  }

  void onTapOnRequest(Userr user) {
    Navigator.push(
      adminUsersPageKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => const AdminOneRegistrationPage(),
        settings: RouteSettings(
          arguments: user.toJson(),
        ),
      ),
    );
  }
}
