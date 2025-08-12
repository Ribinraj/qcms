// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:qcms/core/appconstants.dart';
// import 'package:qcms/core/colors.dart';
// import 'package:qcms/widgets/custom_routes.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _logoController;
//   late AnimationController _textController;
//   late Animation<double> _logoScaleAnimation;
//   late Animation<double> _logoRotateAnimation;
//   late Animation<double> _logoOpacityAnimation;
//   late Animation<double> _textFadeAnimation;
//   late Animation<Offset> _textSlideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//     _startAnimationSequence();
//   }

//   void _initializeAnimations() {
//     // Logo animations - Start from visible values to prevent flash
//     _logoController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );
//     _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _logoController,
//         curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
//       ),
//     );
//     _logoRotateAnimation = Tween<double>(begin: -0.1, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _logoController,
//         curve: const Interval(0.0, 0.8, curve: Curves.easeOutBack),
//       ),
//     );
//     _logoOpacityAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _logoController,
//         curve: const Interval(0.0, 0.8, curve: Curves.easeIn),
//       ),
//     );

//     // Text animations - Start from slightly visible to prevent flash
//     _textController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
//     _textFadeAnimation = Tween<double>(
//       begin: 0.5,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));
//     _textSlideAnimation =
//         Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
//           CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
//         );
//     _navigateToNextScreen();
//   }

//   void _startAnimationSequence() async {
//     // Start logo animation
//     _logoController.forward();

//     // Start text animation after logo starts
//     await Future.delayed(const Duration(milliseconds: 500));
//     _textController.forward();

//     // Navigate to next screen after splash completes
//     await Future.delayed(const Duration(milliseconds: 3000));
//     _navigateToNextScreen();
//   }

//   void _navigateToNextScreen() {
//     CustomNavigation.pushNamedWithTransition(context, AppRouter.login);
//   }

//   @override
//   void dispose() {
//     _logoController.dispose();
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:
//           Appcolors.kbackgroundcolor, // Set initial background color
//       body: AnimatedBuilder(
//         animation: Listenable.merge([_logoController, _textController]),
//         builder: (context, child) {
//           return Container(
//             width: double.infinity,
//             height: double.infinity,
//             color: Appcolors.kbackgroundcolor,
//             child: Stack(
//               children: [
//                 // Main content
//                 Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Logo container with animations
//                       Transform.rotate(
//                         angle: _logoRotateAnimation.value,
//                         child: Transform.scale(
//                           scale: _logoScaleAnimation.value,
//                           child: FadeTransition(
//                             opacity: _logoOpacityAnimation,
//                             child: Container(
//                               width: 150,
//                               height: 150,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     Appcolors.kprimarycolor,
//                                     Appcolors.ksecondarycolor,
//                                     Appcolors.kbordercolor,
//                                   ],
//                                 ),
//                               ),
//                               child: Container(
//                                 width: 150,
//                                 height: 150,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Appcolors.kprimarycolor,
//                                 ),
//                                 child: Center(
//                                   child: SizedBox(
//                                     width: 100, // Control logo size directly
//                                     height: 100,
//                                     child: Image.asset(
//                                       Appconstants.whitelogo,
//                                       fit: BoxFit.contain,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 40),

//                       // App name with slide and fade animation
//                       SlideTransition(
//                         position: _textSlideAnimation,
//                         child: FadeTransition(
//                           opacity: _textFadeAnimation,
//                           child: Column(
//                             children: [
//                               Text(
//                                 'QCMS',
//                                 style: TextStyle(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                   color: Appcolors.kprimarycolor,
//                                   letterSpacing: 1.5,
//                                   shadows: [
//                                     Shadow(
//                                       color: Appcolors.kprimarycolor.withAlpha(
//                                         77,
//                                       ),
//                                       offset: const Offset(0, 2),
//                                       blurRadius: 4,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Container(
//                                 width: 100,
//                                 height: 3,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Appcolors.ksecondarycolor,
//                                       Appcolors.kprimarycolor,
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(2),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               Text(
//                                 'Welcome to Qcomplaints',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Appcolors.kprimarycolor.withAlpha(200),
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 60),

