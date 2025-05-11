import 'package:flutter/foundation.dart';
import 'package:finlink/models/user.dart';
import 'package:finlink/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  User? _user;
  bool _loading = true;
  String? _error;
  
  // Getters
  User? get user => _user;
  bool get loading => _loading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;
  bool get isClient => _user?.role == 'client';
  bool get isAccountant => _user?.role == 'accountant';
  
  // Constructor
  AuthProvider() {
    _initializeAuth();
  }
  
  // Initialize authentication state
  Future<void> _initializeAuth() async {
    try {
      _loading = true;
      notifyListeners();
      
      _user = await _authService.getCurrentUser();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  
  // Sign in
  Future<void> signIn(String email, String password) async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();
      
      _user = await _authService.signIn(email, password);
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  
  // Sign up
  Future<void> signUp(String email, String password, String name, String role) async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();
      
      _user = await _authService.signUp(email, password, name, role);
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  
  // Sign out
  Future<void> signOut() async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();
      
      await _authService.signOut();
      _user = null;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  
  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();
      
      await _authService.resetPassword(email);
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  
  // Update user profile
  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      if (_user == null) {
        throw Exception('User not authenticated');
      }
      
      _loading = true;
      _error = null;
      notifyListeners();
      
      _user = await _authService.updateUserProfile(_user!.id, data);
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  
  // Refresh user data
  Future<void> refreshUser() async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();
      
      _user = await _authService.getCurrentUser();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
