// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:qcms/core/colors.dart';
// import 'package:qcms/core/responsiveutils.dart';
// import 'package:qcms/domain/repositories/apprepo.dart';
// import 'package:qcms/domain/repositories/loginrepo.dart';
// import 'package:qcms/presentation/blocs/cancel_complaint_bloc/cancel_complaint_bloc.dart';
// import 'package:qcms/presentation/blocs/fetch_complaint_categories/fetch_complaint_categories_bloc.dart';
// import 'package:qcms/presentation/blocs/fetch_complaintlists_bloc/fetch_complaintlists_bloc.dart';
// import 'package:qcms/presentation/blocs/fetch_departments_bloc/fetch_departments_bloc.dart';
// import 'package:qcms/presentation/blocs/fetch_profile_bloc/fetch_profile_bloc.dart';

// import 'package:qcms/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
// import 'package:qcms/presentation/blocs/fetch_dashboard_bloc/fetch_dashboard_bloc.dart';
// import 'package:qcms/presentation/blocs/fetch_division_bloc/fetch_division_bloc.dart';

// import 'package:qcms/presentation/blocs/fetch_quarters_bloc/fetch_quarters_bloc.dart';
// import 'package:qcms/presentation/blocs/language_cubit.dart';
// import 'package:qcms/presentation/blocs/register_new_division/register_newdivision_bloc.dart';
// import 'package:qcms/presentation/blocs/register_quarters_bloc/register_quarters_bloc.dart';
// import 'package:qcms/presentation/blocs/request_complaint_model/request_complaint_bloc.dart';

// import 'package:qcms/presentation/blocs/resend_otp_bloc/resend_otp_bloc.dart';
// import 'package:qcms/presentation/blocs/send_otp_bloc/send_otp_bloc.dart';
// import 'package:qcms/presentation/blocs/verify_otp_bloc/verify_otp_bloc.dart';

// import 'package:qcms/widgets/custom_routes.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//  await EasyLocalization.ensureInitialized();
//   SystemChrome.setSystemUIOverlayStyle(
//     SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.dark,
//       statusBarBrightness: Brightness.light,
//     ),
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     ResponsiveUtils().init(context);
//     final loginrepo = LoginRepo();
//     final apprepo = Apprepo();
//     return EasyLocalization(
//          supportedLocales: const [
//         Locale('en', 'US'),
//         Locale('hi', 'IN'),
//         Locale('kn', 'IN'),
//       ],
//       path: 'assets/lang',
//       fallbackLocale: const Locale('en', 'US'),
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (context) => BottomNavigationBloc()),
//           BlocProvider(create: (context) => SendOtpBloc(repository: loginrepo)),
//           BlocProvider(create: (context) => VerifyOtpBloc(repository: loginrepo)),
//           BlocProvider(create: (context) => ResendOtpBloc(repository: loginrepo)),
//           BlocProvider(
//             create: (context) => RegisterNewdivisionBloc(repository: loginrepo),
//           ),
//           BlocProvider(
//             create: (context) => FetchDivisionBloc(repository: apprepo),
//           ),
//           BlocProvider(
//             create: (context) => FetchQuartersBloc(repository: apprepo),
//           ),
//           BlocProvider(
//             create: (context) => RegisterQuartersBloc(repository: loginrepo),
//           ),
//           BlocProvider(
//             create: (context) => FetchDashboardBloc(repository: apprepo),
//           ),
//           BlocProvider(
//             create: (context) => FetchProfileBloc(repository: loginrepo),
//           ),
//           BlocProvider(
//             create: (context) => FetchComplaintlistsBloc(repository: apprepo),
//           ),
//           BlocProvider(
//             create: (context) => CancelComplaintBloc(repository: apprepo),
//           ),
//           BlocProvider(
//             create: (context) => FetchDepartmentsBloc(repository: apprepo),
//           ),
//           BlocProvider(
//             create: (context) =>
//                 FetchComplaintCategoriesBloc(repository: apprepo),
//           ),
//           BlocProvider(
//             create: (context) => RequestComplaintBloc(repository: apprepo),
//           ),
//            BlocProvider(
//             create: (context) => LanguageCubit(),
//           ),
//         ],
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'QCMS',
//           onGenerateRoute: AppRouter.generateRoute,
//           initialRoute: AppRouter.splashpage,
//            locale: locale,
//           supportedLocales: context.supportedLocales,
//           localizationsDelegates: context.localizationDelegates,
//           onUnknownRoute: (settings) => MaterialPageRoute(
//             builder: (_) => Scaffold(
//               appBar: AppBar(title: Text('404')),
//               body: Center(child: Text('Page not found')),
//             ),
//           ),
//           theme: ThemeData(
//             fontFamily: 'Helvetica',
      
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             scaffoldBackgroundColor: Appcolors.kbackgroundcolor,
//             // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           ),
//         ),
//       ),
//     );
//   }
// }

