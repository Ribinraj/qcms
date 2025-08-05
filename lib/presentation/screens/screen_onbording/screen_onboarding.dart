import 'package:flutter/material.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/core/responsiveutils.dart';

import 'package:qcms/widgets/custom_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;

  // Onboarding data
  List<OnboardingData> onboardingPages = [
    OnboardingData(
      image: 'assets/images/slider_01.png', // Add your image path
      title: 'Welcome to QCMS',
      description:
          "India's #1 Quarters Complaint Management System designed for Indian Railway quarters to enhahnce the tenant experience.",
    ),
    OnboardingData(
      image: 'assets/images/slider_02.png', // Add your image path
      title: 'Solution for Happy Living',
      description:
          "Crafted with a vision to elevate the resident experience and deliver seamless solutions for a joyful living experience.",
    ),
    OnboardingData(
      image: 'assets/images/slider_03.png', // Add your image path
      title: 'Never miss any complaint',
      description:
          "The system is designed to ensure that no complaint goes unnoticed. Its robust functionality includes mechanisms to capture and address every complaint promptly, preventing any oversight or omission.",
    ),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Skip button (only show on first two pages)
          ResponsiveSizedBox.height20,
          if (currentIndex < 2)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () => _completeOnboarding(),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Appcolors.ksecondarycolor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          else
            SizedBox(
              height: ResponsiveUtils.hp(10),
            ), // Same height as skip button
          // Page view
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: onboardingPages.length,
              itemBuilder: (context, index) {
                return _buildOnboardingPage(onboardingPages[index]);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Centered Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingPages.length,
                    (index) => _buildIndicator(index),
                  ),
                ),

                // Button aligned to the right
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      if (currentIndex == onboardingPages.length - 1) {
                        _completeOnboarding();
                      } else {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == onboardingPages.length - 1
                            ? Appcolors.ksecondarycolor
                            : Appcolors.kprimarycolor,
                      ),
                      child: Icon(
                        currentIndex == onboardingPages.length - 1
                            ? Icons.done_all
                            : Icons.arrow_forward,
                        color: Colors.white,
                        size: 24,
                        weight: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom section with indicators and buttons
          // Padding(
          //   padding: EdgeInsets.all(20),
          //   child: Row(
          //     // mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       // Centered Indicators
          //       Expanded(
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: List.generate(
          //             onboardingPages.length,
          //             (index) => _buildIndicator(index),
          //           ),
          //         ),
          //       ),
          //       // Next Button
          //       GestureDetector(
          //         onTap: () {
          //           if (currentIndex == onboardingPages.length - 1) {
          //             // Handle last page action (e.g., navigate to main app)
          //           } else {
          //             // Move to next page
          //             pageController.nextPage(
          //               duration: const Duration(milliseconds: 300),
          //               curve: Curves.easeInOut,
          //             );
          //           }
          //         },
          //         child: Container(
          //           padding: const EdgeInsets.all(7),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: currentIndex == onboardingPages.length - 1
          //                 ? Appcolors.ksecondarycolor
          //                 : Appcolors.kprimarycolor,
          //           ),
          //           child: Icon(
          //             currentIndex == onboardingPages.length - 1
          //                 ? Icons.check
          //                 : Icons.arrow_forward,
          //             color: Colors.white,
          //             size: 24,
          //             weight: 10,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          ResponsiveSizedBox.height50,
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingData data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          SizedBox(
            height: ResponsiveUtils.hp(35),
            width: double.infinity,
            child: Image.asset(
              data.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Fallback widget if image not found
                return Container(
                  height: ResponsiveUtils.hp(35),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 151, 149, 149),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.image, size: 80, color: Colors.grey[400]),
                );
              },
            ),
          ),

          ResponsiveSizedBox.height50,

          // Title
          Text(
            data.title,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          ResponsiveSizedBox.height10,

          // Description
          Text(
            data.description,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 6,
      width: currentIndex == index ? 24 : 6,
      decoration: BoxDecoration(
        color: currentIndex == index
            ? Appcolors.kprimarycolor
            : Appcolors.ksecondarycolor,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void _completeOnboarding() async {
    // Save that onboarding is completed
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);

    // Navigate to main page using your custom navigation
    if (!mounted) return;
    CustomNavigation.pushNamedAndRemoveUntil(
      context,
      AppRouter.login,
      // AppRouter.main,
      // arguments: {'pageIndex': 0},
    );
  }
}

// Data model for onboarding pages
class OnboardingData {
  final String image;
  final String title;
  final String description;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}
