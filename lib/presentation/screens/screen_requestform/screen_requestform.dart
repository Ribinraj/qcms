import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/data/register_newdivision.dart';
import 'package:qcms/presentation/blocs/register_new_division/register_newdivision_bloc.dart';
import 'package:qcms/widgets/custom_login_loadingbutton.dart';
import 'package:qcms/widgets/custom_loginbutton.dart';
import 'package:qcms/widgets/custom_routes.dart';
import 'package:qcms/widgets/custom_snackbar.dart';
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
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kbackgroundcolor,
      appBar: AppBar(
        surfaceTintColor: Appcolors.kwhitecolor,
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
        child: Form(
          key: formkey,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter division name';
                  }
                  return null;
                },
              ),
              ResponsiveSizedBox.height15,
              TextStyles.body(text: 'Quaters Name*'),
              ResponsiveSizedBox.height5,
              CustomTextField(
                controller: quartersnameController,
                hintText: 'Enter your Quarters Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter quarters name';
                  }
                  return null;
                },
              ),
              ResponsiveSizedBox.height15,
              TextStyles.body(text: 'Occupant Name*'),
              ResponsiveSizedBox.height5,
              CustomTextField(
                controller: occupantnameController,
                hintText: 'Enter your Full Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your name';
                  }
                  return null;
                },
              ),
              ResponsiveSizedBox.height15,
              TextStyles.body(text: 'Occupant Mobilenumber*'),
              ResponsiveSizedBox.height5,
              CustomTextField(
                controller: occupantmobilenumberController,
                hintText: 'Enter your Mobilenumber',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mobile number';
                  }
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Enter valid 10-digit mobile number';
                  }
                  return null;
                },
              ),
              ResponsiveSizedBox.height30,
              BlocConsumer<RegisterNewdivisionBloc, RegisterNewdivisionState>(
                listener: (context, state) {
                  if (state is RegisterNewdivisionSuccessState) {
                    CustomSnackbar.show(
                      context,
                      message: state.message,
                      type: SnackbarType.success,
                    );
                    CustomNavigation.pop(context);
                  } else if (state is RegisterNewdivisionErrorState) {
                    CustomSnackbar.show(
                      context,
                      message: state.message,
                      type: SnackbarType.error,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RegisterNewdivisionLoadingState) {
                    return Customloginloadingbutton();
                  }
                  return Customloginbutton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (formkey.currentState!.validate()) {
                        context.read<RegisterNewdivisionBloc>().add(
                          RegisterNewdvisionButtonClickEvent(
                            divsion: RegisterNewdivisionModel(
                              divisionName: divisionnameController.text,
                              quartersName: quartersnameController.text,
                              occupantName: occupantnameController.text,
                              occupantMobile:
                                  occupantmobilenumberController.text,
                            ),
                          ),
                        );
                      } else {
                        CustomSnackbar.show(
                          context,
                          message: 'Fill all required fields',
                          type: SnackbarType.error,
                        );
                      }
                    },
                    text: 'Submit Now',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
