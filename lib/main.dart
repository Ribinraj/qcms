import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/responsiveutils.dart';
import 'package:qcms/domain/repositories/apprepo.dart';
import 'package:qcms/domain/repositories/loginrepo.dart';
import 'package:qcms/presentation/blocs/bloc/fetch_profile_bloc.dart';

import 'package:qcms/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:qcms/presentation/blocs/fetch_dashboard_bloc/fetch_dashboard_bloc.dart';
import 'package:qcms/presentation/blocs/fetch_division_bloc/fetch_division_bloc.dart';

import 'package:qcms/presentation/blocs/fetch_quarters_bloc/fetch_quarters_bloc.dart';
import 'package:qcms/presentation/blocs/register_new_division/register_newdivision_bloc.dart';
import 'package:qcms/presentation/blocs/register_quarters_bloc/register_quarters_bloc.dart';

import 'package:qcms/presentation/blocs/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:qcms/presentation/blocs/send_otp_bloc/send_otp_bloc.dart';
import 'package:qcms/presentation/blocs/verify_otp_bloc/verify_otp_bloc.dart';

import 'package:qcms/widgets/custom_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ResponsiveUtils().init(context);
    final loginrepo = LoginRepo();
    final apprepo = Apprepo();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavigationBloc()),
        BlocProvider(create: (context) => SendOtpBloc(repository: loginrepo)),
        BlocProvider(create: (context) => VerifyOtpBloc(repository: loginrepo)),
        BlocProvider(create: (context) => ResendOtpBloc(repository: loginrepo)),
        BlocProvider(
          create: (context) => RegisterNewdivisionBloc(repository: loginrepo),
        ),
        BlocProvider(
          create: (context) => FetchDivisionBloc(repository: apprepo),
        ),
        BlocProvider(
          create: (context) => FetchQuartersBloc(repository: apprepo),
        ),
        BlocProvider(
          create: (context) => RegisterQuartersBloc(repository: loginrepo),
        ),
        BlocProvider(
          create: (context) => FetchDashboardBloc(repository: apprepo),
        ),
        BlocProvider(
          create: (context) => FetchProfileBloc(repository: loginrepo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.mainpage,
        // home: FutureBuilder<bool>(
        //   future: _checkOnboardingStatus(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Scaffold(body: Center(child: CircularProgressIndicator()));
        //     }

        //     final hasSeenOnboarding = snapshot.data ?? false;
        //     if (hasSeenOnboarding) {
        //       return ScreenLoginpage();
        //     } else {
        //       return OnboardingScreen(); // Show onboarding first
        //     }
        //   },
        // ),
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