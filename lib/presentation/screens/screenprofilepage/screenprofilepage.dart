import 'package:flutter/material.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/core/responsiveutils.dart';
import 'package:qcms/widgets/custom_appbar.dart';

class Screenprofilepage extends StatefulWidget {
  const Screenprofilepage({super.key});

  @override
  State<Screenprofilepage> createState() => _ScreenComplaintdetailsPageState();
}

class _ScreenComplaintdetailsPageState extends State<Screenprofilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Profile'),
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
            Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  _buildDetailRow('Flat#', '13097'),
                  _buildDivider(),
                  _buildDetailRow('Flat Type', 'Type_1'),
                  _buildDivider(),
                  _buildDetailRow('Roof Type', 'RCC'),
                  _buildDivider(),
                  _buildDetailRow('Flat Status', 'OCCUPIED'),
                  _buildDivider(),
                  _buildDetailRow('Occupant Name', 'ANAND JAIN'),
                  _buildDivider(),
                  _buildDetailRow('Occupant Mobile', '99344595555'),
                  _buildDivider(),
                  _buildDetailRow('Quarters Status', 'GOOD'),

                  _buildDivider(),
                  _buildDetailRow('Last Updated', '04-07-2025 4:40AM'),
                  _buildDivider(),
                ],
              ),
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
