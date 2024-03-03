import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_practice/data/document.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice/pages/public_pages/loadURL.dart';
import 'package:flutter_practice/widgets/app_bar.dart';

class AdminDocumentsPage extends StatefulWidget {
  const AdminDocumentsPage({super.key});
  

  @override
  State<AdminDocumentsPage> createState() => _AdminDocumentsPageState();
}

class _AdminDocumentsPageState extends State<AdminDocumentsPage> {
  late Future<ListResult> futureList;
  late String docsPath;
  //String docsPath = ModalRoute.of(context)!.settings.arguments as String;
  late String docCategory;
  bool pathIsLoaded = true;

  //docsPath = ModalRoute.of(context)!.settings.arguments as String;
  @override
  void initState() {
    super.initState();
    
  }

  @override void didChangeDependencies() {
    if (pathIsLoaded){
      docsPath = ModalRoute.of(context)!.settings.arguments as String;
      futureList = FirebaseStorage.instance.ref('/$docsPath').listAll();
      pathIsLoaded = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: FutureBuilder<ListResult>(
        future: futureList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;
            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];

                return ListTile(
                  title: Text(file.name),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoadURL(),
                                settings: RouteSettings(
                                  arguments: '$docsPath/${file.name}',
                                )));
                      },
                      icon: const Icon(
                        Icons.turn_right_sharp,
                        color: Colors.black,
                      )),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future downloadFile() async {}
  Widget oneDocPage(String filename) {
    return AlertDialog(
      title: const Text('data'),
      content: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('docs').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('wait');
          }
          return const Text('snapshot');
        },
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
  }

  Stream<List<Document>> readOrders() => FirebaseFirestore.instance
      .collection('docs')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data();
            data['id'] = doc.id; // Добавляем поле id в данные
            return Document.fromJson(data);
          }).toList());
}
