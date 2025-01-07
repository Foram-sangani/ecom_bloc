import 'package:ecommerce_app/utils/common_utils.dart';
import 'package:get_storage/get_storage.dart';

class Prefs {
  static const String userEmail = "USER_EMAIL";
  static const String userName = "USER_NAME";
}

class LocalStorage {
  LocalStorage._();

  ///
  static GetStorage storage = GetStorage();

  static String userName = '';
  static String userEmail = '';

  static Future setUserData({required String email, required String name}) async {
    if (!isValEmpty(email)) {
      await storage.write(Prefs.userEmail, email);
      userEmail = storage.read(Prefs.userEmail);
    }
    if (!isValEmpty(name)) {
      await storage.write(Prefs.userName, name);
      userName = storage.read(Prefs.userName);
    }
  }

  static Future<void> readDataInfo() async {
    //* =-=-=-=-=-=-=-=> Read Info <-=-=-=-=-=-=-=- //
    userEmail = storage.read(Prefs.userEmail);
  }

  static Future<void> clearDataInfo() async {}
}
