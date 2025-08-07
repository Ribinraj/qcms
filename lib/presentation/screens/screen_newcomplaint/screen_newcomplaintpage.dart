// import 'package:flutter/material.dart';
// import 'package:qcms/core/constants.dart';
// import 'package:qcms/widgets/custom_appbar.dart';
// import 'package:qcms/widgets/custom_datepicker.dart';
// import 'package:qcms/widgets/custom_dropdown.dart';
// import 'package:qcms/widgets/custom_textfield.dart';

// class ScreenNewcomplaintpage extends StatefulWidget {
//   const ScreenNewcomplaintpage({super.key});

//   @override
//   State<ScreenNewcomplaintpage> createState() => _ScreenNewcomplaintpageState();
// }

// class _ScreenNewcomplaintpageState extends State<ScreenNewcomplaintpage> {
//   final TextEditingController remarksController = TextEditingController();
//   String? selectedDepartment;
//   String? selectedComplaintCategory;
//   final List<String> departments = ['mysore', 'calicut', 'cochin'];
//   final List<String> complaintCategories = ['Roof', 'Floor', 'Wall'];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'New Complaint'),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(15),
//         child: Column(
//           //mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextStyles.headline(text: 'Register your flat'),
//             ResponsiveSizedBox.height15,
//             TextStyles.body(
//               text:
//                   'If your division and quarters ate listed.but your flat is missing, please register your flat here',
//             ),
//             ResponsiveSizedBox.height20,
//             TextStyles.body(text: 'Department*'),
//             ResponsiveSizedBox.height5,
//             CustomDropdown(
//               value: selectedDepartment,
//               hintText: 'Please select Department',
//               items: departments,
//               onChanged: (value) {
//                 setState(() {
//                   selectedDepartment = value;
//                 });
//                 print('Selected property type: $value');
//               },
//             ),
//             ResponsiveSizedBox.height15,
//             TextStyles.body(text: 'Complaint Category*'),
//             ResponsiveSizedBox.height5,
//             CustomDropdown(
//               value: selectedDepartment,
//               hintText: 'Please select Category',
//               items: departments,
//               onChanged: (value) {
//                 setState(() {
//                   selectedDepartment = value;
//                 });
//                 print('Selected property type: $value');
//               },
//             ),
//             ResponsiveSizedBox.height15,
//             TextStyles.body(text: 'Preferred Date & Time for Artisans visit'),
//             ResponsiveSizedBox.height5,
//             CustomDateTimePicker(
//               hintText: "Select appointment time",
//               onChanged: (DateTime? dateTime) {
//                 // Handle the selected date/time
//                 print('Selected: $dateTime');
//               },
//             ),
//             ResponsiveSizedBox.height15,
//             TextStyles.body(text: 'Remarks(Optional)'),
//             ResponsiveSizedBox.height5,
//             CustomTextField(
//               controller: remarksController,
//               hintText: 'Enter your remarks',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
////////////////////////////////////////////
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/core/responsiveutils.dart';
import 'package:qcms/widgets/custom_appbar.dart';
import 'package:qcms/widgets/custom_datepicker.dart';
import 'package:qcms/widgets/custom_dropdown.dart';
import 'package:qcms/widgets/custom_loginbutton.dart';
import 'package:qcms/widgets/custom_textfield.dart';

class ScreenNewcomplaintpage extends StatefulWidget {
  const ScreenNewcomplaintpage({super.key});

  @override
  State<ScreenNewcomplaintpage> createState() => _ScreenNewcomplaintpageState();
}

class _ScreenNewcomplaintpageState extends State<ScreenNewcomplaintpage> {
  final TextEditingController remarksController = TextEditingController();
  String? selectedDepartment;
  String? selectedComplaintCategory;
  DateTime? selectedDateTime;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  final List<String> departments = ['mysore', 'calicut', 'cochin'];
  final List<String> complaintCategories = ['Roof', 'Floor', 'Wall'];

