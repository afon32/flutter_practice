import 'package:flutter/material.dart';

import 'package:flutter_practice/pages/admin_pages/admin_requests/admin_requests_page.dart';
import 'package:flutter_practice/pages/admin_pages/admin_requests/admin_users.dart';

import 'package:flutter_practice/pages/public_pages/select_level_and_category.dart';
import 'package:flutter_practice/pages/public_pages/upload_documents.dart';
import 'package:get/get.dart';

class AdminHomePageController extends GetxController {
  final adminHomePageController = GlobalKey<FormState>();

  void requestsPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminRequestPage(),
        ));
  }

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

  void uploadDocumentsPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UploadDocumentsPage(),
        ));
  }
}
