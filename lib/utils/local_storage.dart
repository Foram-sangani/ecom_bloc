import 'package:ecommerce_app/utils/common_utils.dart';
import 'package:get_storage/get_storage.dart';

class Prefs {
  static const String userEmail = "USER_EMAIL";
  static const String userName = "USER_NAME";
  static const String language = "LANGUAGE_CODE";
}

class LocalStorage {
  LocalStorage._();

  ///
  static GetStorage storage = GetStorage();

  static String userName = '';
  static String userEmail = '';

  static String languageCode = 'en';

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

  static Future setLanguageCode({required String code}) async {
    if (!isValEmpty(code)) {
      await storage.write(Prefs.language, code);
      languageCode = storage.read(Prefs.language);
    }
  }

  static Future<void> readDataInfo() async {
    //* =-=-=-=-=-=-=-=> Read Info <-=-=-=-=-=-=-=- //

    languageCode = storage.read(Prefs.language) ?? "en";
  }

  static Future<void> clearDataInfo() async {}
}
