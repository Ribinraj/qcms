import 'package:flutter/material.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/widgets/custom_loginbutton.dart';
import 'package:qcms/widgets/custom_routes.dart';
import 'package:qcms/widgets/custom_textfield.dart';

class ScreenRequestformPage extends StatefulWidget {
  const ScreenRequestformPage({super.key});

  @override
  State<ScreenRequestformPage> createState() => _ScreenRequestformPageState();
}

class _ScreenRequestformPageState extends State<ScreenRequestformPage> {
  final TextEditingController divisionnameController = TextEditingController();
  final TextEditingController quartersnameController = TextEditingController();
  final TextEditingController occupantnameController = TextEditingController();
  final TextEditingController occupantmobilenumberController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kbackgroundcolor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            CustomNavigation.pop(context);
          },
          icon: Icon(Icons.chevron_left, size: 30),
        ),
        title: TextStyles.subheadline(text: 'Request Form'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextStyles.headline(text: 'Register your flat'),
            ResponsiveSizedBox.height15,
            TextStyles.body(
              text:
                  'If you wish to have your division enrolled in the system. please submit your details here.',
            ),
            ResponsiveSizedBox.height20,
            TextStyles.body(text: 'Division Name*'),
            ResponsiveSizedBox.height5,
            CustomTextField(
              controller: divisionnameController,
              hintText: 'Enter your Division Name',
            ),
            ResponsiveSizedBox.height15,
            TextStyles.body(text: 'Quaters Name*'),
            ResponsiveSizedBox.height5,
            CustomTextField(
              controller: quartersnameController,
              hintText: 'Enter your Quarters Name',
            ),
            ResponsiveSizedBox.height15,
            TextStyles.body(text: 'Occupant Name*'),
            ResponsiveSizedBox.height5,
            CustomTextField(
              controller: occupantnameController,
              hintText: 'Enter your Full Name',
            ),
            ResponsiveSizedBox.height15,
            TextStyles.body(text: 'Occupant Mobilenumber*'),
            ResponsiveSizedBox.height5,
            CustomTextField(
              controller: occupantmobilenumberController,
              hintText: 'Enter your Mobilenumber',
            ),
            ResponsiveSizedBox.height30,
            Customloginbutton(onPressed: () {}, text: 'Submit Now'),
          ],
        ),
      ),
    );
  }
}
