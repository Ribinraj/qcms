import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:qcms/core/colors.dart';

import 'package:qcms/core/responsiveutils.dart';
import 'package:qcms/presentation/blocs/fetch_profile_bloc/fetch_profile_bloc.dart';

import 'package:qcms/widgets/custom_appbar.dart';

class Screenprofilepage extends StatefulWidget {
  const Screenprofilepage({super.key});

  @override
  State<Screenprofilepage> createState() => _ScreenComplaintdetailsPageState();
}

class _ScreenComplaintdetailsPageState extends State<Screenprofilepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchProfileBloc>().add(FetchProfileInitialEvent());
  }

  String _formatDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return 'N/A';
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
    final DateFormat timeFormat = DateFormat('hh:mm a');
    return '${dateFormat.format(dateTime)} at ${timeFormat.format(dateTime)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "profile title".tr()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // // Complaint Number
            // TextStyles.headline(text: 'Profile'),
            Container(
              padding: const EdgeInsets.all(20),
              height: ResponsiveUtils.wp(50),
              width: ResponsiveUtils.wp(50),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/full_logo.png'),
                  // Your logo asset
                  fit: BoxFit.none,
                  scale: 3,
                  alignment: Alignment.center,
                ),
              ),
            ),

            // Details Card
            BlocBuilder<FetchProfileBloc, FetchProfileState>(
              builder: (context, state) {
                if (state is FetchProfileLoadingState) {
                  return Container(
                    height: ResponsiveUtils.hp(45),
                    color: Appcolors.kwhitecolor,
                    child: Center(
                      child: SpinKitCircle(
                        size: 45,
                        color: Appcolors.ksecondarycolor,
                      ),
                    ),
                  );
                } else if (state is FetchProfileErrorState) {
                  return Center(child: Text(state.message));
                } else if (state is FetchProfileSuccessState) {
                  final user = state.user;
                  return Container(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Column(
                      children: [
                        _buildDetailRow('Flat#', user.flatId),
                        _buildDivider(),
                        _buildDetailRow('Flat Type', user.quarterType),
                        _buildDivider(),
                        _buildDetailRow('Roof Type', user.quarterRoofType),
                        _buildDivider(),
                        _buildDetailRow('Flat Status', user.quarterStatus),
                        _buildDivider(),
                        _buildDetailRow('Occupant Name', user.occupantName),
                        _buildDivider(),
                        _buildDetailRow('Occupant Mobile', user.occupantMobile),
                        _buildDivider(),
                        _buildDetailRow('Quarters Status', user.quartersStatus),

                        _buildDivider(),
                        _buildDetailRow('Last Updated', _formatDateTime(user.lastModified)),
                        _buildDivider(),
                      ],
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            // ResponsiveSizedBox.height30,
            // Align(
            //   alignment: Alignment.center,
            //   child: SizedBox(
            //     width: ResponsiveUtils.wp(70),
            //     child: ElevatedButton(
            //       onPressed: () {},
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: const Color(0xFFE67E22),
            //         foregroundColor: Colors.white,
            //         padding: const EdgeInsets.symmetric(
            //           vertical: 11,
            //           horizontal: 14,
            //         ),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //       ),
            //       child: const Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Icon(Icons.arrow_back, size: 20),
            //           SizedBox(width: 8),
            //           Text(
            //             'Go Back',
            //             style: TextStyle(
            //               fontSize: 13,
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Widget? valueWidget,
    bool showEmpty = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child:
                valueWidget ??
                Text(
                  showEmpty && value.isEmpty ? '' : value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: .5, color: Appcolors.ksecondarycolor);
  }
}
