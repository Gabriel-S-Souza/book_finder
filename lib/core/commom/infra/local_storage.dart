abstract class LocalStorage {
  Future<void> init();
  Future<bool> set({required String key, required String value});
  Future<bool> setList({required String key, required List<String> value});
  Future<String?> get(String key);
  List<String>? getList(String key);
  Future<bool> delete({required String key});
  Future<bool> deleteAll();
}
