// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:qcms/core/colors.dart';
// import 'package:qcms/core/constants.dart';

// import 'package:qcms/presentation/blocs/language_cubit.dart';
// import 'package:qcms/widgets/custom_appbar.dart';
// import 'package:qcms/widgets/logout_utils.dart';



// class ScreenSettingsPage extends StatefulWidget {
//   const ScreenSettingsPage({super.key});

//   @override
//   State<ScreenSettingsPage> createState() => _ScreenSettingsPageState();
// }

// class _ScreenSettingsPageState extends State<ScreenSettingsPage> {
//   String selectedLanguage = 'English';
//   bool isLanguageExpanded = false;
//   bool isPushNotificationsEnabled = true; // Add this state variable

//   final Map<String, Map<String, String>> languages = {
//     'English': {'code': 'en', 'display': 'English'},
//     'Hindi': {'code': 'hi', 'display': 'हिन्दी'},
//     'Kannada': {'code': 'kn', 'display': 'ಕನ್ನಡ'},
//   };



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Appcolors.kbackgroundcolor,
//       appBar: CustomAppBar(title: "settings title".tr()),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Section
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Appcolors.kprimarycolor, Appcolors.ksecondarycolor],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Appcolors.kprimarycolor.withAlpha(77),
//                     blurRadius: 12,
//                     offset: const Offset(0, 6),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Icon(Icons.settings, size: 48, color: Appcolors.kwhitecolor),
//                   ResponsiveSizedBox.height15,
//                   Text(
//                     "settings title".tr(),
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Appcolors.kwhitecolor,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "settings subtitle".tr(),
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Appcolors.kwhitecolor.withAlpha(230),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 32),

//             // Settings Sections
//             _buildSectionTitle("settings general".tr()),
//             const SizedBox(height: 16),

//             // Language Setting Card
//             _buildSettingCard(
//               icon: Icons.language,
//               title: "settings language".tr(),
//               subtitle: 'Choose your preferred language',
//               child: _buildLanguageDropdown(),
//             ),

//             ResponsiveSizedBox.height30,

//             // // Push Notifications Setting Card
//             // _buildSettingCard(
//             //   icon: Icons.notifications_outlined,
//             //   title: "settings notifications".tr(),
//             //   subtitle: 'Receive push notifications',
//             //   child: _buildNotificationToggle(),
//             // ),

//             // ResponsiveSizedBox.height40,
//             _buildSectionTitle("settings account".tr()),
//             const SizedBox(height: 16),

//             // Logout Button
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Appcolors.kredcolor.withAlpha(51),
//                     blurRadius: 8,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: ElevatedButton(
//                 onPressed: () {
//                   _showLogoutDialog();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Appcolors.kredcolor,
//                   foregroundColor: Appcolors.kwhitecolor,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.logout, size: 20),
//                     const SizedBox(width: 8),
//                     Text(
//                       "settings logout".tr(),
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }


//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: Appcolors.kprimarycolor,
//       ),
//     );
//   }

