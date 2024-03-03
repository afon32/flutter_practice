import 'package:flutter/material.dart';

import 'package:flutter_practice/pages/admin_pages/admin_requests/admin_users.dart';

import 'package:flutter_practice/pages/public_pages/select_level_and_category.dart';
import 'package:get/get.dart';

class DSHomePageController extends GetxController {
  final dsHomePageController = GlobalKey<FormState>();

  void usersPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminUsersPage(),
        ));
  }

  void documentsPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SelectLevelAndCategoryOfDocPage(),
        ));
  }
}
