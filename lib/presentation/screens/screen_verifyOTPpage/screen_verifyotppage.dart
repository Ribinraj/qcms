import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qcms/core/appconstants.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/core/responsiveutils.dart';
import 'package:qcms/widgets/custom_routes.dart';

class ScreenVerifyOtp extends StatefulWidget {
  final String customerId;

  final String mobileNumber;
  const ScreenVerifyOtp({
    Key? key,
    required this.customerId,

    required this.mobileNumber,
  }) : super(key: key);

  @override
  State<ScreenVerifyOtp> createState() => _ScreenVerifyOtpState();
}

class _ScreenVerifyOtpState extends State<ScreenVerifyOtp> {
  final TextEditingController _otpController = TextEditingController();
  bool _isButtonEnabled = false;
  String _currentOtp = '';
  int _resendTimer = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    // Cancel timer first
    _timer?.cancel();
    _timer = null;

    // Safe disposal of controller
    try {
      _otpController.dispose();
    } catch (e) {
      // Controller already disposed, ignore
    }

    super.dispose();
  }

  void _startResendTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _resetResendTimer() {
    if (!mounted) return;
    setState(() {
      _resendTimer = 30;
    });
    _startResendTimer();
  }

  void _resendOtp() {
    if (!mounted) return;

    // Clear OTP field safely
    if (_otpController.hasListeners) {
      _otpController.clear();
    }

    setState(() {
      _currentOtp = '';
      _isButtonEnabled = false;
    });

    // Reset and restart the timer
    _resetResendTimer();

    // Call resend OTP API
    // context
    //     .read<ResendOtpBloc>()
    //     .add(ResendOtpClickEvent(customerId: widget.customerId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section with logo and tagline
            Container(
              padding: const EdgeInsets.all(20),
              height: ResponsiveUtils.hp(50),
              width: ResponsiveUtils.screenWidth,
              decoration: const BoxDecoration(
                color: Appcolors.kblackcolor,
                image: DecorationImage(
                  image: AssetImage('assets/images/full_logo.png'),
                  // Your logo asset
                  fit: BoxFit.none,
                  scale: 1.8,
                  alignment: Alignment.center,
                ),
              ),
            ),

            // Bottom section with OTP verification
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyles.headline(text: 'Verification Code'),
                  ResponsiveSizedBox.height10,
                  TextStyles.body(
                    text:
                        'We have sent a verification code to ${widget.mobileNumber}',
                    weight: FontWeight.w600,
                  ),
                  ResponsiveSizedBox.height20,

                  // PIN Code TextField
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: _otpController,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      inactiveBorderWidth: 1,
                      activeBorderWidth: 1,
                      selectedBorderWidth: 1,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 50,
                      fieldWidth: 48,
                      activeFillColor: Appcolors.kwhitecolor,
                      inactiveFillColor: Appcolors.kwhitecolor,
                      selectedFillColor: Appcolors.kwhitecolor,
                      activeColor: Appcolors.kprimarycolor,
                      inactiveColor: Appcolors.kprimarycolor,
                      selectedColor: Appcolors.kprimarycolor,
                      errorBorderColor: Colors.red,
                    ),
                    cursorColor: Appcolors.kprimarycolor,
                    cursorWidth: 1,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onCompleted: (value) {
                      if (!mounted) return;
                      setState(() {
                        _isButtonEnabled = true;
                        _currentOtp = value;
                      });
                    },
                    onChanged: (value) {
                      if (!mounted) return;
                      setState(() {
                        _currentOtp = value;
                        _isButtonEnabled = value.length == 6;
                      });
                    },
                  ),

                  const SizedBox(height: 40),

                  // Verify Button with BLoC
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled
                          ? () async {
                              // SharedPreferences prefs =
                              //     await SharedPreferences.getInstance();
                              // String? token = prefs.getString('FCM_TOKEN');

                              if (_currentOtp.length == 6) {
                                // context.read<VerifyOtpBloc>().add(
                                //     VerifyOtpButtonClickEvent(
                                //         user: VerifyOtpmodel(
                                //             customerId: widget.customerId,
                                //             customerOTP: _currentOtp,
                                //             pushToken: token ?? '')));
                                CustomNavigation.pushNamedWithTransition(
                                  context,
                                  AppRouter.mainpage,
                                );
                              } else {
                                // showTopSnackBar(
                                //   Overlay.of(context),
                                //   const CustomSnackBar.error(
                                //     message: 'Please enter valid OTP',
                                //   ),
                                // );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isButtonEnabled
                            ? Appcolors.kprimarycolor
                            : Colors.grey.shade400,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // _buildVerifyButton(),
                  const SizedBox(height: 24),

                  // Timer and Resend Section
                  //_buildTimerOrResend(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildVerifyButton() {
  //   return BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
  //     listener: (context, state) {
  //       if (state is VerifyOtpSuccessState) {
  //         if (widget.loginedfrom == 'Cartpage') {
  //             navigateToCartPageAfterLogin(context);
  //         } else {
  //           navigateToMainPage(context, 3);
  //         }
  //       } else if (state is VerifyOtpErrorState) {
  //         showTopSnackBar(
  //           Overlay.of(context),
  //           CustomSnackBar.error(
  //             message: state.message,
  //           ),
  //         );
  //       }
  //     },
  //     builder: (context, state) {
  //       if (state is VerifyOtpLoadingState) {
  //         return Container(
  //           width: double.infinity,
  //           height: 50,
  //           decoration: BoxDecoration(
  //             color: Appcolors.kprimarycolor,
  //             borderRadius: BorderRadius.circular(30),
  //           ),
  //           child: const Center(
  //             child: SpinKitWave(
  //               size: 18,
  //               color: Appcolors.kwhiteColor,
  //             ),
  //           ),
  //         );
  //       }

  //       return SizedBox(
  //         width: double.infinity,
  //         height: 50,
  //         child: ElevatedButton(
  //           onPressed: _isButtonEnabled
  //               ? () async {
  //                   // SharedPreferences prefs =
  //                   //     await SharedPreferences.getInstance();
  //                   // String? token = prefs.getString('FCM_TOKEN');

  //                   if (_currentOtp.length == 6) {
  //                     // context.read<VerifyOtpBloc>().add(
  //                     //     VerifyOtpButtonClickEvent(
  //                     //         user: VerifyOtpmodel(
  //                     //             customerId: widget.customerId,
  //                     //             customerOTP: _currentOtp,
  //                     //             pushToken: token ?? '')));
  //                   } else {
  //                     // showTopSnackBar(
  //                     //   Overlay.of(context),
  //                     //   const CustomSnackBar.error(
  //                     //     message: 'Please enter valid OTP',
  //                     //   ),
  //                     // );
  //                   }
  //                 }
  //               : null,
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: _isButtonEnabled
  //                 ? Appcolors.kprimarycolor
  //                 : Colors.grey.shade400,
  //             foregroundColor: Colors.white,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(30),
  //             ),
  //           ),
  //           child: const Text(
  //             'Verify',
  //             style: TextStyle(
  //               fontSize: 15,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _buildTimerOrResend() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       TextStyles.medium(
  //           text: "Didn't receive the code? ", weight: FontWeight.bold),
  //       BlocConsumer<ResendOtpBloc, ResendOtpState>(
  //         listener: (context, state) {
  //           if (state is ResendOtpSuccessState) {
  //             showTopSnackBar(
  //               Overlay.of(context),
  //               const CustomSnackBar.success(
  //                 message: 'OTP sent successfully',
  //               ),
  //             );
  //           } else if (state is ResendOtpErrorState) {
  //             showTopSnackBar(
  //               Overlay.of(context),
  //               CustomSnackBar.error(
  //                 message: state.message,
  //               ),
  //             );
  //           }
  //         },
  //         builder: (context, state) {
  //           return TextButton(
  //             onPressed: _resendTimer == 0 ? () => _resendOtp() : null,
  //             child: TextStyles.body(
  //               text: _resendTimer > 0
  //                   ? 'Resend in $_resendTimer seconds'
  //                   : 'Resend',
  //               weight: FontWeight.w600,
  //               color: _resendTimer > 0
  //                   ? Colors.grey.shade500
  //                   : Appcolors.kredcolor,
  //             ),
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }
}
