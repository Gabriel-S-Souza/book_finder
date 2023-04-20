import 'package:book_finder/app_widget.dart';
import 'package:flutter/material.dart';

import 'core/commom/infra/datasources/local_storage.dart';
import 'core/di/service_locator_imp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocatorImp.I.setupLocator();
  await ServiceLocatorImp.I.get<LocalStorage>().init();
  runApp(const AppWidget());
}