//                       // Loading indicator
//                       FadeTransition(
//                         opacity: _textFadeAnimation,
//                         child: SpinKitThreeBounce(
//                           size: 20,
//                           color: Appcolors.kprimarycolor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qcms/core/appconstants.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/widgets/custom_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotateAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    // Logo animations - Start from visible values to prevent flash
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );
    _logoRotateAnimation = Tween<double>(begin: -0.1, end: 0.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutBack),
      ),
    );
    _logoOpacityAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeIn),
      ),
    );

    // Text animations - Start from slightly visible to prevent flash
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _textFadeAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));
    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
        );
  }

  void _startAnimationSequence() async {
    // Start logo animation
    _logoController.forward();

    // Start text animation after logo starts
    await Future.delayed(const Duration(milliseconds: 500));
    _textController.forward();

    // Wait for animations to complete, then navigate
    await Future.delayed(const Duration(milliseconds: 3000));
    _navigateToNextScreen();
  }

  // Check if onboarding has been completed
  Future<bool> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_completed') ?? false;
  }

  // Get user token to check if user is logged in
  Future<String> _getUserToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('USER_TOKEN') ?? '';
  }

  // Check if user is logged in (has valid token)
  Future<bool> _isUserLoggedIn() async {
    String token = await _getUserToken();
    return token.isNotEmpty;
  }

  void _navigateToNextScreen() async {
    try {
      // Check onboarding status and user authentication
      bool hasSeenOnboarding = await _checkOnboardingStatus();
      bool isLoggedIn = await _isUserLoggedIn();

      if (!mounted) return; // Check if widget is still mounted

      // Navigation logic:
      // 1. If onboarding not completed -> show onboarding
      // 2. If onboarding completed but not logged in -> show login
      // 3. If onboarding completed and logged in -> show main page
      
      if (!hasSeenOnboarding) {
        // First time user - show onboarding
        CustomNavigation.pushNamedAndRemoveUntil(
          context, 
          AppRouter.onboarding,
        );
      } else if (isLoggedIn) {
        // User has completed onboarding and is logged in - go to main page
        CustomNavigation.pushNamedAndRemoveUntil(
          context, 
          AppRouter.mainpage,
        );
      } else {
        // User has completed onboarding but not logged in - go to login
        CustomNavigation.pushNamedAndRemoveUntil(
          context, 
          AppRouter.login,
        );
      }
    } catch (e) {
      // Handle any errors by navigating to login as fallback
      print('Error in navigation logic: $e');
      if (mounted) {
        CustomNavigation.pushNamedAndRemoveUntil(
          context, 
          AppRouter.login,
        );
      }
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kbackgroundcolor,
      body: AnimatedBuilder(
        animation: Listenable.merge([_logoController, _textController]),
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Appcolors.kbackgroundcolor,
            child: Stack(
              children: [
                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo container with animations
                      Transform.rotate(
                        angle: _logoRotateAnimation.value,
                        child: Transform.scale(
                          scale: _logoScaleAnimation.value,
                          child: FadeTransition(
                            opacity: _logoOpacityAnimation,
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Appcolors.kprimarycolor,
                                    Appcolors.ksecondarycolor,
                                    Appcolors.kbordercolor,
                                  ],
                                ),
                              ),
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Appcolors.kprimarycolor,
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image.asset(
                                      Appconstants.whitelogo,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // App name with slide and fade animation
                      SlideTransition(
                        position: _textSlideAnimation,
                        child: FadeTransition(
                          opacity: _textFadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                'QCMS',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolors.kprimarycolor,
                                  letterSpacing: 1.5,
                                  shadows: [
                                    Shadow(
                                      color: Appcolors.kprimarycolor.withAlpha(77),
                                      offset: const Offset(0, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 100,
                                height: 3,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Appcolors.ksecondarycolor,
                                      Appcolors.kprimarycolor,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Welcome to Qcomplaints',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Appcolors.kprimarycolor.withAlpha(200),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 60),

                      // Loading indicator
                      FadeTransition(
                        opacity: _textFadeAnimation,
                        child: SpinKitThreeBounce(
                          size: 20,
                          color: Appcolors.kprimarycolor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}