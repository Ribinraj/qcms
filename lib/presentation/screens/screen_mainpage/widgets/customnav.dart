import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qcms/core/colors.dart';
import 'package:qcms/core/responsiveutils.dart';
import 'package:qcms/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';

class BottomNavigationWidget extends StatelessWidget {
  final void Function(int)? onTap;
  const BottomNavigationWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.currentPageIndex,
          onTap: onTap,

          type: BottomNavigationBarType.fixed,
          backgroundColor: Appcolors.kprimarycolor,
          selectedItemColor: Appcolors.kwhitecolor,
          unselectedItemColor: const Color.fromARGB(255, 245, 146, 113),
          // selectedIconTheme: const IconThemeData(color: Appcolors.kblackcolor),
          unselectedIconTheme: IconThemeData(
            color: const Color.fromARGB(255, 245, 146, 113),
          ),
          selectedLabelStyle: const TextStyle(fontSize: 10),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home,
                color: Appcolors.kwhitecolor,
                size: ResponsiveUtils.wp(7),
              ),
              icon: Icon(Icons.home_outlined, size: ResponsiveUtils.wp(7)),
              label: "bottombar dashboard".tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add, size: ResponsiveUtils.wp(7)),
              activeIcon: Icon(
                Icons.add_circle_outline,
                color: Appcolors.kwhitecolor,
                size: ResponsiveUtils.wp(7),
              ),
              label: "bottombar new".tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded, size: ResponsiveUtils.wp(7)),
              activeIcon: Icon(
                Icons.list_rounded,
                color: Appcolors.kwhitecolor,
                size: ResponsiveUtils.wp(7),
              ),
              label: "bottombar mycomplaints".tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined, size: ResponsiveUtils.wp(7)),
              activeIcon: Icon(
                Icons.person,
                color: Appcolors.kwhitecolor,
                size: ResponsiveUtils.wp(7),
              ),
              label: "bottombar profile".tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined, size: ResponsiveUtils.wp(7)),
              activeIcon: Icon(
                Icons.settings,
                color: Appcolors.kwhitecolor,
                size: ResponsiveUtils.wp(7),
              ),
              label: "bottombar settings".tr(),
            ),
          ],
        );
      },
    );
  }
}
