import 'package:flutter/material.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/widgets/custom_appbar.dart';
import 'package:qcms/widgets/custom_routes.dart';

class ScreenComplaintdetailsPage extends StatefulWidget {
  const ScreenComplaintdetailsPage({super.key});

  @override
  State<ScreenComplaintdetailsPage> createState() =>
      _ScreenComplaintdetailsPageState();
}

class _ScreenComplaintdetailsPageState
    extends State<ScreenComplaintdetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Complaint Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Complaint Number
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextStyles.subheadline(text: 'Complaint #10275'),
            ),

            // Details Card
            Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  _buildDetailRow('Department', 'Engineering'),
                  _buildDivider(),
                  _buildDetailRow('Category', 'UGD Blockage'),
                  _buildDivider(),
                  _buildDetailRow('Division', 'Solapur'),
                  _buildDivider(),
                  _buildDetailRow('Quarters', 'CST/TEST'),
                  _buildDivider(),
                  _buildDetailRow('Flat#', 'CST - Flat 001'),
                  _buildDivider(),
                  _buildDetailRow('Remarks', '', showEmpty: true),
                  _buildDivider(),
                  _buildDetailRow('Complaint Date', '12-02-2025 09:45 PM'),
                  _buildDivider(),
                  _buildDetailRow(
                    'Status',
                    'WIP',
                    valueWidget: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 252, 239, 235),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: const Color.fromARGB(255, 249, 146, 146),
                        ),
                      ),
                      child: const Text(
                        'WIP',
                        style: TextStyle(
                          color: Color.fromARGB(255, 17, 123, 51),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  _buildDivider(),
                  _buildDetailRow('Artisan Name', 'B SRINIVASA MURTHY HUP'),
                  _buildDivider(),
                  _buildDetailRow('Artisan Mobile', '9177783302'),
                  _buildDivider(),
                  _buildDetailRow('Verify OTP', '2114'),
                ],
              ),
            ),
            ResponsiveSizedBox.height30,
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    CustomNavigation.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE67E22),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Go Back',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                ResponsiveSizedBox.width30,
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _showCancelDialog(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cancel_outlined, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Cancel Complaint',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Complaint'),
          content: const Text(
            'Are you sure you want to cancel this complaint?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle complaint cancellation
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Complaint cancelled successfully'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text('Yes', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
