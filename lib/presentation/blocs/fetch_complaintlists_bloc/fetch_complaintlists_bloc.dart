import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms/data/complaint_listmodel.dart';
import 'package:qcms/domain/repositories/apprepo.dart';

part 'fetch_complaintlists_event.dart';
part 'fetch_complaintlists_state.dart';

class FetchComplaintlistsBloc
    extends Bloc<FetchComplaintlistsEvent, FetchComplaintlistsState> {
  final Apprepo repository;
  List<ComplaintListmodel> _allComplaints = [];
  FetchComplaintlistsBloc({required this.repository})
    : super(FetchComplaintlistsInitial()) {
    on<FetchComplaintlistsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchComplaintsInitialEvent>(fetchcomplaints);
     on<SearchComplaintsEvent>(searchComplaints);
      on<UpdateComplaintStatusEvent>(updateComplaintStatus);
  }

  FutureOr<void> fetchcomplaints(
    FetchComplaintsInitialEvent event,
    Emitter<FetchComplaintlistsState> emit,
  ) async {
    emit(FetchComplaintlistsLoadingState());
    try {
      final response = await repository.complaintlists();
      if (!response.error && response.status == 200) {
         _allComplaints = response.data!;
        emit(FetchComplaintlistSuccessState(complaints:_allComplaints));
      } else {
        emit(FetchComplaintsErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchComplaintsErrorState(message: e.toString()));
    }
  }
   FutureOr<void> searchComplaints(
    SearchComplaintsEvent event,
    Emitter<FetchComplaintlistsState> emit,
  ) async {
    if (_allComplaints.isEmpty) return;

    List<ComplaintListmodel> filteredComplaints;

    if (event.query.isEmpty) {
      filteredComplaints = _allComplaints;
    } else {
      filteredComplaints = _allComplaints
          .where((complaint) =>
              complaint.complaintId
                  .toLowerCase()
                  .contains(event.query.toLowerCase()))
          .toList();
    }

    emit(FetchComplaintlistSuccessState(
      complaints: _allComplaints,
      filteredComplaints: filteredComplaints,
      searchQuery: event.query,
    ));
  }
    FutureOr<void> updateComplaintStatus(
    UpdateComplaintStatusEvent event,
    Emitter<FetchComplaintlistsState> emit,
  ) async {
    // Find and update the complaint in the list
    final updatedComplaints = _allComplaints.map((complaint) {
      if (complaint.complaintId == event.complaintId) {
        // Create new complaint with updated status
      return ComplaintListmodel(
  complaintId: complaint.complaintId,
  departmentId: complaint.departmentId,
  complaintBy: complaint.complaintBy, // missing in your original
  cityId: complaint.cityId,
  quarterId: complaint.quarterId,
  flatId: complaint.flatId,
  categoryId: complaint.categoryId,
  complaintRemarks: complaint.complaintRemarks, // was missing
  imageAddress: complaint.imageAddress,         // was missing
  complaintDate: complaint.complaintDate,
  complaintStatus: event.newStatus, // you already had this
  artisanId: complaint.artisanId,   // was missing
  artisansVisitDate: complaint.artisansVisitDate,
  workerName: complaint.workerName,
  workerMobile: complaint.workerMobile,
  remark: complaint.remark,
  complaintResolutionTime: complaint.complaintResolutionTime,
  complaintOTP: complaint.complaintOTP,
  verifyOTP: complaint.verifyOTP,
  repairCost: complaint.repairCost,
  completionPicture: complaint.completionPicture,
  remarks: complaint.remarks,
  updatedBy: complaint.updatedBy,
  complaintClosed: complaint.complaintClosed,
  complaintFeedback: complaint.complaintFeedback,
);

      }
      return complaint;
    }).toList();

    _allComplaints = updatedComplaints;
    
    // Emit updated state
    final currentState = state;
    if (currentState is FetchComplaintlistSuccessState) {
      emit(FetchComplaintlistSuccessState(
        complaints: _allComplaints,
        filteredComplaints: currentState.searchQuery.isEmpty 
            ? _allComplaints 
            : _allComplaints.where((complaint) =>
                complaint.complaintId
                    .toLowerCase()
                    .contains(currentState.searchQuery.toLowerCase())).toList(),
        searchQuery: currentState.searchQuery,
      ));
    } else {
      emit(FetchComplaintlistSuccessState(complaints: _allComplaints));
    }
  }
}
