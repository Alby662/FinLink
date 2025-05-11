import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:finlink/providers/auth_provider.dart';
import 'package:finlink/navigation/routes.dart';

// Import screens
import 'package:finlink/screens/common/loading_screen.dart';
import 'package:finlink/screens/auth/login_screen.dart';
import 'package:finlink/screens/auth/register_screen.dart';
import 'package:finlink/screens/auth/forgot_password_screen.dart';
import 'package:finlink/screens/client/client_dashboard_screen.dart';

class AppRouter {
  static GoRouter getRouter(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return GoRouter(
      initialLocation: AppRoutes.splash,
      refreshListenable: authProvider,
      redirect: (context, state) {
        final isLoading = authProvider.loading;
        final isLoggedIn = authProvider.isAuthenticated;
        final isLoginRoute = state.matchedLocation == AppRoutes.login ||
                            state.matchedLocation == AppRoutes.register ||
                            state.matchedLocation == AppRoutes.forgotPassword;
        final isSplashRoute = state.matchedLocation == AppRoutes.splash;

        // If loading, stay on splash screen
        if (isLoading) {
          return isSplashRoute ? null : AppRoutes.splash;
        }

        // If not logged in, redirect to login
        if (!isLoggedIn) {
          return isLoginRoute || isSplashRoute ? null : AppRoutes.login;
        }

        // If logged in but on auth route, redirect to dashboard
        if (isLoggedIn && (isLoginRoute || isSplashRoute)) {
          if (authProvider.isClient) {
            return AppRoutes.clientDashboard;
          } else {
            // For accountants, keep them on loading screen until we implement their dashboard
            return AppRoutes.splash;
          }
        }

        // No redirect needed
        return null;
      },
      routes: [
        // Splash and Auth routes
        GoRoute(
          path: AppRoutes.splash,
          builder: (context, state) => const LoadingScreen(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: AppRoutes.register,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: AppRoutes.forgotPassword,
          builder: (context, state) => const ForgotPasswordScreen(),
        ),

        // Client routes
        GoRoute(
          path: AppRoutes.clientDashboard,
          builder: (context, state) => const ClientDashboardScreen(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('Route not found: ${state.matchedLocation}'),
        ),
      ),
    );
  }
}
