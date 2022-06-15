import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? shared;

  static init() async {
    shared = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(
      {required String? key, required bool? value}) async {
    return await shared!.setBool(key!, value!);
  }

  static bool? getData({required String? key}) {
    return shared!.getBool(key!);
  }
}