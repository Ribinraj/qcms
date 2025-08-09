import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/core/responsiveutils.dart';
import 'package:qcms/data/register_newquarters.dart';

import 'package:qcms/presentation/blocs/fetch_division_bloc/fetch_division_bloc.dart';
import 'package:qcms/presentation/blocs/fetch_quarters_bloc/fetch_quarters_bloc.dart';
import 'package:qcms/presentation/blocs/register_quarters_bloc/register_quarters_bloc.dart';

import 'package:qcms/widgets/custom_dropdown.dart';
import 'package:qcms/widgets/custom_login_loadingbutton.dart';
import 'package:qcms/widgets/custom_loginbutton.dart';
import 'package:qcms/widgets/custom_routes.dart';
import 'package:qcms/widgets/custom_searchdropdown.dart';
import 'package:qcms/widgets/custom_snackbar.dart';
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

  // Changed to DropdownItem to handle both ID and display
  DropdownItem? selectedDivision;
  DropdownItem? selectedQuarters;

  String? selectedQuartersType;
  String? selectedQuartersRoofType;
  String? selectedQuartersStatus;

  final List<String> quartersTypeList = [
    'TYPE-I',
    'TYPE-II',
    'TYPE-III',
    'TYPE-IV',
    'TYPE-V',
  ];
  final List<String> quartersRoofTypeList = ['RCC', 'TILES'];
  final List<String> quartersStatusList = ['OCCUPIED', 'VACANT'];

  @override
  void initState() {
    super.initState();
    context.read<FetchDivisionBloc>().add(FetchDivisionInitialEvent());
  }

  // Method to handle division change and clear quarters
  void _onDivisionChanged(DropdownItem? value) {
    setState(() {
      // If division changes, clear the quarters selection
      if (selectedDivision?.id != value?.id) {
        selectedQuarters = null;
      }
      selectedDivision = value;
    });

    if (value != null) {
      print('Selected Division ID: ${value.id}');
      print('Selected Division Name: ${value.display}');
      // Fetch quarters for the selected division
      context.read<FetchQuartersBloc>().add(
        FetchQuartersInitialFEtchingEvent(divisionId: value.id),
      );
    }
  }

  // Widget for disabled quarters dropdown
  Widget _buildDisabledQuartersDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Please select division first',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

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
                  'If your division and quarters are listed but your flat is missing, please register your flat here',
            ),
            ResponsiveSizedBox.height20,

            // Division Selection
            TextStyles.body(text: 'Division*'),
            ResponsiveSizedBox.height5,
            BlocBuilder<FetchDivisionBloc, FetchDivisionState>(
              builder: (context, state) {
                if (state is FetchDivisionLoadingState) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E4F3),
                      border: Border(
                        bottom: BorderSide(
                          color: Appcolors.kprimarycolor,
                          width: 1.5,
                        ),
                      ),
                    ),
                    width: ResponsiveUtils.screenWidth,
                    padding: EdgeInsets.all(15),
                    child: SpinKitWave(
                      size: 15,
                      color: Appcolors.ksecondarycolor,
                    ),
                  );
                } else if (state is FetchdivisionErrorState) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      border: Border.all(color: Colors.red.shade200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red.shade600),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            state.message,
                            style: TextStyle(color: Colors.red.shade700),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is FetchDivisonSuccessState) {
                  final divisionItems = state.divisions
                      .map(
                        (division) => DropdownItem(
                          id: division.cityId,
                          display: division.cityName,
                        ),
                      )
                      .toList();

                  return CustomSearchDropdown(
                    value: selectedDivision,
                    hintText: 'Please select division',
                    items: divisionItems,
                    enableSearch: true,
                    searchHintText: 'Search divisions...',
                    onChanged: _onDivisionChanged,
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),

            ResponsiveSizedBox.height15,

            // Quarters Selection
            TextStyles.body(text: 'Quarters*'),
            ResponsiveSizedBox.height5,

            // Show quarters dropdown only if division is selected
            selectedDivision == null
                ? _buildDisabledQuartersDropdown()
                : BlocBuilder<FetchQuartersBloc, FetchQuartersState>(
                    builder: (context, state) {
                      if (state is FetchQuartersLoadingState) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8E4F3),
                            border: Border(
                              bottom: BorderSide(
                                color: Appcolors.kprimarycolor,
                                width: 1.5,
                              ),
                            ),
                          ),
                          width: ResponsiveUtils.screenWidth,
                          padding: EdgeInsets.all(15),
                          child: SpinKitWave(
                            size: 15,
                            color: Appcolors.ksecondarycolor,
                          ),
                        );
                      } else if (state is FetchQuartersErrorState) {
                        return Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            border: Border.all(color: Colors.red.shade200),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red.shade600,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  state.message,
                                  style: TextStyle(color: Colors.red.shade700),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (state is FetchQuartersSuccessState) {
                        final quartersItems = state.quarters
                            .map(
                              (quarters) => DropdownItem(
                                id: quarters.quarterId,
                                display: quarters.quarterName,
                              ),
                            )
                            .toList();

                        return CustomSearchDropdown(
                          value: selectedQuarters,
                          hintText: 'Please select quarters',
                          items: quartersItems,
                          enableSearch: true,
                          searchHintText: 'Search quarters...',
                          onChanged: (value) {
                            setState(() {
                              selectedQuarters = value;
                            });
                            if (value != null) {
                              print('Selected Quarters ID: ${value.id}');
                              print('Selected Quarters Name: ${value.display}');
                            }
                          },
                        );
                      } else {
                        return _buildDisabledQuartersDropdown();
                      }
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
              items: quartersTypeList,
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
              value: selectedQuartersRoofType,
              hintText: 'Please select Quarters Roof Type',
              items: quartersRoofTypeList,
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
              items: quartersStatusList,
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
            TextStyles.body(text: 'Occupant Mobile Number*'),
            ResponsiveSizedBox.height5,
            CustomTextField(
              controller: occupantmobilenumberController,
              hintText: 'Enter Your Mobile Number',
            ),

            ResponsiveSizedBox.height15,
            TextStyles.body(text: 'Occupant Designation'),
            ResponsiveSizedBox.height5,
            CustomTextField(
              controller: occupantDesignationController,
              hintText: 'Enter Your Designation',
            ),

            ResponsiveSizedBox.height30,
            BlocConsumer<RegisterQuartersBloc, RegisterQuartersState>(
              listener: (context, state) {
                if (state is RegisterQuartersSuccessState) {
                  CustomSnackbar.show(
                    context,
                    message: state.message,
                    type: SnackbarType.success,
                  );
                  CustomNavigation.pop(context);
                }
              },
              builder: (context, state) {
                if (state is RegisterQuartersLoadingState) {
                  return Customloginloadingbutton();
                }
                return Customloginbutton(
                  onPressed: () {
                    _handleRegistration();
                  },
                  text: 'Register',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleRegistration() {
    // Validation
    if (selectedDivision == null) {
      _showMessage('Please select a division');
      return;
    }

    if (selectedQuarters == null) {
      _showMessage('Please select quarters');
      return;
    }

    if (flatnumberController.text.trim().isEmpty) {
      _showMessage('Please enter flat number');
      return;
    }

    if (selectedQuartersType == null) {
      _showMessage('Please select quarters type');
      return;
    }

    if (selectedQuartersRoofType == null) {
      _showMessage('Please select quarters roof type');
      return;
    }

    if (selectedQuartersStatus == null) {
      _showMessage('Please select quarters status');
      return;
    }

    if (occupantnameController.text.trim().isEmpty) {
      _showMessage('Please enter occupant name');
      return;
    }

    if (occupantmobilenumberController.text.trim().isEmpty) {
      _showMessage('Please enter occupant mobile number');
      return;
    }
    String mobile = occupantmobilenumberController.text.trim();
final mobileRegex = RegExp(r'^[6-9]\d{9}$');

if (!mobileRegex.hasMatch(mobile)) {
  _showMessage('Please enter a valid 10-digit mobile number');
  return;
}
    context.read<RegisterQuartersBloc>().add(RegisterQuartersButtonClickEvent(quarters: RegisterNewquartersModel(cityId:int.parse( selectedDivision!.id), quarterId: int.parse(selectedQuarters!.id), quarterNo: flatnumberController.text, quarterType: selectedQuartersType!, quarterRoofType:selectedQuartersRoofType!, quarterStatus: selectedQuartersStatus!, occupantName: occupantnameController.text, occupantMobile: occupantmobilenumberController.text, occupantDesignation: occupantDesignationController.text)));
    // All validations passed, proceed with registration
    // print('=== REGISTRATION DATA ===');
    // print('Division ID: ${selectedDivision!.id}');
    // print('Division Name: ${selectedDivision!.display}');
    // print('Quarters ID: ${selectedQuarters!.id}');
    // print('Quarters Name: ${selectedQuarters!.display}');
    // print('Flat Number: ${flatnumberController.text.trim()}');
    // print('Quarters Type: $selectedQuartersType');
    // print('Quarters Roof Type: $selectedQuartersRoofType');
    // print('Quarters Status: $selectedQuartersStatus');
    // print('Occupant Name: ${occupantnameController.text.trim()}');
    // print('Occupant Mobile: ${occupantmobilenumberController.text.trim()}');
    // print('Occupant Designation: ${occupantDesignationController.text.trim()}');
    // print('========================');

    // Add your actual registration API call here
   
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
    );
  }

  @override
  void dispose() {
    flatnumberController.dispose();
    occupantnameController.dispose();
    occupantmobilenumberController.dispose();
    occupantDesignationController.dispose();
    super.dispose();
  }
}
