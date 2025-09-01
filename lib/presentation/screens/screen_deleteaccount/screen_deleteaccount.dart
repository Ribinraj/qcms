import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/presentation/blocs/delete_account_bloc/delete_account_bloc.dart';
import 'package:qcms/presentation/blocs/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:qcms/widgets/custom_routes.dart';

import 'package:qcms/data/profilemodel.dart';
import 'package:qcms/widgets/custom_snackbar.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _reasonController = TextEditingController();

  bool _isProfileLoaded = false;

  @override
  void initState() {
    super.initState();
    // Trigger profile fetch when the page loads
    context.read<FetchProfileBloc>().add(FetchProfileInitialEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _populateFields(Profilemodel profile) {
    if (!_isProfileLoaded) {
      _nameController.text = profile.occupantName;
      _numberController.text = profile.occupantMobile;
      _isProfileLoaded = true;
    }
  }

  Future<bool> _showDeleteConfirmation() async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Text('Confirm Deletion'),
                ],
              ),
              content: const Text(
                'Are you sure you want to delete your account? This action cannot be undone.',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
    IconData? prefixIcon,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        enabled: enabled,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.grey.shade600)
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Appcolors.ksecondarycolor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          filled: true,
          fillColor: enabled ? Colors.grey.shade50 : Colors.grey.shade100,
          labelStyle: TextStyle(color: Colors.grey.shade700),
          alignLabelWithHint: maxLines > 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            CustomNavigation.pop(context);
          },
          icon: Icon(Icons.chevron_left, size: 27),
        ),
        title: Text(
          'Delete Account',
          style: TextStyle(
            color: Appcolors.kwhitecolor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Appcolors.ksecondarycolor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocListener<FetchProfileBloc, FetchProfileState>(
        listener: (context, state) {
          if (state is FetchProfileSuccessState) {
            _populateFields(state.user);
          } else if (state is FetchProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to load profile: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<FetchProfileBloc, FetchProfileState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    ResponsiveSizedBox.height20,
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Occupant Name (disabled/readonly)
                            _buildTextField(
                              controller: _nameController,
                              label: "Occupant Name",
                              prefixIcon: Icons.person_outline,
                              enabled: false, // Make it readonly
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return "Please enter occupant name";
                              //   }
                              //   return null;
                              // },
                            ),
                            const SizedBox(height: 20),

                            // Occupant Number (disabled/readonly)
                            _buildTextField(
                              controller: _numberController,
                              label: "Mobile Number",
                              prefixIcon: Icons.phone_outlined,
                              keyboardType: TextInputType.number,
                              enabled: false, // Make it readonly
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return "Please enter mobile number";
                              //   }
                              //   return null;
                              // },
                            ),
                            const SizedBox(height: 20),

                            // Reason
                            _buildTextField(
                              controller: _reasonController,
                              label: "Reason for Account Deletion",
                              prefixIcon: Icons.edit_note_outlined,
                              maxLines: 4,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please provide a reason";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 32),

                            // Warning Message
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.orange.shade200,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.orange.shade700,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      "This action is irreversible. All your data will be permanently deleted after verification",
                                      style: TextStyle(
                                        color: Colors.orange.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Delete Account Button
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child:
                                  BlocConsumer<
                                    DeleteAccountBloc,
                                    DeleteAccountState
                                  >(
                                    listener: (context, state) {
                                      if (state is DeleteAccountSuccessState) {
                                        CustomSnackbar.show(
                                          context,
                                          message: state.message,
                                          type: SnackbarType.success,
                                        );
                                        navigateToMainPageNamed(context, 0);
                                      } else if (state
                                          is DeleteAccountErrorState) {
                                        CustomSnackbar.show(
                                          context,
                                          message: state.message,
                                          type: SnackbarType.error,
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is DeleteAccountLoadingState) {
                                        return ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.red.shade600,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            elevation: 0,
                                          ),
                                          child: SpinKitWave(
                                            size: 15,
                                            color: Appcolors.kwhitecolor,
                                          ),
                                        );
                                      }
                                      return ElevatedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<DeleteAccountBloc>()
                                                .add(
                                                  DeleteButtonClickEvent(
                                                    reason:
                                                        _reasonController.text,
                                                  ),
                                                );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red.shade600,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          elevation: 0,
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.delete_forever,
                                              size: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "Delete Account",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                            ),
                            // Show loading indicator while fetching profile
                            if (state is FetchProfileLoadingState)
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Appcolors.ksecondarycolor,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text('Loading profile data...'),
                                  ],
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
        ),
      ),
    );
  }
}