//   Widget _buildSettingCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     Widget? child,
//     Widget? trailing,
//     VoidCallback? onTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Appcolors.kwhitecolor,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Appcolors.kblackcolor.withAlpha(26),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(12),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Appcolors.kprimarycolor.withAlpha(26),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Icon(
//                         icon,
//                         color: Appcolors.kprimarycolor,
//                         size: 24,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             title,
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Appcolors.kblackcolor,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             subtitle,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Appcolors.kblackcolor.withAlpha(153),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     if (trailing != null) trailing,
//                   ],
//                 ),
//                 if (child != null) ...[const SizedBox(height: 16), child],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLanguageDropdown() {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               isLanguageExpanded = !isLanguageExpanded;
//             });
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               border: Border.all(color: Appcolors.kbordercolor),
//               borderRadius: BorderRadius.circular(8),
//               color: Appcolors.kbackgroundcolor,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   languages[selectedLanguage]!['display']!,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Appcolors.kblackcolor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 AnimatedRotation(
//                   turns: isLanguageExpanded ? 0.5 : 0,
//                   duration: const Duration(milliseconds: 200),
//                   child: Icon(
//                     Icons.keyboard_arrow_down,
//                     color: Appcolors.kprimarycolor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           height: isLanguageExpanded ? null : 0,
//           child: AnimatedOpacity(
//             opacity: isLanguageExpanded ? 1.0 : 0.0,
//             duration: const Duration(milliseconds: 300),
//             child: Container(
//               margin: const EdgeInsets.only(top: 8),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Appcolors.kbordercolor),
//                 borderRadius: BorderRadius.circular(8),
//                 color: Appcolors.kwhitecolor,
//               ),
//               child: Column(
//                 children: languages.entries.map((entry) {
//                   final isSelected = selectedLanguage == entry.key;
//                   return Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {
//                           selectedLanguage = entry.key;
//                           isLanguageExpanded = false;
//                         });
//                         context.read<LanguageCubit>().changeLanguage(
//                           context,
//                           Locale(entry.value['code']!),
//                         );
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           color: isSelected
//                               ? Appcolors.kprimarycolor.withAlpha(26)
//                               : Colors.transparent,
//                         ),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 entry.value['display']!,
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: isSelected
//                                       ? Appcolors.kprimarycolor
//                                       : Appcolors.kblackcolor,
//                                   fontWeight: isSelected
//                                       ? FontWeight.w600
//                                       : FontWeight.normal,
//                                 ),
//                               ),
//                             ),
//                             if (isSelected)
//                               Icon(
//                                 Icons.check,
//                                 color: Appcolors.kprimarycolor,
//                                 size: 20,
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> _showLogoutDialog() {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: Row(
//             children: [
//               Icon(Icons.logout, color: Appcolors.kredcolor),
//               const SizedBox(width: 8),
//               Text(
//                 'Logout',
//                 style: TextStyle(
//                   color: Appcolors.kblackcolor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           content: Text(
//             'Are you sure you want to logout?',
//             style: TextStyle(color: Appcolors.kblackcolor.withAlpha(204)),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text(
//                 'Cancel',
//                 style: TextStyle(color: Appcolors.kblackcolor.withAlpha(179)),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Appcolors.kredcolor,
//                 foregroundColor: Appcolors.kwhitecolor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text('Logout'),
//               onPressed: () async {
//                 await AuthUtils.handleLogout(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:qcms/presentation/blocs/language_cubit.dart';
import 'package:qcms/widgets/custom_appbar.dart';
import 'package:qcms/widgets/logout_utils.dart';

class ScreenSettingsPage extends StatefulWidget {
  const ScreenSettingsPage({super.key});

  @override
  State<ScreenSettingsPage> createState() => _ScreenSettingsPageState();
}

class _ScreenSettingsPageState extends State<ScreenSettingsPage> {
  String selectedLanguage = 'English';
  bool isLanguageExpanded = false;
  bool isPushNotificationsEnabled = true;

  final Map<String, Map<String, String>> languages = {
    'English': {'code': 'en', 'display': 'English'},
    'Hindi': {'code': 'hi', 'display': 'हिन्दी'},
    'Kannada': {'code': 'kn', 'display': 'ಕನ್ನಡ'},
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadSavedLanguage();
  }

  // Load the saved language from SharedPreferences and current context
  void _loadSavedLanguage() {
    try {
      // Get current app locale
      final currentLocale = context.locale;
      
      // Find the matching language key based on locale code
      String languageKey = 'English'; // default
      
      for (var entry in languages.entries) {
        if (entry.value['code'] == currentLocale.languageCode) {
          languageKey = entry.key;
          break;
        }
      }
      
      // Only update if the language has actually changed to avoid unnecessary rebuilds
      if (selectedLanguage != languageKey) {
        setState(() {
          selectedLanguage = languageKey;
        });
      }
    } catch (e) {
      print('Error loading saved language: $e');
      // Keep default English if there's an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kbackgroundcolor,
      appBar: CustomAppBar(title: "settings title".tr()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Appcolors.kprimarycolor, Appcolors.ksecondarycolor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Appcolors.kprimarycolor.withAlpha(77),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.settings, size: 48, color: Appcolors.kwhitecolor),
                  ResponsiveSizedBox.height15,
                  Text(
                    "settings title".tr(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Appcolors.kwhitecolor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "settings subtitle".tr(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Appcolors.kwhitecolor.withAlpha(230),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Settings Sections
            _buildSectionTitle("settings general".tr()),
            const SizedBox(height: 16),

            // Language Setting Card
            _buildSettingCard(
              icon: Icons.language,
              title: "settings language".tr(),
              subtitle: 'Choose your preferred language',
              child: _buildLanguageDropdown(),
            ),

            ResponsiveSizedBox.height30,

            _buildSectionTitle("settings account".tr()),
            const SizedBox(height: 16),

            // Logout Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Appcolors.kredcolor.withAlpha(51),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolors.kredcolor,
                  foregroundColor: Appcolors.kwhitecolor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "settings logout".tr(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Appcolors.kprimarycolor,
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? child,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Appcolors.kwhitecolor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Appcolors.kblackcolor.withAlpha(26),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Appcolors.kprimarycolor.withAlpha(26),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icon,
                        color: Appcolors.kprimarycolor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Appcolors.kblackcolor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: Appcolors.kblackcolor.withAlpha(153),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (trailing != null) trailing,
                  ],
                ),
                if (child != null) ...[const SizedBox(height: 16), child],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isLanguageExpanded = !isLanguageExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Appcolors.kbordercolor),
              borderRadius: BorderRadius.circular(8),
              color: Appcolors.kbackgroundcolor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  languages[selectedLanguage]!['display']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Appcolors.kblackcolor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AnimatedRotation(
                  turns: isLanguageExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Appcolors.kprimarycolor,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isLanguageExpanded ? null : 0,
          child: AnimatedOpacity(
            opacity: isLanguageExpanded ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Appcolors.kbordercolor),
                borderRadius: BorderRadius.circular(8),
                color: Appcolors.kwhitecolor,
              ),
              child: Column(
                children: languages.entries.map((entry) {
                  final isSelected = selectedLanguage == entry.key;
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          selectedLanguage = entry.key;
                          isLanguageExpanded = false;
                        });
                        
                        // Change language using the cubit
                        await context.read<LanguageCubit>().changeLanguage(
                          context,
                          Locale(entry.value['code']!),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Appcolors.kprimarycolor.withAlpha(26)
                              : Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                entry.value['display']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSelected
                                      ? Appcolors.kprimarycolor
                                      : Appcolors.kblackcolor,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check,
                                color: Appcolors.kprimarycolor,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showLogoutDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.logout, color: Appcolors.kredcolor),
              const SizedBox(width: 8),
              Text(
                'Logout',
                style: TextStyle(
                  color: Appcolors.kblackcolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Appcolors.kblackcolor.withAlpha(204)),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Appcolors.kblackcolor.withAlpha(179)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolors.kredcolor,
                foregroundColor: Appcolors.kwhitecolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Logout'),
              onPressed: () async {
                await AuthUtils.handleLogout(context);
              },
            ),
          ],
        );
      },
    );
  }
}