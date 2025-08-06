import 'package:flutter/material.dart';

class ScreenSettingsPage extends StatefulWidget {
  const ScreenSettingsPage({super.key});

  @override
  State<ScreenSettingsPage> createState() => _ScreenSettingsPageState();
}

class _ScreenSettingsPageState extends State<ScreenSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('settings')));
  }
}
