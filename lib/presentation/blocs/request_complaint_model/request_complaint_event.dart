part of 'request_complaint_bloc.dart';

@immutable
sealed class RequestComplaintEvent {}

final class RequestComplaintButtonClickEvent extends RequestComplaintEvent {
  final ComplaintRequestModel complaint;

  RequestComplaintButtonClickEvent({required this.complaint});
}
