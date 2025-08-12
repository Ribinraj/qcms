import 'package:flutter/material.dart';
import 'package:qcms/widgets/custom_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  // Get user token
  static Future<String> getUserToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('USER_TOKEN') ?? '';
  }

  // Check if user is logged in
  static Future<bool> isUserLoggedIn() async {
    String token = await getUserToken();
    return token.isNotEmpty;
  }

  // Check onboarding status
  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_completed') ?? false;
  }

  // Handle logout
  static Future<void> handleLogout(BuildContext context, {bool resetOnboarding = false}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Clear user token
      await prefs.remove('USER_TOKEN');
      
      // Clear any other user-related data you might have
      await prefs.remove('user_id');
      await prefs.remove('user_name');
      await prefs.remove('user_email');
      // Add any other user data keys you want to clear
      
      // Optionally reset onboarding status (useful for testing or complete reset)
      if (resetOnboarding) {
        await prefs.remove('onboarding_completed');
        // Navigate to onboarding
        if (context.mounted) {
          CustomNavigation.pushNamedAndRemoveUntil(
            context,
            AppRouter.onboarding,
          );
        }
      } else {
        // Normal logout - go to login page
        if (context.mounted) {
          CustomNavigation.pushNamedAndRemoveUntil(
            context,
            AppRouter.login,
          );
        }
      }
    } catch (e) {
      print('Error during logout: $e');
      // Fallback navigation
      if (context.mounted) {
        CustomNavigation.pushNamedAndRemoveUntil(
          context,
          AppRouter.login,
        );
      }
    }
  }

  // Reset onboarding status (useful for testing)
  static Future<void> resetOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('onboarding_completed');
  }

  // Clear all app data (complete reset)
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Save user token after successful login
  static Future<void> saveUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('USER_TOKEN', token);
  }

  // Save additional user data if needed
  static Future<void> saveUserData({
    String? userId,
    String? userName,
    String? userEmail,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (userId != null) {
      await prefs.setString('user_id', userId);
    }
    if (userName != null) {
      await prefs.setString('user_name', userName);
    }
    if (userEmail != null) {
      await prefs.setString('user_email', userEmail);
    }
  }
}  
///////////////////////////////
// After successful login
// await AuthUtils.saveUserToken(tokenFromAPI);

// // For logout
// await AuthUtils.handleLogout(context);

// // For complete reset (useful for testing)
// await AuthUtils.handleLogout(context, resetOnboarding: true);