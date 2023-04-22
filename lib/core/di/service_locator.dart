abstract class ServiceLocator {
  Future<void> setupLocator();
  void registerSingleton<T extends Object>(T instance);
  void registerFactory<T extends Object>(T Function() factory);
  T get<T extends Object>();
}
