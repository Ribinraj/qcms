import 'package:flutter/material.dart';

class ScreenMainpage extends StatefulWidget {
  const ScreenMainpage({super.key});

  @override
  State<ScreenMainpage> createState() => _ScreenMainpageState();
}

class _ScreenMainpageState extends State<ScreenMainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Screen main page'),),
    );
  }
}
