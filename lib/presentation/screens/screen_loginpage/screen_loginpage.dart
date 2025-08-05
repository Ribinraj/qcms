import 'package:flutter/material.dart';
import 'package:qcms/core/appconstants.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/core/responsiveutils.dart';
import 'package:qcms/widgets/custom_loginbutton.dart';

class ScreenLoginpage extends StatefulWidget {
  const ScreenLoginpage({super.key});

  @override
  QCMSLoginScreenState createState() => QCMSLoginScreenState();
}

class QCMSLoginScreenState extends State<ScreenLoginpage> {
  final TextEditingController _mobileController = TextEditingController();
  final FocusNode _mobileFocusNode = FocusNode();

  @override
  void dispose() {
    _mobileController.dispose();
    _mobileFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 240, 235),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ResponsiveSizedBox.height50,
            ResponsiveSizedBox.height(8),
            // QCMS Logo
            SizedBox(
              height: ResponsiveUtils.hp(8),
              width: double.infinity,
              child: Image.asset(
                Appconstants.appLogo,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback widget if image not found
                  return Container(
                    height: ResponsiveUtils.hp(8),
                    width: ResponsiveUtils.wp(8),

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 151, 149, 149),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.image, size: 30, color: Colors.grey[400]),
                  );
                },
              ),
            ),

            ResponsiveSizedBox.height20,
            TextStyles.subheadline(text: 'Welcome to QCMS'),

            ResponsiveSizedBox.height(5),

            // Mobile Number Input
            Align(
              alignment: Alignment.centerLeft,
              child: TextStyles.body(text: 'Mobile Number*'),
            ),

            ResponsiveSizedBox.height10,

            Container(
              decoration: BoxDecoration(
                color: Color(0xFFE8E4F3),

                border: Border(
                  bottom: BorderSide(color: Appcolors.kbordercolor, width: 1.5),
                ),
              ),
              child: TextField(
                controller: _mobileController,
                focusNode: _mobileFocusNode,
                keyboardType: TextInputType.phone,
                style: TextStyle(fontSize: 16, color: Colors.black87),
                decoration: InputDecoration(
                  hintText: 'Please enter your Mobile Number',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 108, 106, 106),
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                ),
              ),
            ),

            ResponsiveSizedBox.height30,

            Customloginbutton(onPressed: () {}, text: 'Login'),
            ResponsiveSizedBox.height10,
            Divider(),
            ResponsiveSizedBox.height20,

            // Feature Cards
            _buildFeatureCard(
              icon: Icons.home_work_rounded,
              title: 'Register Your Flat',
              description:
                  'If your flat is missing in the quarters, please register your flat details here.',
              onTap: () {},
            ),

            _buildFeatureCard(
              icon: Icons.business_center_rounded,
              title: 'Enroll Your Division',
              description:
                  'If you wish to have your division enrolled in the system, please submit your details here.',
              onTap: () {},
            ),

            ResponsiveSizedBox.height10,

            // Footer with better styling
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.6),
                    Colors.white.withOpacity(0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.privacy_tip_outlined,
                      size: 16,
                      color: Appcolors.kprimarycolor,
                    ),
                    label: TextStyles.body(
                      text: 'Privacy Policy',
                      color: Appcolors.kprimarycolor,
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 1,
                    color: Appcolors.kprimarycolor.withOpacity(.4),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Appcolors.kprimarycolor,
                    ),
                    label: TextStyles.body(
                      text: 'Disclaimer',
                      color: Appcolors.kprimarycolor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            // Divider(),
            // ResponsiveSizedBox.height20,

            // // Register Flat Section
            // Text(
            //   'If your flat is missing in the quarters, please\nregister your flat details here.',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 14,
            //     color: Colors.black87,
            //     height: 1.4,
            //   ),
            // ),

            // ResponsiveSizedBox.height20,

            // SizedBox(
            //   width: double.infinity,
            //   height: 45,
            //   child: OutlinedButton(
            //     onPressed: () {},
            //     style: OutlinedButton.styleFrom(
            //       side: BorderSide(color: Appcolors.kbordercolor, width: 1),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     child: TextStyles.body(
            //       text: 'Register Now',
            //       color: Appcolors.kprimarycolor,
            //       weight: FontWeight.w600,
            //     ),
            //   ),
            // ),

            // ResponsiveSizedBox.height20,
            // Divider(),
            // ResponsiveSizedBox.height20,

            // // Submit Division Details Section
            // Text(
            //   'If you wish to have your division enrolled in the\nsystem, please submit your details here.',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 15,
            //     color: Colors.black87,
            //     height: 1.4,
            //   ),
            // ),

            // ResponsiveSizedBox.height10,

            // TextButton(
            //   onPressed: () {
            //     // Handle submit details logic
            //     print('Submit Details pressed');
            //   },
            //   child: Text(
            //     'Submit Details',
            //     style: TextStyle(
            //       fontSize: 15,
            //       fontWeight: FontWeight.w600,
            //       color: Appcolors.kprimarycolor,
            //     ),
            //   ),
            // ),

            // Divider(),

            // // Footer Links
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     TextButton(
            //       onPressed: () {
            //         // Handle privacy policy
            //         print('Privacy Policy pressed');
            //       },
            //       child: TextStyles.body(text: 'Privacy Policy'),
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         // Handle disclaimer
            //         print('Disclaimer pressed');
            //       },
            //       child: TextStyles.body(text: 'Disclaimer'),
            //     ),
            //   ],
            // ),

            // SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.8),
            Colors.white.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Appcolors.kbordercolor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Appcolors.kbordercolor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icon,
                        color: Appcolors.kbordercolor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextStyles.body(
                        text: title,
                        weight: FontWeight.w600,
                        color: Appcolors.kprimarycolor,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Appcolors.kblackcolor,
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Appcolors.kblackcolor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:qcms/core/appconstants.dart';
// import 'package:qcms/core/colors.dart';
// import 'package:qcms/core/constants.dart';
// import 'package:qcms/core/responsiveutils.dart';
// import 'package:qcms/widgets/custom_loginbutton.dart';

// class ScreenLoginpage extends StatefulWidget {
//   const ScreenLoginpage({super.key});

//   @override
//   QCMSLoginScreenState createState() => QCMSLoginScreenState();
// }

// class QCMSLoginScreenState extends State<ScreenLoginpage> with TickerProviderStateMixin {
//   final TextEditingController _mobileController = TextEditingController();
//   final FocusNode _mobileFocusNode = FocusNode();
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 1200),
//       vsync: this,
//     );
    
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
    
//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0, 0.3),
//       end: Offset(0, 0),
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeOutCubic,
//     ));
    
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _mobileController.dispose();
//     _mobileFocusNode.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   Widget _buildGradientCard({required Widget child, double? height}) {
//     return Container(
//       height: height,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Colors.white.withOpacity(0.9),
//             Colors.white.withOpacity(0.7),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: Offset(0, 10),
//           ),
//         ],
//         border: Border.all(
//           color: Colors.white.withOpacity(0.3),
//           width: 1,
//         ),
//       ),
//       child: child,
//     );
//   }

//   Widget _buildAnimatedTextField() {
//     return AnimatedBuilder(
//       animation: _mobileFocusNode,
//       builder: (context, child) {
//         return AnimatedContainer(
//           duration: Duration(milliseconds: 300),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: _mobileFocusNode.hasFocus
//                   ? [Color(0xFFE8E4F3), Color(0xFFF0ECFF)]
//                   : [Color(0xFFE8E4F3), Color(0xFFE8E4F3)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: _mobileFocusNode.hasFocus 
//                   ? Appcolors.kbordercolor.withOpacity(0.8)
//                   : Colors.transparent,
//               width: 2,
//             ),
//             boxShadow: _mobileFocusNode.hasFocus
//                 ? [
//                     BoxShadow(
//                       color: Appcolors.kbordercolor.withOpacity(0.2),
//                       blurRadius: 8,
//                       offset: Offset(0, 4),
//                     ),
//                   ]
//                 : null,
//           ),
//           child: TextField(
//             controller: _mobileController,
//             focusNode: _mobileFocusNode,
//             keyboardType: TextInputType.phone,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.black87,
//               fontWeight: FontWeight.w500,
//             ),
//             decoration: InputDecoration(
//               hintText: 'Please enter your Mobile Number',
//               hintStyle: TextStyle(
//                 color: Colors.grey[500],
//                 fontSize: 15,
//               ),
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 16,
//               ),
//               prefixIcon: Icon(
//                 Icons.phone_android_rounded,
//                 color: _mobileFocusNode.hasFocus 
//                     ? Appcolors.kbordercolor 
//                     : Colors.grey[400],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

 

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFF5F0EB),
//               Color(0xFFF0EBE6),
//               Color(0xFFEBE6E1),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: 24.0),
//             child: FadeTransition(
//               opacity: _fadeAnimation,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   ResponsiveSizedBox.height(4),
                  
//                   // Logo Section with enhanced styling
//                   SlideTransition(
//                     position: _slideAnimation,
//                     child: Container(
//                       height: ResponsiveUtils.hp(12),
//                       width: double.infinity,
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.white.withOpacity(0.9),
//                             Colors.white.withOpacity(0.7),
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 20,
//                             offset: Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Image.asset(
//                         Appconstants.appLogo,
//                         fit: BoxFit.contain,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Appcolors.kbordercolor.withOpacity(0.8),
//                                   Appcolors.kbordercolor.withOpacity(0.6),
//                                 ],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Icon(
//                               Icons.apartment_rounded,
//                               size: 40,
//                               color: Colors.white,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),

//                   ResponsiveSizedBox.height20,
                  
//                   SlideTransition(
//                     position: _slideAnimation,
//                     child: Column(
//                       children: [
//                         TextStyles.subheadline(text: 'Welcome to QCMS'),
//                         SizedBox(height: 8),
//                         Text(
//                           'Quarter Colony Management System',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[600],
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   ResponsiveSizedBox.height(4),

//                   // Login Form Card
//                   SlideTransition(
//                     position: _slideAnimation,
//                     child: _buildGradientCard(
//                       child: Padding(
//                         padding: EdgeInsets.all(24),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.login_rounded,
//                                   color: Appcolors.kbordercolor,
//                                   size: 20,
//                                 ),
//                                 SizedBox(width: 8),
//                                 TextStyles.body(
//                                   text: 'Mobile Number*',
//                                   weight: FontWeight.w600,
//                                 ),
//                               ],
//                             ),
//                             ResponsiveSizedBox.height10,
//                             _buildAnimatedTextField(),
//                             ResponsiveSizedBox.height20,
//                             Customloginbutton(
//                               onPressed: () {},
//                               text: 'Login',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),

       
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }