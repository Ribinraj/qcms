part of 'fetch_complaintlists_bloc.dart';

@immutable
sealed class FetchComplaintlistsEvent {}
final class FetchComplaintsInitialEvent extends FetchComplaintlistsEvent{}
final class SearchComplaintsEvent extends FetchComplaintlistsEvent {
  final String query;
  SearchComplaintsEvent({required this.query});
}
final class UpdateComplaintStatusEvent extends FetchComplaintlistsEvent {
  final String complaintId;
  final String newStatus;
  
  UpdateComplaintStatusEvent({
    required this.complaintId,
    required this.newStatus,
  });
}