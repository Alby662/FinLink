import 'package:finlink/models/user.dart' as app_models;
import 'package:finlink/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  // Sign in with email and password
  Future<app_models.User> signIn(String email, String password) async {
    try {
      final response = await auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Failed to sign in');
      }

      // Get user profile from database
      final userData = await supabase
          .from('profiles')
          .select()
          .eq('id', response.user!.id)
          .single();

      return app_models.User.fromJson(userData);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Sign up with email and password
  Future<app_models.User> signUp(String email, String password, String name, String role) async {
    try {
      final response = await auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Failed to sign up');
      }

      // Create user profile in database
      final now = DateTime.now().toIso8601String();
      final userData = {
        'id': response.user!.id,
        'email': email,
        'name': name,
        'role': role,
        'created_at': now,
        'updated_at': now,
      };

      await supabase.from('profiles').insert(userData);

      return app_models.User.fromJson(userData);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await auth.resetPasswordForEmail(email);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Get current user
  Future<app_models.User?> getCurrentUser() async {
    try {
      final currentUser = auth.currentUser;

      if (currentUser == null) {
        return null;
      }

      // Get user profile from database
      final userData = await supabase
          .from('profiles')
          .select()
          .eq('id', currentUser.id)
          .single();

      return app_models.User.fromJson(userData);
    } catch (e) {
      return null;
    }
  }

  // Update user profile
  Future<app_models.User> updateUserProfile(String userId, Map<String, dynamic> data) async {
    try {
      // Update the profile
      data['updated_at'] = DateTime.now().toIso8601String();

      await supabase
          .from('profiles')
          .update(data)
          .eq('id', userId);

      // Get updated profile
      final userData = await supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      return app_models.User.fromJson(userData);
    } catch (e) {
      throw Exception('Failed to update profile: ${e.toString()}');
    }
  }

  // Handle authentication errors
  Exception _handleAuthError(dynamic error) {
    if (error is AuthException) {
      return Exception(error.message);
    } else {
      return Exception('Authentication error: ${error.toString()}');
    }
  }
}
