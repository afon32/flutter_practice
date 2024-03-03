import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_practice/widgets/user_info.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.black,
    actions: [

      IconButton(
          tooltip: 'Пользователь', onPressed: () {userInfo(context);}, icon: const Icon(Icons.person)),
      IconButton(
          tooltip: 'Выход',
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          icon: const Icon(Icons.exit_to_app)),
    ],
    // leading: Image.asset(
    //         'assets/logo.png',
    //         fit: BoxFit.contain
    //       )
  );
}
