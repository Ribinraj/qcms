import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';

import 'package:qcms/presentation/blocs/fetch_dashboard_bloc/fetch_dashboard_bloc.dart';
import 'package:qcms/presentation/blocs/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:qcms/widgets/custom_appbar.dart';
import 'package:qcms/widgets/custom_routes.dart';

class ScreenDashboardpage extends StatefulWidget {
  const ScreenDashboardpage({super.key});

  @override
  State<ScreenDashboardpage> createState() => _ScreenDashboardpageState();
}

class _ScreenDashboardpageState extends State<ScreenDashboardpage>
    with TickerProviderStateMixin {
  late AnimationController _headerAnimationController;
  late AnimationController _cardsAnimationController;
  late AnimationController _buttonsAnimationController;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _cardsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _buttonsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    context.read<FetchDashboardBloc>().add(FetchDashboardInitialEvent());
    context.read<FetchProfileBloc>().add(FetchProfileInitialEvent());
    // Start animations sequence
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _headerAnimationController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    _cardsAnimationController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _buttonsAnimationController.forward();
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _cardsAnimationController.dispose();
    _buttonsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FetchProfileBloc, FetchProfileState>(
      listener: (context, state) {
        if (state is FetchProfileErrorState &&
            state.message == "Expired token") {
          CustomNavigation.pushNamedAndRemoveUntil(context, AppRouter.login);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: "dashboard title".tr()),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 600),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  // Header Section with custom animation
                  AnimatedBuilder(
                    animation: _headerAnimationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          0,
                          50 * (1 - _headerAnimationController.value),
                        ),
                        child: Opacity(
                          opacity: _headerAnimationController.value,
                          child: _buildHeaderSection(),
                        ),
                      );
                    },
                  ),

                  ResponsiveSizedBox.height40,

                  // Stats Cards Grid with staggered animation
                  BlocBuilder<FetchDashboardBloc, FetchDashboardState>(
                    builder: (context, state) {
                      if (state is FetchDashboardLoadingState) {
                        return _buildLoadingGrid();
                      } else if (state is FetchDashboardErrorState) {
                        return AnimationConfiguration.synchronized(
                          duration: const Duration(milliseconds: 600),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Center(child: Text(state.message)),
                            ),
                          ),
                        );
                      } else if (state is FetchDashboardSuccessState) {
                        return _buildStatsGrid(state);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),

                  ResponsiveSizedBox.height40,

                  // Action Buttons with animation
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return CustomPaint(
      painter: HeaderPainter(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "dashboard indianrailways".tr(),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Appcolors.kwhitecolor,
                letterSpacing: 1,
              ),
            ),
            ResponsiveSizedBox.height10,
            Text(
              "dashboard subheading".tr(),
              style: TextStyle(
                fontSize: 15,
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w500,
              ),
            ),
            ResponsiveSizedBox.height5,
            Text(
              "dashboard crisant".tr(),
              style: TextStyle(
                fontSize: 12,
                color: const Color.fromARGB(255, 231, 142, 40),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingGrid() {
    return AnimationLimiter(
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
        children: List.generate(
          4,
          (index) => AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 600),
            columnCount: 2,
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(child: _buildStatLoadingCard()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsGrid(FetchDashboardSuccessState state) {
    final List<Map<String, dynamic>> statsData = [
      {
        'title': "dashboard totalcomplaints".tr(),
        'value': state.dashboard.totalComplaints,
      },
      {
        'title': "dashboard opencomplaints".tr(),
        'value': state.dashboard.openComplaints,
      },
      {
        'title': "dashboard assignedcomplaints".tr(),
        'value': state.dashboard.wipComplaints,
      },
      {
        'title': "dashboard resolvedcomplaints".tr(),
        'value': state.dashboard.completedComplaints,
      },
    ];

    return AnimationLimiter(
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
        children: List.generate(
          statsData.length,
          (index) => AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 800),
            columnCount: 2,
            child: ScaleAnimation(
              scale: 0.5,
              child: FadeInAnimation(
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: _buildStatCard(
                    title: statsData[index]['title'],
                    value: statsData[index]['value'],
                    color: Appcolors.ksecondarycolor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final List<Map<String, dynamic>> buttonData = [
      {
        'title': "dashboard newcomplaints".tr(),
        'icon': Icons.add,
        'onPressed': () => navigateToMainPageNamed(context, 1),
        'color': Appcolors.kprimarycolor,
      },
      {
        'title': "dashboard viewcomplaints".tr(),
        'icon': Icons.visibility,
        'onPressed': () => navigateToMainPageNamed(context, 2),
        'color': Appcolors.ksecondarycolor,
      },
    ];

    return AnimationConfiguration.synchronized(
      duration: const Duration(milliseconds: 400),
      child: SlideAnimation(
        verticalOffset: 30.0,
        child: FadeInAnimation(
          child: Row(
            children: List.generate(
              buttonData.length,
              (index) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    left: index == 0 ? 0 : 8,
                    right: index == buttonData.length - 1 ? 0 : 8,
                  ),
                  child: _buildActionButton(
                    title: buttonData[index]['title'],
                    icon: buttonData[index]['icon'],
                    onPressed: buttonData[index]['onPressed'],
                    color: buttonData[index]['color'],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return CustomPaint(
      painter: EnhancedCardPainter(color: color, radius: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Appcolors.kwhitecolor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Appcolors.kwhitecolor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatLoadingCard() {
    return CustomPaint(
      painter: EnhancedCardPainter(
        color: Appcolors.ksecondarycolor,
        radius: 10,
      ),
      child: Container(
        child: Center(
          child: SpinKitCircle(size: 15, color: Appcolors.kwhitecolor),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return CustomPaint(
      painter: ButtonPainter(color: color, radius: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Appcolors.kwhitecolor, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Appcolors.kwhitecolor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
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
// class ScreenDashboardpage extends StatefulWidget {
//   const ScreenDashboardpage({super.key});

//   @override
//   State<ScreenDashboardpage> createState() => _ScreenDashboardpageState();
// }

// class _ScreenDashboardpageState extends State<ScreenDashboardpage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     context.read<FetchDashboardBloc>().add(FetchDashboardInitialEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: const CustomAppBar(title: 'Dashboard'),
//        appBar: CustomAppBar(title: "dashboard title".tr()),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Section
//             CustomPaint(
//               painter: HeaderPainter(),
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       "dashboard indianrailways".tr(),

//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: Appcolors.kwhitecolor,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                     ResponsiveSizedBox.height10,

//                     Text(
//                      "dashboard subheading".tr(),
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: const Color.fromARGB(255, 255, 255, 255),
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     ResponsiveSizedBox.height5,
//                     Text(
//                       "dashboard crisant".tr(),
//                       style: TextStyle(
//                         fontSize: 10,
//                         color: const Color.fromARGB(255, 231, 142, 40),
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             ResponsiveSizedBox.height40,

//             // Stats Cards Grid
//             BlocBuilder<FetchDashboardBloc, FetchDashboardState>(
//               builder: (context, state) {
//                 if (state is FetchDashboardLoadingState) {
//                   return GridView.count(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 1.1,
//                     children: [
//                    _buildStatLoadingCard(),
//                    _buildStatLoadingCard(),
//                     _buildStatLoadingCard(),
//          _buildStatLoadingCard(),
//                     ],
//                   );
//                 } else if (state is FetchDashboardErrorState) {
//                   return Center(child: Text(state.message));
//                 } else if (state is FetchDashboardSuccessState) {
//                   return GridView.count(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 1.1,
//                     children: [
//                       _buildStatCard(
//                         title: "dashboard totalcomplaints".tr(),
//                         value: state.dashboard.totalComplaints,

//                         color: Appcolors.ksecondarycolor,
//                       ),
//                       _buildStatCard(
//                         title: "dashboard opencomplaints".tr(),
//                         value: state.dashboard.openComplaints,

//                         color: Appcolors.ksecondarycolor,
//                       ),
//                       _buildStatCard(
//                         title: "dashboard assignedcomplaints".tr(),
//                         value: state.dashboard.wipComplaints,

//                         color: Appcolors.ksecondarycolor,
//                       ),
//                       _buildStatCard(
//                         title:"dashboard resolvedcomplaints".tr(),
//                         value: state.dashboard.completedComplaints,

//                         color: Appcolors.ksecondarycolor,
//                       ),
//                     ],
//                   );
//                 } else {
//                   return SizedBox.shrink();
//                 }
//               },
//             ),

//             ResponsiveSizedBox.height40,

//             // Action Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildActionButton(
//                     title: "dashboard newcomplaints".tr(),
//                     icon: Icons.add,
//                     onPressed: () {
//                       navigateToMainPageNamed(context, 1);
//                     },
//                     color: Appcolors.kprimarycolor,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: _buildActionButton(
//                     title: "dashboard viewcomplaints".tr(),
//                     icon: Icons.visibility,
//                     onPressed: () {
//                       navigateToMainPageNamed(context, 2);
//                     },
//                     color: Appcolors.ksecondarycolor,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStatCard({
//     required String title,
//     required String value,

//     required Color color,
//   }) {
//     return CustomPaint(
//       painter: EnhancedCardPainter(color: color, radius: 10),
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 38,
//                 fontWeight: FontWeight.bold,
//                 color: Appcolors.kwhitecolor,
//               ),
//             ),

//             const SizedBox(height: 8),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 15,
//                 color: Appcolors.kwhitecolor,
//                 // shadows: [
//                 //   Shadow(
//                 //     offset: Offset(2.0, 2.0), // x, y position of the shadow
//                 //     blurRadius: 4.0, // how blurry the shadow is
//                 //     color: Color.fromARGB(255, 118, 101, 101), // shadow color
//                 //   ),
//                 // ],
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildStatLoadingCard() {
//     return CustomPaint(
//       painter: EnhancedCardPainter(color:Appcolors.ksecondarycolor, radius: 10),
//       child:Container(

//         child: Center(child: SpinKitCircle(size: 15,color: Appcolors.kwhitecolor,),)),

//     );
//   }
//   Widget _buildActionButton({
//     required String title,
//     required IconData icon,
//     required VoidCallback onPressed,
//     required Color color,
//   }) {
//     return CustomPaint(
//       painter: ButtonPainter(color: color, radius: 8),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onPressed,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(icon, color: Appcolors.kwhitecolor, size: 20),
//                 const SizedBox(width: 8),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     color: Appcolors.kwhitecolor,
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

////////////////////////
class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Appcolors.kprimarycolor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 20);
    path.quadraticBezierTo(0, 0, 20, 0);
    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20);
    path.lineTo(size.width, size.height - 20);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - 20,
      size.height,
    );
    path.lineTo(20, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 20);
    path.close();

    canvas.drawPath(path, paint);

    // Add subtle decoration
    final decorPaint = Paint()
      ..color = Appcolors.kwhitecolor.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.2),
      30,
      decorPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.8),
      20,
      decorPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ButtonPainter extends CustomPainter {
  final Color color;
  final double radius; // <-- Add radius control

  ButtonPainter({
    required this.color,
    this.radius = 8,
  }); // Default to 8 for smaller radius

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final r = radius; // just to shorten usage

    final path = Path();
    path.moveTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);
    path.lineTo(size.width - r, 0);
    path.quadraticBezierTo(size.width, 0, size.width, r);
    path.lineTo(size.width, size.height - r);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - r,
      size.height,
    );
    path.lineTo(r, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - r);
    path.close();

    canvas.drawPath(path, paint);

    // Optional: highlight path with same reduced radius
    final highlightPaint = Paint()
      ..color = Appcolors.kwhitecolor.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final highlightPath = Path();
    highlightPath.moveTo(0, r);
    highlightPath.quadraticBezierTo(0, 0, r, 0);
    highlightPath.lineTo(size.width - r, 0);
    highlightPath.quadraticBezierTo(size.width, 0, size.width, r);
    highlightPath.lineTo(size.width, size.height * 0.5);
    highlightPath.lineTo(0, size.height * 0.5);
    highlightPath.close();

    canvas.drawPath(highlightPath, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class EnhancedCardPainter extends CustomPainter {
  final Color color;
  final double radius; // ✅ add this

  EnhancedCardPainter({
    required this.color,
    this.radius = 20, // ✅ default radius
  });

  @override
  void paint(Canvas canvas, Size size) {
    // ✅ Use dynamic radius here
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color, color.withOpacity(0.8), color.withOpacity(0.9)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRRect(rrect, gradientPaint);

    // Optional decorative elements
    final decorPaint = Paint()
      ..color = Appcolors.kwhitecolor.withOpacity(0.12)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width - 20, 20), 15, decorPaint);
    canvas.drawCircle(Offset(20, size.height - 20), 12, decorPaint);

    final smallDotPaint = Paint()
      ..color = Appcolors.kwhitecolor.withOpacity(0.08);

    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.2),
      6,
      smallDotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.8),
      8,
      smallDotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.7),
      4,
      smallDotPaint,
    );

    final accentPaint = Paint()
      ..color = Appcolors.kwhitecolor.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final accentPath = Path();
    accentPath.moveTo(size.width * 0.7, size.height * 0.3);
    accentPath.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.5,
      size.width * 0.8,
      size.height * 0.7,
    );

    canvas.drawPath(accentPath, accentPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
