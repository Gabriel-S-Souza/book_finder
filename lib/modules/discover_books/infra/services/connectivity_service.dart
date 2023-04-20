import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../domain/services/connectivity_service.dart';

class ConnectivityServiceImp implements ConnectivityService {
  @override
  Future<bool> get hasConnection => InternetConnectionChecker().hasConnection;
}
