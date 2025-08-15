import 'package:flutter/material.dart';
import 'package:qcms/domain/controllers/pushnotification_controller.dart';
import 'package:qcms/widgets/custom_routes.dart';
import 'package:qcms/widgets/custom_sharedpreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  // Check if user is logged in
  static Future<bool> isUserLoggedIn() async {
    String token = await getUserToken();
    return token.isNotEmpty;
  }

  // Handle logout
  static Future<void> handleLogout(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Clear user token
      await prefs.remove('USER_TOKEN');
      await PushNotifications().deleteDeviceToken();

      // Normal logout - go to login page
      if (context.mounted) {
        CustomNavigation.pushNamedAndRemoveUntil(context, AppRouter.login);
      }
    } catch (e) {
      print('Error during logout: $e');
      // Fallback navigation
      if (context.mounted) {
        CustomNavigation.pushNamedAndRemoveUntil(context, AppRouter.login);
      }
    }
  }

  // Clear all app data (complete reset)
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}  
///////////////////////////////
// After successful login
// await AuthUtils.saveUserToken(tokenFromAPI);

// // For logout
// await AuthUtils.handleLogout(context);

// // For complete reset (useful for testing)
// await AuthUtils.handleLogout(context, resetOnboarding: true);