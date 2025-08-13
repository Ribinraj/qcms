import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/core/responsiveutils.dart';
import 'package:qcms/presentation/blocs/fetch_complaintlists_bloc/fetch_complaintlists_bloc.dart';
import 'package:qcms/widgets/custom_appbar.dart';
import 'package:qcms/widgets/custom_routes.dart';

// class ScreenMycomplaintspage extends StatefulWidget {
//   const ScreenMycomplaintspage({super.key});

//   @override
//   State<ScreenMycomplaintspage> createState() => _ScreenMycomplaintspageState();
// }

// class _ScreenMycomplaintspageState extends State<ScreenMycomplaintspage> {
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     context.read<FetchComplaintlistsBloc>().add(FetchComplaintsInitialEvent());
//   }

//   void _onSearchChanged(String query) {
//     context.read<FetchComplaintlistsBloc>().add(
//       SearchComplaintsEvent(query: query),
//     );
//   }

//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'scheduled':
//         return Colors.green;
//       case 'wip':
//         return Colors.orange;
//       case 'open':
//         return Colors.blue;
//       case 'cancelled':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'View Complaints'),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Container
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

//             const SizedBox(height: 20),

//             // Search Bar
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withAlpha(20),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, 1),
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 controller: _searchController,
//                 onChanged: _onSearchChanged,
//                 decoration: InputDecoration(
//                   hintText: 'Search complaints by ID...',
//                   prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                   suffixIcon: _searchController.text.isNotEmpty
//                       ? IconButton(
//                           icon: const Icon(Icons.clear),
//                           onPressed: () {
//                             _searchController.clear();
//                             _onSearchChanged('');
//                           },
//                         )
//                       : null,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 12,
//                   ),
//                 ),
//               ),
//             ),

//             ResponsiveSizedBox.height20,
//             BlocBuilder<FetchComplaintlistsBloc, FetchComplaintlistsState>(
//               builder: (context, state) {
//                 if (state is FetchComplaintlistsLoadingState) {
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: 4,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         height: ResponsiveUtils.hp(15),
//                         margin: const EdgeInsets.only(bottom: 12),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withAlpha(20),
//                               spreadRadius: 1,
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: SpinKitCircle(
//                             size: 20,
//                             color: Appcolors.ksecondarycolor,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 } else if (state is FetchComplaintsErrorState) {
//                   return Center(child: Text(state.message));
//                 } else if (state is FetchComplaintlistSuccessState) {
//                   // Use filteredComplaints instead of complaints
//                   final complaintsToShow = state.filteredComplaints;

//                   if (complaintsToShow.isEmpty && state.searchQuery.isNotEmpty) {
//                     return Container(
//                       padding: const EdgeInsets.all(32),
//                       child: Center(
//                         child: Column(
//                           children: [
//                             Icon(
//                               Icons.search_off,
//                               size: 64,
//                               color: Colors.grey.shade400,
//                             ),
//                             const SizedBox(height: 16),
//                             Text(
//                               'No complaints found',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'Try searching with a different complaint ID',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey.shade500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }

//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: complaintsToShow.length,
//                     itemBuilder: (context, index) {
//                       final complaint = complaintsToShow[index];
//                       return Container(
//                         margin: const EdgeInsets.only(bottom: 12),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withAlpha(20),
//                               spreadRadius: 1,
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Material(
//                           color: Colors.transparent,
//                           borderRadius: BorderRadius.circular(12),
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(12),
//                          onTap: () {
//   CustomNavigation.pushNamedWithTransition(
//     context,
//     AppRouter.complaintdetails,
//     arguments: {
//       'complaintdetails': complaint, // your ComplaintListmodel instance
//     },
//   );
// }
// ,
//                             child: Padding(
//                               padding: const EdgeInsets.all(16),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         // Complaint ID and Status
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                               'Complaint: ${complaint.complaintId}',
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 16,
//                                                 color: Colors.black87,
//                                               ),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                     horizontal: 8,
//                                                     vertical: 4,
//                                                   ),
//                                               decoration: BoxDecoration(
//                                                 color: _getStatusColor(
//                                                   complaint.complaintStatus,
//                                                 ).withAlpha(20),
//                                                 borderRadius:
//                                                     BorderRadius.circular(6),
//                                               ),
//                                               child: Text(
//                                                 complaint.complaintStatus,
//                                                 style: TextStyle(
//                                                   color: _getStatusColor(
//                                                     complaint.complaintStatus,
//                                                   ),
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),

//                                         ResponsiveSizedBox.height5,

//                                         // Category
//                                         Text(
//                                           'Category: ${complaint.categoryId}',
//                                           style: const TextStyle(
//                                             fontSize: 14,
//                                             color: Colors.black54,
//                                           ),
//                                         ),

//                                         ResponsiveSizedBox.height10,

//                                         // Date
//                                         Text(
//                                           'Date: ${DateFormat('d MMM yyyy').format(DateTime.parse(complaint.complaintDate))}',
//                                           style: const TextStyle(
//                                             fontSize: 14,
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),

