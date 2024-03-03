import 'package:flutter/material.dart';
import 'package:flutter_practice/data/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Userr ourUser =
    Userr(email: 'wait...', name: 'wait...', post: 'wait...', level: 'wait...');

Stream<List<Userr>> readUsers() => FirebaseFirestore.instance
    .collection('users')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          data['id'] = doc.id;
          //print(data['post']);
          return Userr.fromJson(data);
        }).toList());

Future searchUser() async {
  List<Userr> users = await readUsers().first;
  if (users.isNotEmpty) {
    for (Userr user in users) {
      if (user.email == FirebaseAuth.instance.currentUser!.email) {
        //print('${user.name}  ${user.email}, ${user.post}');
        //return user;
        ourUser = user;
      }
    }
  }
}

void userInfo(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
            future: searchUser(),
            
            builder: (context, snapshot) {
              // if (snapshot.hasData){
              return AlertDialog(
                title: const Text('Пользователь'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Имя: ${ourUser.name}')),
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Должность: ${ourUser.post}')),
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Уровень доступа: ${ourUser.level}')),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Закрыть'),
                  ),
                ],
              );
              // }
              // else {
              //   return CircularProgressIndicator();
              // }
            });
      });
}
