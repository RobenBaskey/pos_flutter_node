import 'package:get/get.dart';

import '../../data/datasource/local_db/shared_preference_service.dart';

class InitServices {
  Future onInit() async {
    final sharedPreferences = await SharedPreferenceService.getInstance();
    Get.put(sharedPreferences, permanent: true);
  }
}
