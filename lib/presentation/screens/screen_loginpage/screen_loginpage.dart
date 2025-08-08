import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcms/core/appconstants.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/core/responsiveutils.dart';
import 'package:qcms/presentation/blocs/send_otp_bloc/send_otp_bloc.dart';
import 'package:qcms/widgets/custom_login_loadingbutton.dart';
import 'package:qcms/widgets/custom_loginbutton.dart';
import 'package:qcms/widgets/custom_routes.dart';
import 'package:qcms/widgets/custom_snackbar.dart';
import 'package:qcms/widgets/custom_textfield.dart';

class ScreenLoginpage extends StatefulWidget {
  const ScreenLoginpage({super.key});

  @override
  QCMSLoginScreenState createState() => QCMSLoginScreenState();
}

class QCMSLoginScreenState extends State<ScreenLoginpage> {
  final TextEditingController _mobileController = TextEditingController();
  final FocusNode _mobileFocusNode = FocusNode();
  final fromKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _mobileController.dispose();
    _mobileFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 240, 235),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: fromKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ResponsiveSizedBox.height50,
              ResponsiveSizedBox.height(8),
              // QCMS Logo
              SizedBox(
                height: ResponsiveUtils.hp(8),
                width: double.infinity,
                child: Image.asset(
                  Appconstants.appLogo,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback widget if image not found
                    return Container(
                      height: ResponsiveUtils.hp(8),
                      width: ResponsiveUtils.wp(8),

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 151, 149, 149),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.image,
                        size: 30,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                ),
              ),

              ResponsiveSizedBox.height20,
              TextStyles.subheadline(text: 'Welcome to QCMS'),

              ResponsiveSizedBox.height(5),

              // Mobile Number Input
              Align(
                alignment: Alignment.centerLeft,
                child: TextStyles.body(text: 'Mobile Number*'),
              ),

              ResponsiveSizedBox.height10,
              CustomTextField(
                controller: _mobileController,
                focusNode: _mobileFocusNode,
                hintText: 'Please enter your Mobile Number',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mobile number is required';
                  } else if (value.length != 10) {
                    return 'Enter a valid 10-digit number';
                  }
                  return null;
                },
              ),

              ResponsiveSizedBox.height30,

              BlocConsumer<SendOtpBloc, SendOtpState>(
                listener: (context, state) {
                  if (state is SendOtpSuccess) {
                      CustomSnackbar.show(
                                  context,
                                  message: "OTP has been sent on your Mobile Number ${_mobileController.text}.",
                                  type: SnackbarType.success,
                                );
                    CustomNavigation.pushReplacementNamedWithTransition(
                      context,
                      AppRouter.verifyOTP,
                      arguments: {
                        'mobileNumber': _mobileController.text,
                        'flatId': state.flatId,
                      },
                    );
                  } else if (state is SendOtpFailure) {
                    CustomSnackbar.show(
                      context,
                      message: state.error,
                      type: SnackbarType.error,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SendOtpLoadingState) {
                    return Customloginloadingbutton();
                  }
                  return Customloginbutton(
                    onPressed: () {
                      if (fromKey.currentState!.validate()) {
                        context.read<SendOtpBloc>().add(
                          SendOtpButtonClickEvent(
                            mobileNumber: _mobileController.text,
                          ),
                        );
                      }
                      else{
                          CustomSnackbar.show(
    context,
    message: 'Please fill all required fields',
    type: SnackbarType.error,
  );
                      }
                    },
                    text: 'Login',
                  );
                },
              ),
              ResponsiveSizedBox.height10,
              Divider(),
              ResponsiveSizedBox.height20,

              // Feature Cards
              _buildFeatureCard(
                icon: Icons.home_work_rounded,
                title: 'Register Your Flat',
                description:
                    'If your flat is missing in the quarters, please register your flat details here.',
                onTap: () {
                  CustomNavigation.pushNamedWithTransition(
                    context,
                    AppRouter.register,
                  );
                },
              ),

              _buildFeatureCard(
                icon: Icons.business_center_rounded,
                title: 'Enroll Your Division',
                description:
                    'If you wish to have your division enrolled in the system, please submit your details here.',
                onTap: () {
                  CustomNavigation.pushNamedWithTransition(
                    context,
                    AppRouter.requestform,
                  );
                },
              ),

              ResponsiveSizedBox.height10,

              // Footer with better styling
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.6),
                      Colors.white.withOpacity(0.4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.privacy_tip_outlined,
                        size: 16,
                        color: Appcolors.kprimarycolor,
                      ),
                      label: TextStyles.body(
                        text: 'Privacy Policy',
                        color: Appcolors.kprimarycolor,
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 1,
                      color: Appcolors.kprimarycolor.withOpacity(.4),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Appcolors.kprimarycolor,
                      ),
                      label: TextStyles.body(
                        text: 'Disclaimer',
                        color: Appcolors.kprimarycolor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white.withAlpha(277), Colors.white.withAlpha(244)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Appcolors.kbordercolor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Appcolors.kbordercolor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icon,
                        color: Appcolors.kbordercolor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextStyles.body(
                        text: title,
                        weight: FontWeight.w600,
                        color: Appcolors.kprimarycolor,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Appcolors.kblackcolor,
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Appcolors.kblackcolor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