//                                   // Arrow Icon
//                                   Icon(
//                                     Icons.remove_red_eye,
//                                     color: Appcolors.ksecondarycolor,
//                                     size: 25,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 } else {
//                   return SizedBox.shrink();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }
class ScreenMycomplaintspage extends StatefulWidget {
  const ScreenMycomplaintspage({super.key});

  @override
  State<ScreenMycomplaintspage> createState() => _ScreenMycomplaintspageState();
}

class _ScreenMycomplaintspageState extends State<ScreenMycomplaintspage> {
  final TextEditingController _searchController = TextEditingController();
  //  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    context.read<FetchComplaintlistsBloc>().add(FetchComplaintsInitialEvent());
  }

  void _onSearchChanged(String query) {
    context.read<FetchComplaintlistsBloc>().add(
      SearchComplaintsEvent(query: query),
    );
  }

  Future<void> _onRefresh() async {
 

    // Clear search if there's any active search
    if (_searchController.text.isNotEmpty) {
      _searchController.clear();
    }

    // Trigger refresh event
    context.read<FetchComplaintlistsBloc>().add(FetchComplaintsInitialEvent());

    // Wait for the state to update
    await Future.delayed(const Duration(milliseconds: 1500));

   
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return Colors.green;
      case 'wip':
        return Colors.orange;
      case 'open':
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
      appBar: CustomAppBar(title: "mycomplaints viewcomplaint".tr()),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Appcolors.ksecondarycolor,
        backgroundColor: Colors.white,
        strokeWidth: 2.5,
        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(), // Important for pull-to-refresh
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
                          child: TextStyles.headline(text:"mycomplaints viewcomplaint".tr()),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextStyles.body(
                      text:  "mycomplaints subheadline".tr(),
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
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search complaints by ID...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _onSearchChanged('');
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

              ResponsiveSizedBox.height20,

              BlocBuilder<FetchComplaintlistsBloc, FetchComplaintlistsState>(
                builder: (context, state) {
                  if (state is FetchComplaintlistsLoadingState) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          height: ResponsiveUtils.hp(15),
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
                          child: Center(
                            child: SpinKitCircle(
                              size: 20,
                              color: Appcolors.ksecondarycolor,
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is FetchComplaintsErrorState) {
                    return Container(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Something went wrong',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<FetchComplaintlistsBloc>().add(
                                  FetchComplaintsInitialEvent(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Appcolors.ksecondarycolor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is FetchComplaintlistSuccessState) {
                    // Use filteredComplaints instead of complaints
                    final complaintsToShow = state.filteredComplaints;

                    if (complaintsToShow.isEmpty &&
                        state.searchQuery.isNotEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No complaints found',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Try searching with a different complaint ID',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (complaintsToShow.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.inbox_outlined,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No complaints yet',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Pull down to refresh or create your first complaint',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: complaintsToShow.length,
                      itemBuilder: (context, index) {
                        final complaint = complaintsToShow[index];
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
                                  arguments: {'complaintdetails': complaint},
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
                                                'Complaint: ${complaint.complaintId}',
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
                                                    complaint.complaintStatus,
                                                  ).withAlpha(20),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  complaint.complaintStatus,
                                                  style: TextStyle(
                                                    color: _getStatusColor(
                                                      complaint.complaintStatus,
                                                    ),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          ResponsiveSizedBox.height5,

                                          // Category
                                          Text(
                                            'Category: ${complaint.categoryId}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),

                                          ResponsiveSizedBox.height10,

                                          // Date
                                          Text(
                                            'Date: ${DateFormat('d MMM yyyy').format(DateTime.parse(complaint.complaintDate))}',
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
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
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
