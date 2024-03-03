import 'package:flutter/material.dart';
import 'package:flutter_practice/api/local_auth_api.dart';
import 'package:flutter_practice/data/user.dart';
import 'package:flutter_practice/pages/admin_pages/admin_documents/admin_documents_page.dart';
import 'package:flutter_practice/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectLevelAndCategoryOfDocPage extends StatefulWidget {
  const SelectLevelAndCategoryOfDocPage({super.key});

  @override
  State<SelectLevelAndCategoryOfDocPage> createState() =>
      _SelectLevelAndCategoryOfDocPage();
}

class _SelectLevelAndCategoryOfDocPage
    extends State<SelectLevelAndCategoryOfDocPage> {
  String? selectedCategory = 'Security';
  String? selectedLevel = 'A';
  final categories = ['Security', 'Medicine', 'IT', 'KB'];
  List<String> levels = ['A'];
  bool isLoaded = true;

  Stream<List<Userr>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data();
            data['id'] = doc.id;
            return Userr.fromJson(data);
          }).toList());

  Future searchLevelOfUser() async {
    List<Userr> users = await readUsers().first;
    if (users.isNotEmpty) {
      for (Userr user in users) {
        if (user.email == FirebaseAuth.instance.currentUser!.email) {
          return user.level;
        }
      }
    }
  }

  Future inspectLevelOfUser() async {
    String levelOfUser = await searchLevelOfUser();
    switch (levelOfUser) {
      case 'A':
        levels = ['A'];
        break;
      case 'none':
        levels = ['A'];
        break;
      case 'B':
        levels = ['A', 'B'];
        break;
      case 'C':
        levels = ['A', 'B', 'C'];
        break;
      case 'D':
        levels = ['A', 'B', 'C', 'D'];
        break;
    }
  }

  @override
  void didChangeDependencies() {
    if (isLoaded) {
      inspectLevelOfUser();
      super.didChangeDependencies();
      isLoaded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: FutureBuilder(
            future: inspectLevelOfUser(),
            builder: (context, snapshot) {
              return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ColoredBox(
                      color: const Color.fromARGB(255, 240, 193, 26),
                      child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: const Color.fromARGB(
                                                  255, 137, 148, 160)),
                                          child: const Text(
                                              'Выберите категорию документа:'),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                right: 5.0, left: 5.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: const Color.fromARGB(
                                                    255, 137, 148, 160)),
                                            child: DropdownButton<String>(
                                              value: selectedCategory,
                                              icon: const Icon(
                                                  Icons.arrow_downward),
                                              elevation: 16,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              underline: Container(
                                                height: 2,
                                                color: const Color.fromARGB(
                                                    255, 226, 103, 0),
                                              ),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedCategory = value!;
                                                });
                                                print(selectedCategory);
                                              },
                                              items: categories.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          )),
                                    ])),

//Выбор уровня доступа

                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: const Color.fromARGB(
                                                  255, 137, 148, 160)),
                                          child: const Text(
                                              'Выберите уровень доступа:'),
                                        ),
                                      ),
                                      Row(children: [
                                        Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0, left: 5.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: const Color.fromARGB(
                                                      255, 137, 148, 160)),
                                              child: DropdownButton<String>(
                                                value: selectedLevel,
                                                icon: const Icon(
                                                    Icons.arrow_downward),
                                                elevation: 16,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                underline: Container(
                                                  height: 2,
                                                  color: const Color.fromARGB(
                                                      255, 226, 103, 0),
                                                ),
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    selectedLevel = value!;
                                                  });
                                                  print(selectedLevel);
                                                },
                                                items: levels.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            )),
                                      ]),
                                    ])),
// Подтверждение
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (selectedLevel == 'C' ||
                                        selectedLevel == 'D') {
                                      final isAuth = await LocalAuthApi
                                          .authenticateMethod();
                                      if (isAuth) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminDocumentsPage(),
                                                settings: RouteSettings(
                                                  arguments:
                                                      '$selectedLevel/$selectedCategory',
                                                )));
                                      }
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AdminDocumentsPage(),
                                              settings: RouteSettings(
                                                arguments:
                                                    '$selectedLevel/$selectedCategory',
                                              )));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 226, 103, 0)),
                                  child: const Text('Подтвердить')),
                            )
                          ]))));
            }));
  }
}
