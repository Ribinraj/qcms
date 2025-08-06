import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcms/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:qcms/presentation/screens/screen_dashboard/screen_dashboardpage.dart';
import 'package:qcms/presentation/screens/screen_mainpage/widgets/customnav.dart';
import 'package:qcms/presentation/screens/screen_mycomplaints/screen_mycomplaintspage.dart';
import 'package:qcms/presentation/screens/screen_newcomplaint/screen_newcomplaintpage.dart';
import 'package:qcms/presentation/screens/screen_settings/screen_settings.dart';
import 'package:qcms/presentation/screens/screenprofilepage/screenprofilepage.dart';

class ScreenMainPage extends StatefulWidget {
  const ScreenMainPage({super.key});

  @override
  State<ScreenMainPage> createState() => _ScreenMainPageState();
}

class _ScreenMainPageState extends State<ScreenMainPage> {
  final List<Widget> _pages = [
    ScreenDashboardpage(),
    ScreenNewcomplaintpage(),
    ScreenMycomplaintspage(),
    Screenprofilepage(),
    ScreenSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return Scaffold(
          //backgroundColor: const Color.fromARGB(255, 248, 232, 227),
          body: _pages[state.currentPageIndex],
          bottomNavigationBar: BottomNavigationWidget(
            onTap: (index) {
              context.read<BottomNavigationBloc>().add(
                NavigateToPageEvent(pageIndex: index),
              );
            },
          ),
        );
      },
    );
  }
}
