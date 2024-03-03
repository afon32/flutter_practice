import 'package:get/get.dart';
import 'package:flutter_practice/data/session_data_provider.dart';
import 'package:flutter_practice/routes/app_routes.dart';

class CheckAuthController extends GetxController {
  @override
  Future<void> onInit() async {
    final uid = await SessionDataProvider().getSessionId();

    if (uid == null) {
      Get.offAllNamed(Routes.auth);
    } else {
      Get.offAllNamed(Routes.home);
    }

    super.onInit();
  }
}
