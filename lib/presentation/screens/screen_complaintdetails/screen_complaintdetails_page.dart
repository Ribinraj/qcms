import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/core/responsiveutils.dart';
import 'package:qcms/data/complaint_listmodel.dart';
import 'package:qcms/presentation/blocs/cancel_complaint_bloc/cancel_complaint_bloc.dart';
import 'package:qcms/presentation/blocs/fetch_complaintlists_bloc/fetch_complaintlists_bloc.dart';
import 'package:qcms/widgets/custom_appbar.dart';
import 'package:qcms/widgets/custom_routes.dart';
import 'package:qcms/widgets/custom_snackbar.dart';

class ScreenComplaintdetailsPage extends StatefulWidget {
  final ComplaintListmodel complaintdetails;
  const ScreenComplaintdetailsPage({super.key, required this.complaintdetails});

  @override
  State<ScreenComplaintdetailsPage> createState() =>
      _ScreenComplaintdetailsPageState();
}

class _ScreenComplaintdetailsPageState
    extends State<ScreenComplaintdetailsPage> {
  String _formatDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return 'N/A';
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
    final DateFormat timeFormat = DateFormat('hh:mm a');
    return '${dateFormat.format(dateTime)} at ${timeFormat.format(dateTime)}';
  }

  @override
  Widget build(BuildContext context) {
   // final complaint = widget.complaintdetails;
    return BlocBuilder<FetchComplaintlistsBloc, FetchComplaintlistsState>(
      builder: (context, state) {
             ComplaintListmodel complaint = widget.complaintdetails;
        
        if (state is FetchComplaintlistSuccessState) {
          final updatedComplaint = state.complaints
              .firstWhere(
                (c) => c.complaintId == widget.complaintdetails.complaintId,
                orElse: () => widget.complaintdetails,
              );
          complaint = updatedComplaint;
        }

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
                  child: TextStyles.subheadline(
                    text: 'Complaint #${complaint.complaintId}',
                  ),
                ),

                // Details Card
                Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    children: [
                      _buildDetailRow('Department', complaint.departmentId),
                      _buildDivider(),
                      _buildDetailRow('Category', complaint.categoryId),
                      _buildDivider(),
                      _buildDetailRow('Division', complaint.cityId),
                      _buildDivider(),
                      _buildDetailRow('Quarters', complaint.quarterId),
                      _buildDivider(),
                      _buildDetailRow('Flat#', complaint.flatId),
                      _buildDivider(),
                      _buildDetailRow(
                        'Remarks',
                        complaint.remark,
                        showEmpty: true,
                      ),
                      _buildDivider(),
                      _buildDetailRow(
                        'Complaint Date',
                        _formatDateTime(complaint.complaintDate),
                      ),
                      _buildDivider(),
                      _buildDetailRow(
                        'Status',
                        complaint.complaintStatus,
                        valueWidget: Text(
                          complaint.complaintStatus,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Appcolors.ksecondarycolor,
                            fontWeight: FontWeight.bold,

                            fontSize: 14,
                          ),
                        ),
                      ),
                      complaint.complaintStatus != "CANCELLED"
                          ? Column(
                              children: [
                                _buildDivider(),
                                _buildDetailRow(
                                  'Artisan Name',
                                  complaint.workerName,
                                ),
                                _buildDivider(),
                                _buildDetailRow(
                                  'Artisan Mobile',
                                  complaint.workerMobile,
                                ),
                                _buildDivider(),
                                _buildDetailRow(
                                  'Verify OTP',
                                  complaint.complaintOTP,
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
                ResponsiveSizedBox.height30,
                complaint.complaintStatus != "CANCELLED"
                    ? Row(
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
                            child: BlocConsumer<CancelComplaintBloc, CancelComplaintState>(
                              listener: (context, state) {
                                if (state is CancelComplaintSuccessState) {
                                  CustomSnackbar.show(
                                    context,
                                    message: state.message,
                                    type: SnackbarType.success,
                                  );
                                } else if (state is CancelComplaintErrorState) {
                                  CustomSnackbar.show(
                                    context,
                                    message: state.message,
                                    type: SnackbarType.error,
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is CancelComplaintLoadingState) {
                                  return OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.red,

                                      side: const BorderSide(color: Colors.red),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: SpinKitWave(
                                      size: 15,
                                      color: Appcolors.ksecondarycolor,
                                    ),
                                  );
                                }
                                return OutlinedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor:
                                              Appcolors.kbackgroundcolor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            side: BorderSide(
                                              color: Appcolors.kbordercolor,
                                              width: 1.5,
                                            ),
                                          ),
                                          title: Row(
                                            children: [
                                              Icon(
                                                Icons.warning_amber_rounded,
                                                color: Appcolors.kprimarycolor,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Cancel Complaint',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      Appcolors.kprimarycolor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: const Text(
                                            'Are you sure you want to cancel this complaint?',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Appcolors.kblackcolor,
                                            ),
                                          ),
                                          actionsPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 8,
                                              ),
                                          actions: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    Appcolors.kblackcolor,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('No'),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Appcolors.kredcolor,
                                                foregroundColor:
                                                    Appcolors.kwhitecolor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () {
                                                context
                                                    .read<CancelComplaintBloc>()
                                                    .add(
                                                      CancelComplaintButtonClickEvent(
                                                        complaintId: complaint
                                                            .complaintId,
                                                      ),
                                                    );
                                                      Navigator.of(context).pop();
                                              },
                                              child: const Text('Yes'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    side: const BorderSide(color: Colors.red),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
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
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        width: ResponsiveUtils.screenWidth,
                        child: ElevatedButton(
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
                      ),
              ],
            ),
          ),
        );
      },
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