  Future<void> _showImageSourceDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select Image Source',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: Appcolors.ksecondarycolor,
                ),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: Appcolors.ksecondarycolor,
                ),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  Widget _buildImagePickerContainer() {
    return Container(
      width: double.infinity,
      height: _selectedImage != null
          ? ResponsiveUtils.hp(25)
          : ResponsiveUtils.hp(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E4F3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Appcolors.ksecondarycolor.withAlpha(77),
          width: 1.5,
        ),
      ),
      child: _selectedImage != null
          ? Stack(
              children: [
                // Image display
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(_selectedImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Edit button overlay
                Positioned(
                  top: 8,
                  right: 8,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: _showImageSourceDialog,
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: _removeImage,
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : InkWell(
              onTap: _showImageSourceDialog,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Appcolors.ksecondarycolor.withAlpha(33),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add_a_photo,
                        size: 32,
                        color: Appcolors.ksecondarycolor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Add Photo',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Appcolors.ksecondarycolor,
                      ),
                    ),

                    Text(
                      'Tap to select from camera or gallery',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSectionCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(33),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: CustomAppBar(title: 'New Complaint'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildSectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Appcolors.ksecondarycolor.withAlpha(33),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.apartment,
                          color: Appcolors.ksecondarycolor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextStyles.headline(text: 'Register your flat'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextStyles.body(
                    text:
                        'If your division and quarters are listed but your flat is missing, please register your flat here',
                  ),
                ],
              ),
            ),

            ResponsiveSizedBox.height20,

            // Form Section
            _buildSectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Department Field
                  Row(
                    children: [
                      const Icon(
                        Icons.business,
                        color: Appcolors.ksecondarycolor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      TextStyles.body(text: 'Department*'),
                    ],
                  ),
                  ResponsiveSizedBox.height5,
                  CustomDropdown(
                    value: selectedDepartment,
                    hintText: 'Please select Department',
                    items: departments,
                    onChanged: (value) {
                      setState(() {
                        selectedDepartment = value;
                      });
                      print('Selected department: $value');
                    },
                  ),

                  ResponsiveSizedBox.height15,

                  // Complaint Category Field
                  Row(
                    children: [
                      const Icon(
                        Icons.category,
                        color: Appcolors.ksecondarycolor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      TextStyles.body(text: 'Complaint Category*'),
                    ],
                  ),
                  ResponsiveSizedBox.height5,
                  CustomDropdown(
                    value: selectedComplaintCategory,
                    hintText: 'Please select Category',
                    items: complaintCategories,
                    onChanged: (value) {
                      setState(() {
                        selectedComplaintCategory = value;
                      });
                      print('Selected category: $value');
                    },
                  ),

                  ResponsiveSizedBox.height15,

                  // Date Time Field
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        color: Appcolors.ksecondarycolor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextStyles.body(
                          text: 'Preferred Date & Time for Artisan\'s visit',
                        ),
                      ),
                    ],
                  ),
                  ResponsiveSizedBox.height5,
                  CustomDateTimePicker(
                    hintText: "Select appointment time",
                    selectedDateTime: selectedDateTime,
                    onChanged: (DateTime? dateTime) {
                      setState(() {
                        selectedDateTime = dateTime;
                      });
                      print('Selected: $dateTime');
                    },
                  ),

                  ResponsiveSizedBox.height15,

                  // Remarks Field
                  Row(
                    children: [
                      const Icon(
                        Icons.note_alt,
                        color: Appcolors.ksecondarycolor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      TextStyles.body(text: 'Remarks (Optional)'),
                    ],
                  ),
                  ResponsiveSizedBox.height5,
                  CustomTextField(
                    controller: remarksController,
                    hintText: 'Enter your remarks',
                  ),
                ],
              ),
            ),

            ResponsiveSizedBox.height20,

            // Image Upload Section
            _buildSectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.photo_camera,
                        color: Appcolors.ksecondarycolor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      TextStyles.body(text: 'Upload Image (Optional)'),
                    ],
                  ),
                  ResponsiveSizedBox.height20,
                  Text(
                    'Add a photo to help us understand the issue better',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  ResponsiveSizedBox.height15,
                  _buildImagePickerContainer(),
                ],
              ),
            ),
            ResponsiveSizedBox.height30,
            // Submit Button
            Customloginbutton(
              onPressed: () {
                // Handle form submission
                print('Department: $selectedDepartment');
                print('Category: $selectedComplaintCategory');
                print('DateTime: $selectedDateTime');
                print('Remarks: ${remarksController.text}');
                print('Image: ${_selectedImage?.path}');

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Complaint submitted successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              text: 'Submit Complaint',
            ),

            ResponsiveSizedBox.height20,
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    remarksController.dispose();
    super.dispose();
  }
}
