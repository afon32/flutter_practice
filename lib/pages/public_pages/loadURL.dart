import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_practice/data/document.dart';
import 'package:flutter_practice/data/user.dart';
import 'package:flutter_practice/widgets/app_bar.dart';
import 'package:flutter_practice/widgets/document_info_column.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadURL extends StatefulWidget {
  const LoadURL({super.key});

  @override
  _LoadURLState createState() => _LoadURLState();
}

class _LoadURLState extends State<LoadURL> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Userr? user;
  Document ourDoc = Document(
      docName: 'docName',
      docDescription: 'docDescription',
      docOwnerName: 'docOwnerName',
      docLevel: 'docLevel',
      docCategory: 'docCategory',
      docUploadDate: Timestamp.now());

  Stream<List<Document>> readDocs() => FirebaseFirestore.instance
      .collection('docs')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data();
            data['id'] = doc.id; // Добавляем поле id в данные
            return Document.fromJson(data);
          }).toList());

  Future searchLevelOfUser() async {
    List<Document> documents = await readDocs().first;
    if (documents.isNotEmpty) {
      for (Document doc in documents) {
        if (doc.docName ==
            (ModalRoute.of(context)!.settings.arguments as String)
                .substring(2)
                .substring(
                    ((ModalRoute.of(context)!.settings.arguments as String)
                                .substring(2))
                            .indexOf('/') +
                        1)) {
          ourDoc = doc;
        }
      }
    }
  }

  Future<String> urlGet() async {
    await searchLevelOfUser();
    String urll = ModalRoute.of(context)!.settings.arguments as String;
    String urldoc = '';
    await storage.ref(urll).getDownloadURL().then((url) => urldoc = url);
    print(urldoc);
    return urldoc;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //future: Future.wait([urlGet(), searchLevelOfUser()]),
      future: urlGet(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // Или другой виджет загрузки
        } else if (snapshot.hasError) {
          return Text('Ошибка: ${snapshot.error}');
        } else {
          return Scaffold(
              appBar: appBar(context),
              body: ColoredBox(
                color: const Color.fromARGB(255, 240, 193, 26), child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Expanded(
                  child: PdfView(
                    controller: PdfController(
                      document: PdfDocument.openData(
                          InternetFile.get(snapshot.data!)),
                    ),
                  ),
                ),
                documentInfoColumn(context, ourDoc.docName, ourDoc.docOwnerName,ourDoc.docDescription, ourDoc.docUploadDate)
              ])));
        }
      },
    );
  }
}
