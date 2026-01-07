import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();

  final Connectivity _connectivity = Connectivity();
  late final InternetConnectionChecker _internetChecker;
  final StreamController<bool> _connectionController = StreamController<bool>.broadcast();

  Stream<bool> get connectionStream => _connectionController.stream;

  Future<void> initialize() async {
    _internetChecker = await InternetConnectionChecker.createInstance();
  }

  void monitorNetwork() {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> resultList) async {
      bool isConnected = await _internetChecker.hasConnection;
      _connectionController.add(isConnected);
    });
  }
}



