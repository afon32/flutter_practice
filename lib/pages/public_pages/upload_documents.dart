import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_practice/widgets/app_bar.dart';
import 'package:flutter_practice/widgets/level_selection_help.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice/data/user.dart';
import 'package:pdfx/pdfx.dart';

class UploadDocumentsPage extends StatefulWidget {
  const UploadDocumentsPage({super.key});

  @override
  State<UploadDocumentsPage> createState() => _UploadDocumentsPage();
}

class _UploadDocumentsPage extends State<UploadDocumentsPage> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  final documentDescription = TextEditingController();
  String? selectedCategory = 'Security';
  String? selectedLevel = 'A';
  final categories = ['Security', 'Medicine', 'IT', 'KB'];
  final levels = ['A', 'B', 'C', 'D'];

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    setState(() {
      pickedFile = result?.files.first;
    });
  }

  Stream<List<Userr>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data();
            data['id'] = doc.id;
            print(data['post']);
            return Userr.fromJson(data);
          }).toList());

  Future searchNameOfUser() async {
    List<Userr> users = await readUsers().first;
    if (users.isNotEmpty) {
      for (Userr user in users) {
        if (user.email == FirebaseAuth.instance.currentUser!.email) {
          //print('${user.name}  ${user.email}, ${user.post}');
          return user.name;
        }
      }
    }
  }

  @override
  Future uploadFile() async {
    String userName = await searchNameOfUser();
    //print('NAME NAME NAME $userName');
    final pathFS = '$selectedLevel/$selectedCategory/${pickedFile!.name}';
    //print(pathFS);
    final file = File(pickedFile!.path!);
    final docDocuments = FirebaseFirestore.instance.collection('docs').doc();
    final user = FirebaseAuth.instance.currentUser!;
    final docJson = {
      'docCategory': selectedCategory,
      'docDescription': documentDescription.text,
      'docLevel': selectedLevel,
      'docName': pickedFile!.name,
      'docOwnerName': userName,
      'docUploadDate': DateTime.now(),
    };
    final ref = FirebaseStorage.instance.ref().child(pathFS);
    setState(() {
      uploadTask = ref.putFile(file);
    });
    await docDocuments.set(docJson);
    final snapshot = await uploadTask!.whenComplete(() {});

    setState(() {
      uploadTask = null;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 193, 26),
      appBar: appBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pickedFile != null)
              // Expanded(
              //   child: Container(
              //     // width: MediaQuery.of(context).size.width,
              //     // height: MediaQuery.of(context).size.height * 0.3,
              //     color: Colors.blue,
              //     child: Center(
              //       child: Text(pickedFile!.name),
              //     ),
              //   ),
              // ),
              Expanded(
                  child: PdfView(
                controller: PdfController(
                  document:  PdfDocument.openFile(pickedFile!.path!),
                ),
              )),

//Выбор категории документа

            if (pickedFile != null)
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color:
                                    const Color.fromARGB(255, 137, 148, 160)),
                            child: const Text('Выберите категорию документа:'),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              padding:
                                  const EdgeInsets.only(right: 5.0, left: 5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color:
                                      const Color.fromARGB(255, 137, 148, 160)),
                              child: DropdownButton<String>(
                                value: selectedCategory,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                underline: Container(
                                  height: 2,
                                  color: const Color.fromARGB(255, 226, 103, 0),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedCategory = value!;
                                  });
                                  print(selectedCategory);
                                },
                                items: categories.map<DropdownMenuItem<String>>(
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

            if (pickedFile != null)
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color:
                                    const Color.fromARGB(255, 137, 148, 160)),
                            child: const Text('Установите уровень доступа:'),
                          ),
                        ),
                        Row(children: [
                          Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                padding: const EdgeInsets.only(
                                    right: 5.0, left: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: const Color.fromARGB(
                                        255, 137, 148, 160)),
                                child: DropdownButton<String>(
                                  value: selectedLevel,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  underline: Container(
                                    height: 2,
                                    color: const Color.fromARGB(255, 226, 103, 0),
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedLevel = value!;
                                    });
                                    print(selectedLevel);
                                  },
                                  items: levels.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              )),
                          IconButton(
                              onPressed: () {
                                helpLevelSelection(context);
                              },
                              icon: const Icon(
                                Icons.help,
                                color: Colors.black,
                              )),
                        ]),
                      ])),

//Описание документа

            if (pickedFile != null)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  //height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.grey, // Серый фон
                    borderRadius:
                        BorderRadius.circular(10.0), // Закругленные края
                  ),
                  child: TextFormField(
                    controller: documentDescription,
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Описание документа',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      border: InputBorder.none, // Убираем границу
                    ),
                  ),
                ),
              ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                    onPressed: selectFile, child: const Text('SELECT')),
              ),
              if (pickedFile != null)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                      onPressed: uploadFile, child: const Text('UPLOAD')),
                )
            ]),
            buildProgress(),
          ],
        ),
      ),
    );
  }

  Widget buildProgress() {
    return StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            String textMessage = '${(100 * progress).roundToDouble()}%';
            if ((100 * progress).roundToDouble() == 100.0) {
              textMessage = 'Complete!';
            }
            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text(
                      textMessage,
                      //'${(100 * progress).roundToDouble()}%',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 50,
            );
          }
        });
  }
}
