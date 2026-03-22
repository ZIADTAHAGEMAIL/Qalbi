import 'package:shared_preferences/shared_preferences.dart';

class cash {
  static late SharedPreferences pref;
  static Future<void> initialpref() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<bool> insertIntoCash({
    required String key,
    required String value,
  }) async {
    return await pref.setString(key, value);
  }



  static String ?getFromCash({required String key}) {
    return pref.getString(key) ;
  }

  static Future<bool> delete(String key) async {
    return await pref.remove(key);
  }






  static Future<bool> saveListToCash({required String key,required List<String>value}) async {
    return await pref.setStringList(key, value);
  }


  static List<String>? getListFromCash({required String key})  {
    return  pref.getStringList(key);
  }




}
