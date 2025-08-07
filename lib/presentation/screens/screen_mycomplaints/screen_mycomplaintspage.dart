// import 'package:flutter/material.dart';
// import 'package:qcms/core/colors.dart';
// import 'package:qcms/core/constants.dart';
// import 'package:qcms/widgets/custom_appbar.dart';

// class ScreenMycomplaintspage extends StatefulWidget {
//   const ScreenMycomplaintspage({super.key});

//   @override
//   State<ScreenMycomplaintspage> createState() => _ScreenMycomplaintspageState();
// }

// class _ScreenMycomplaintspageState extends State<ScreenMycomplaintspage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'View Complaints'),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withAlpha(33),
//                     spreadRadius: 1,
//                     blurRadius: 6,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Appcolors.ksecondarycolor.withAlpha(33),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Icon(
//                           Icons.apartment,
//                           color: Appcolors.ksecondarycolor,
//                           size: 24,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: TextStyles.headline(text: 'View Complaints'),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   TextStyles.body(
//                     text: 'Please track all your complaints from here',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
///////////////////////////////
import 'package:flutter/material.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/widgets/custom_appbar.dart';
import 'package:qcms/widgets/custom_routes.dart';

class ScreenMycomplaintspage extends StatefulWidget {
  const ScreenMycomplaintspage({super.key});

  @override
  State<ScreenMycomplaintspage> createState() => _ScreenMycomplaintspageState();
}

class _ScreenMycomplaintspageState extends State<ScreenMycomplaintspage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> complaints = [
    {
      'id': '1233',
      'category': 'Water Supply',
      'date': '2024-01-15',
      'status': 'Cancelled',
      'description': 'Water supply issue in apartment block A',
    },
    {
      'id': '1234',
      'category': 'Electrical',
      'date': '2024-01-18',
      'status': 'In Progress',
      'description': 'Power outage in common area',
    },
    {
      'id': '1235',
      'category': 'Maintenance',
      'date': '2024-01-20',
      'status': 'Resolved',
      'description': 'Elevator maintenance required',
    },
    {
      'id': '1236',
      'category': 'Plumbing',
      'date': '2024-01-22',
      'status': 'Pending',
      'description': 'Pipe leakage in basement',
    },
    {
      'id': '1237',
      'category': 'Security',
      'date': '2024-01-25',
      'status': 'In Progress',
      'description': 'CCTV camera not working',
    },
  ];

  List<Map<String, String>> filteredComplaints = [];

  @override
  void initState() {
    super.initState();
    filteredComplaints = complaints;
  }

  void _filterComplaints(String query) {
    // Check if widget is still mounted before calling setState
    if (!mounted) return;

    setState(() {
      if (query.isEmpty) {
        filteredComplaints = complaints;
      } else {
        filteredComplaints = complaints
            .where(
              (complaint) =>
                  complaint['id']!.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  complaint['category']!.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  complaint['status']!.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();
      }
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'resolved':
        return Colors.green;
      case 'in progress':
        return Colors.orange;
      case 'pending':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'View Complaints'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Container
            Container(
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
                        child: TextStyles.headline(text: 'View Complaints'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextStyles.body(
                    text: 'Please track all your complaints from here',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(20),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterComplaints,
                decoration: InputDecoration(
                  hintText: 'Search complaints by ID, category, or status...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _filterComplaints('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Complaints List
            filteredComplaints.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No complaints found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredComplaints.length,
                    itemBuilder: (context, index) {
                      final complaint = filteredComplaints[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(20),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              CustomNavigation.pushNamedWithTransition(
                                context,
                                AppRouter.complaintdetails,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Complaint ID and Status
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Complaint: #${complaint['id']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: _getStatusColor(
                                                  complaint['status']!,
                                                ).withAlpha(20),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                complaint['status']!,
                                                style: TextStyle(
                                                  color: _getStatusColor(
                                                    complaint['status']!,
                                                  ),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 6),

                                        // Category
                                        Text(
                                          'Category: ${complaint['category']}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),

                                        const SizedBox(height: 4),

                                        // Date
                                        Text(
                                          'Date: ${complaint['date']}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Arrow Icon
                                  Icon(
                                    Icons.remove_red_eye,
                                    color: Appcolors.ksecondarycolor,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
