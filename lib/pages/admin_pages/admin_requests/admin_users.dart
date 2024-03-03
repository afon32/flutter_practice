//import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_practice/data/user.dart';
import 'package:flutter_practice/pages/admin_pages/admin_requests/admin_users_controller.dart';
import 'package:flutter_practice/widgets/app_bar.dart';
import 'package:get/get.dart';

class AdminUsersPage extends StatelessWidget{
  const AdminUsersPage({super.key});

  @override
  Widget build(BuildContext context){
    return GetBuilder<AdminUsersPageController>(
      init: AdminUsersPageController(),
      initState: (_) {},
      builder: (_){
        return Scaffold(
          
          appBar: appBar(context),
          body: Form(
            key: _.adminUsersPageKey,
          child: StreamBuilder<List<Userr>>(
            stream: _.readUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError){
                return Text('Something went wrong!${snapshot.error}');
              }
              else if (snapshot.hasData){
                final users = snapshot.data!;
                return ListView(
                  children: users.map((user) {
                    return InkWell(
                      onTap: () {
                        _.onTapOnRequest(user);
                      },
                      child: _.buildUser(user),
                    );
                  }).toList(),
                );
                // return ListView(
                //   children: orders.map(_.buildOrder).toList(),
                // );
              }
              else{
                return const Center(child: CircularProgressIndicator());
              }
              
            }
          ),
          )
        );
      },
    );
  }
}