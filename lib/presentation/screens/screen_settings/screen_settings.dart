import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/presentation/blocs/language_cubit.dart';
import 'package:qcms/widgets/custom_loginbutton.dart';
import 'package:qcms/widgets/logout_utils.dart';

class ScreenSettingsPage extends StatefulWidget {
  const ScreenSettingsPage({super.key});

  @override
  State<ScreenSettingsPage> createState() => _ScreenSettingsPageState();
}

class _ScreenSettingsPageState extends State<ScreenSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        child: Center(
          child: Column(
            children: [
              Customloginbutton(
                onPressed: () async {
                  await AuthUtils.handleLogout(context);
                },
                text: 'logout',
              ),
              ResponsiveSizedBox.height20,
              Customloginbutton(
                onPressed: () async {
                  await AuthUtils.handleLogout(context, resetOnboarding: true);
                },
                text: 'Reset',
              ),
              ResponsiveSizedBox.height10,
                     ListTile(
            title: const Text("English"),
            onTap: () {
              context.read<LanguageCubit>().changeLanguage(context, const Locale('en'));
            },
          ),
          ListTile(
            title: const Text("हिन्दी"),
            onTap: () {
              context.read<LanguageCubit>().changeLanguage(context, const Locale('hi'));
            },
          ),
          ListTile(
            title: const Text("ಕನ್ನಡ"),
            onTap: () {
              context.read<LanguageCubit>().changeLanguage(context, const Locale('kn'));
            },
          ),
            ],
          
          ),
        ),
      ),
    );
  }
}
