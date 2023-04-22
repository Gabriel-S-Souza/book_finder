import 'package:book_finder/app_widget.dart';
import 'package:flutter/material.dart';

import 'core/di/service_locator_imp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocatorImp.I.setupLocator();
  runApp(const AppWidget());
}
