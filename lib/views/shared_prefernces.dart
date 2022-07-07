import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref instance = SharedPref.init();

  SharedPref.init();

  static const String keyOpened = 'opened';

  late SharedPreferences sp;

  Future<bool> getBool(String key) async {
    sp = await SharedPreferences.getInstance();
    return sp.getBool(key) ?? false;
  }

  Future<void> setBool({
    required String key,
    required bool value,
  }) async {
    sp = await SharedPreferences.getInstance();
    sp.setBool(key, value);
  }
}
