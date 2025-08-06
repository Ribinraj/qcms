import 'package:flutter/material.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/responsiveutils.dart';
import 'package:qcms/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:qcms/presentation/screens/screen_loginpage/screen_loginpage.dart';
import 'package:qcms/presentation/screens/screen_mainpage/screen_mainpage.dart';
import 'package:qcms/presentation/screens/screen_onbording/screen_onboarding.dart';
import 'package:qcms/widgets/custom_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ResponsiveUtils().init(context);
    return BlocProvider(
      create: (context) => BottomNavigationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        onGenerateRoute: AppRouter.generateRoute,
        home: FutureBuilder<bool>(
          future: _checkOnboardingStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            final hasSeenOnboarding = snapshot.data ?? false;
            if (hasSeenOnboarding) {
              return ScreenLoginpage(); // Go directly to main page
            } else {
              return OnboardingScreen(); // Show onboarding first
            }
          },
        ),
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text('404')),
            body: Center(child: Text('Page not found')),
          ),
        ),
        theme: ThemeData(
          fontFamily: 'Helvetica',
    
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          scaffoldBackgroundColor: Appcolors.kbackgroundcolor,
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      ),
    );
  }

  Future<bool> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_completed') ?? false;
  }
}


// void handleLogout(BuildContext context) async {
//   // Your existing logout logic here...
  
//   // Reset onboarding status
//   await resetOnboardingStatus();
  
//   // Navigate to onboarding
//   CustomNavigation.pushNamedAndRemoveUntil(
//     context, 
//     AppRouter.onboarding,
//   );
// }