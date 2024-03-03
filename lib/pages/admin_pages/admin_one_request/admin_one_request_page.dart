import 'package:flutter_practice/pages/admin_pages/admin_one_request/admin_one_request_page_controller.dart';
import 'package:flutter_practice/widgets/app_bar.dart';
import 'package:flutter_practice/widgets/employee_info_column.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AdminOneRegistrationPage extends StatefulWidget {
  const AdminOneRegistrationPage({super.key});

  @override
  State<AdminOneRegistrationPage> createState() =>
      _AdminOneRegistrationPageState();
}

class _AdminOneRegistrationPageState extends State<AdminOneRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminOneRegistrationPageController>(
      init: AdminOneRegistrationPageController(),
      initState: (_) {},
      builder: (_) {
        _.loadData(context);
        return Scaffold(
          appBar: appBar(context),
          body: Padding(
              padding: const EdgeInsets.all(0.0),
              child: ColoredBox(
                color: const Color.fromARGB(255, 240, 193, 26),
                child: Column(children: [
                  employeeInfoColumn(_.user.name, _.user.post, _.user.email, _.user.level),
                  if (FirebaseAuth.instance.currentUser!.email == 'master@mail.ru')
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: const Color.fromARGB(255, 137, 148, 160)),
                            child: 
                            
                            const Text('Установите уровень доступа:'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color.fromARGB(255, 137, 148, 160)),
                            child: DropdownButton<String>(
                              value: _.selectedItem,
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
                                  _.selectedItem = value!;
                                });
                                print(_.selectedItem);
                              },
                              items: _.levelList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (FirebaseAuth.instance.currentUser!.email == 'master@mail.ru')
                  Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  _.updateUser();
                                  _.nextPage(context);
                                },
                                // style: ElevatedButton.styleFrom(
                                //     backgroundColor:
                                //         const Color.fromARGB(255, 226, 103, 0)),
                                child: const Text('Подтвердить')),
                          )))
                ]),
              )),
        );
      },
    );
  }
}
