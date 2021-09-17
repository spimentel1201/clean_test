import 'package:data_connection_checker/data_connection_checker.dart';

abstract class Network {
  Future<bool> get isConnected;
}

//check internet connection
class NetworkImpl implements Network {
  final DataConnectionChecker connectionChecker;
  NetworkImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
