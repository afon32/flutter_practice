import 'package:flutter_practice/pages/admin_pages/admin_home/admin_home_page_controller.dart';
import 'package:flutter_practice/widgets/app_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminHomePageController>(
        init: AdminHomePageController(),
        initState: (_) {},
        builder: (_) {
          return Scaffold(
              backgroundColor: const Color.fromARGB(255, 240, 193, 26),
              appBar: appBar(context),
              body: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: Container(
                      //height: MediaQuery.sizeOf(context).height*0.6,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 226, 103, 0),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.black)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: const EdgeInsets.all(10.0), child: 
                              FractionallySizedBox(
                                  widthFactor: 0.7,
                                  child: Image.asset(
                                    'assets/logo.png',
                                    width: MediaQuery.sizeOf(context).width*0.4,
                                    height: MediaQuery.sizeOf(context).height*0.2,
                                  ))),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.8,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          _.requestsPage(context);
                                        },
                                        child: const Text('Уровни доступа'))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.8,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          _.usersPage(context);
                                        },
                                        child: const Text('Все пользователи'))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.8,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          _.documentsPage(context);
                                        },
                                        child:
                                            const Text('Просмотр документов'))),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.8,
                                          
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            // final isAuth =
                                            //     await LocalAuthApi.authenticateMethod();
                                            _.uploadDocumentsPage(context);
                                          },
                                          child: const Text(
                                              'Загрузка документов')))),
                            ])),
                  )));
        });
  }
}
