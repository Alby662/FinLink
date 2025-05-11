import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  bool _isConnected = true;
  
  // Getters
  bool get isConnected => _isConnected;
  
  // Constructor
  NetworkProvider() {
    _initConnectivity();
    _setupConnectivityListener();
  }
  
  // Initialize connectivity status
  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus([result]);
    } catch (e) {
      // Default to connected if there's an error
      _isConnected = true;
    }
  }
  
  // Set up connectivity change listener
  void _setupConnectivityListener() {
    _connectivity.onConnectivityChanged.listen((results) => _updateConnectionStatus([results]));
  }
  
  // Update connection status based on connectivity result
  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final wasConnected = _isConnected;
    _isConnected = results.isNotEmpty && results.any((result) => result != ConnectivityResult.none);

    // Only notify if the status changed
    if (wasConnected != _isConnected) {
      notifyListeners();
    }
  }
  
  // Check current connectivity
  Future<void> checkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus([result]);
    } catch (e) {
      // Keep current status if there's an error
    }
  }
  
  @override
  void dispose() {
    super.dispose();
  }
}