// //   Future<bool> _checkOnboardingStatus() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     return prefs.getBool('onboarding_completed') ?? false;
// //   }
// // }


// // void handleLogout(BuildContext context) async {
// //   // Your existing logout logic here...
  
// //   // Reset onboarding status
// //   await resetOnboardingStatus();
  
// //   // Navigate to onboarding
// //   CustomNavigation.pushNamedAndRemoveUntil(
// //     context, 
// //     AppRouter.onboarding,
// //   );
// // }
/////////////////////////
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qcms/core/colors.dart';
import 'package:qcms/core/responsiveutils.dart';
import 'package:qcms/domain/controllers/pushnotification_controller.dart';
import 'package:qcms/domain/repositories/apprepo.dart';
import 'package:qcms/domain/repositories/loginrepo.dart';
import 'package:qcms/firebase_options.dart';
import 'package:qcms/presentation/blocs/cancel_complaint_bloc/cancel_complaint_bloc.dart';
import 'package:qcms/presentation/blocs/connectivity_bloc.dart/connectivity_bloc.dart';
import 'package:qcms/presentation/blocs/fetch_complaint_categories/fetch_complaint_categories_bloc.dart';
import 'package:qcms/presentation/blocs/fetch_complaintlists_bloc/fetch_complaintlists_bloc.dart';
import 'package:qcms/presentation/blocs/fetch_departments_bloc/fetch_departments_bloc.dart';
import 'package:qcms/presentation/blocs/fetch_notifications/fetch_notifications_bloc.dart';
import 'package:qcms/presentation/blocs/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:qcms/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:qcms/presentation/blocs/fetch_dashboard_bloc/fetch_dashboard_bloc.dart';
import 'package:qcms/presentation/blocs/fetch_division_bloc/fetch_division_bloc.dart';
import 'package:qcms/presentation/blocs/fetch_quarters_bloc/fetch_quarters_bloc.dart';
import 'package:qcms/presentation/blocs/language_cubit.dart';
import 'package:qcms/presentation/blocs/register_new_division/register_newdivision_bloc.dart';
import 'package:qcms/presentation/blocs/register_quarters_bloc/register_quarters_bloc.dart';
import 'package:qcms/presentation/blocs/request_complaint_model/request_complaint_bloc.dart';
import 'package:qcms/presentation/blocs/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:qcms/presentation/blocs/send_otp_bloc/send_otp_bloc.dart';
import 'package:qcms/presentation/blocs/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:qcms/widgets/custom_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
    final pushNotifications = PushNotifications();
  await pushNotifications.init();
  if (Platform.isIOS) {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }
  //   SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.dark,
  //     statusBarBrightness: Brightness.light,
  //   ),
  // );
    final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('langCode') ?? 'en';
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en' ),
        Locale('hi'),
        Locale('kn'),
      ],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(langCode),
      child: MultiBlocProvider(
        providers: [
              BlocProvider(
          create: (context) => ConnectivityBloc(),
        ),
          BlocProvider(create: (context) => BottomNavigationBloc()),
          BlocProvider(create: (context) => SendOtpBloc(repository: LoginRepo())),
          BlocProvider(create: (context) => VerifyOtpBloc(repository: LoginRepo())),
          BlocProvider(create: (context) => ResendOtpBloc(repository: LoginRepo())),
          BlocProvider(create: (context) => RegisterNewdivisionBloc(repository: LoginRepo())),
          BlocProvider(create: (context) => FetchDivisionBloc(repository: Apprepo())),
          BlocProvider(create: (context) => FetchQuartersBloc(repository: Apprepo())),
          BlocProvider(create: (context) => RegisterQuartersBloc(repository: LoginRepo())),
          BlocProvider(create: (context) => FetchDashboardBloc(repository: Apprepo())),
          BlocProvider(create: (context) => FetchProfileBloc(repository: LoginRepo())),
          BlocProvider(create: (context) => FetchComplaintlistsBloc(repository: Apprepo())),
          BlocProvider(create: (context) => CancelComplaintBloc(repository: Apprepo())),
          BlocProvider(create: (context) => FetchDepartmentsBloc(repository: Apprepo())),
          BlocProvider(create: (context) => FetchComplaintCategoriesBloc(repository: Apprepo())),
          BlocProvider(create: (context) => RequestComplaintBloc(repository: Apprepo())),
            BlocProvider(create: (context) => FetchNotificationsBloc(repository: Apprepo())),
          BlocProvider(create: (context) => LanguageCubit()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils().init(context);

  
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'QCMS',
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRouter.splashpage,
          locale:context. locale, // now from LanguageCubit
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('404')),
              body: const Center(child: Text('Page not found')),
            ),
          ),
          theme: ThemeData(
                  appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light, // white icons
            statusBarBrightness: Brightness.dark, // iOS
          ),
        ),
            fontFamily: 'Helvetica',
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            scaffoldBackgroundColor: Appcolors.kbackgroundcolor,
          ),
        );
  
  }
}
