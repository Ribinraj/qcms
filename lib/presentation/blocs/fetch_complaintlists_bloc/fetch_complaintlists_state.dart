part of 'fetch_complaintlists_bloc.dart';

@immutable
sealed class FetchComplaintlistsState {}

final class FetchComplaintlistsInitial extends FetchComplaintlistsState {}

final class FetchComplaintlistsLoadingState extends FetchComplaintlistsState {}

final class FetchComplaintlistSuccessState extends FetchComplaintlistsState {
  final List<ComplaintListmodel> complaints;
  final List<ComplaintListmodel> filteredComplaints;
  final String searchQuery;

    FetchComplaintlistSuccessState({
    required this.complaints,
    List<ComplaintListmodel>? filteredComplaints,
    this.searchQuery = '',
  }) : filteredComplaints = filteredComplaints ?? complaints;
}

final class FetchComplaintsErrorState extends FetchComplaintlistsState {
  final String message;

  FetchComplaintsErrorState({required this.message});
}
