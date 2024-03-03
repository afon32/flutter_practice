import 'package:flutter/material.dart';


import 'package:flutter_practice/pages/public_pages/select_level_and_category.dart';
import 'package:flutter_practice/pages/public_pages/upload_documents.dart';
import 'package:get/get.dart';

class UserHomePageController extends GetxController {
  final userHomePageController = GlobalKey<FormState>();

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
