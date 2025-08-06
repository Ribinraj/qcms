import 'package:flutter/material.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/widgets/custom_dropdown.dart';
import 'package:qcms/widgets/custom_loginbutton.dart';
import 'package:qcms/widgets/custom_routes.dart';
import 'package:qcms/widgets/custom_textfield.dart';

class ScreenRegisterpage extends StatefulWidget {
  const ScreenRegisterpage({super.key});

  @override
  State<ScreenRegisterpage> createState() => _ScreenRegisterpageState();
}

class _ScreenRegisterpageState extends State<ScreenRegisterpage> {
  final TextEditingController flatnumberController = TextEditingController();
  final TextEditingController occupantnameController = TextEditingController();
  final TextEditingController occupantmobilenumberController =
      TextEditingController();
  final TextEditingController occupantDesignationController =
      TextEditingController();
  String? selectedDivision;
  String? selectedQuarters;
  String? selectedQuartersType;
  String? selectedQuartersRoofType;
  String? selectedQuartersStatus;
  final List<String> division = ['mysore', 'mumbai', 'delhi'];
  final List<String> quarters = ['A', 'B', 'c'];
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
        title: TextStyles.subheadline(text: 'Register Now'),
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
                  'If your division and quarters ate listed.but your flat is missing, please register your flat here',
            ),
            ResponsiveSizedBox.height20,
            TextStyles.body(text: 'Division*'),
            ResponsiveSizedBox.height5,
            CustomDropdown(
              value: selectedDivision,
              hintText: 'Please select Division',
              items: division,
              onChanged: (value) {
                setState(() {
                  selectedDivision = value;
                });
                print('Selected property type: $value');
              },
            ),
            ResponsiveSizedBox.height15,
            TextStyles.body(text: 'Quarters*'),
            ResponsiveSizedBox.height5,

            CustomDropdown(
              value: selectedQuarters,
              hintText: 'Please select Quarters',
              items: quarters,
              onChanged: (value) {
                setState(() {
                  selectedQuarters = value;
                });
                print('Selected quarters: $value');
              },
            ),
            ResponsiveSizedBox.height15,
            TextStyles.body(text: 'Your Flat Number'),
            ResponsiveSizedBox.height5,
            CustomTextField(
              controller: flatnumberController,
              hintText: 'Enter Your Flat No',
            ),
            ResponsiveSizedBox.height15,
            TextStyles.body(text: 'Quarters Type*'),
            ResponsiveSizedBox.height5,

            CustomDropdown(
              value: selectedQuartersType,
              hintText: 'Please select Quarters Type',
              items: quarters,
              onChanged: (value) {
                setState(() {
                  selectedQuartersType = value;
                });
                print('Selected quartersType: $value');
              },
            ),
            ResponsiveSizedBox.height15,
            TextStyles.body(text: 'Quarters Roof Type*'),
            ResponsiveSizedBox.height5,

            CustomDropdown(
              value: selectedQuartersType,
              hintText: 'Please select Quarters Roof Type',
              items: quarters,
              onChanged: (value) {
                setState(() {
                  selectedQuartersRoofType = value;
                });
                print('Selected quartersRoofType: $value');
              },
            ),
            ResponsiveSizedBox.height15,
            TextStyles.body(text: 'Quarters Status*'),
            ResponsiveSizedBox.height5,

            CustomDropdown(
              value: selectedQuartersStatus,
              hintText: 'Please select Quarters Status',
              items: quarters,
              onChanged: (value) {
                setState(() {
                  selectedQuartersStatus = value;
                });
                print('Selected quartersStatus: $value');
              },
            ),
            ResponsiveSizedBox.height15,

            TextStyles.body(text: 'Occupant Name*'),
            ResponsiveSizedBox.height5,
            CustomTextField(
              controller: occupantnameController,
              hintText: 'Enter your full name',
            ),
            ResponsiveSizedBox.height15,
            TextStyles.body(text: 'Occupant Mobilenumber*'),
            ResponsiveSizedBox.height5,
            CustomTextField(
              controller: occupantmobilenumberController,
              hintText: 'Enter Your MobileNumber',
            ),

            ResponsiveSizedBox.height15,
            TextStyles.body(text: 'Occupant Designation'),
            ResponsiveSizedBox.height5,
            CustomTextField(
              controller: occupantDesignationController,
              hintText: 'Enter Your Designation',
            ),
            ResponsiveSizedBox.height30,
            Customloginbutton(onPressed: () {}, text: 'Register'),
          ],
        ),
      ),
    );
  }
}
