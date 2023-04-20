import 'package:shared_preferences/shared_preferences.dart';
import '../infra/datasources/local_storage.dart';

class LocalStorageImp implements LocalStorage {
  late final SharedPreferences _prefs;
  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  List<String>? getList(String key) {
    return _prefs.getStringList(key);
  }

  @override
  Future<bool> setList({required String key, required List<String> value}) {
    return _prefs.setStringList(key, value);
  }

  @override
  Future<bool> delete({required String key}) {
    return _prefs.remove(key);
  }

  @override
  Future<bool> deleteAll() {
    return _prefs.clear();
  }

  @override
  Future<String?> get(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<bool> set({required String key, required String value}) async {
    return _prefs.setString(key, value);
  }
}
