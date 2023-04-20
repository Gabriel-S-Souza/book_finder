abstract class ServiceLocator {
  void setupLocator();
  T get<T extends Object>();
}
