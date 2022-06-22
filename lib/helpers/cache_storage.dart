import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static Future<bool> setCache(
      {@required dynamic key, @required dynamic data}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences pref = await _prefs;

    return await pref.setString('$key', data.toString());
  }

  static Future<bool> setCacheList(
      {@required dynamic key, @required dynamic data}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences pref = await _prefs;

    return await pref.setStringList('$key', data);
  }

  static Future<bool> setCacheBool(
      {@required dynamic key, required bool data}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences pref = await _prefs;

    return await pref.setBool('$key', data);
  }

  static Future<bool> removeCache({@required dynamic key}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    final SharedPreferences prefs = await _prefs;

    return await prefs.remove('$key');
  }

  static getCache({@required dynamic key}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    final SharedPreferences prefs = await _prefs;

    final data = prefs.getString('$key');

    return data;
  }

  static getCacheBool({required dynamic key}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    final SharedPreferences prefs = await _prefs;

    final data = prefs.getBool('$key');

    return data;
  }
}
