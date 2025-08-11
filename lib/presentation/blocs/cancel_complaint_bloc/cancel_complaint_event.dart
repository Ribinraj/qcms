part of 'cancel_complaint_bloc.dart';

@immutable
sealed class CancelComplaintEvent {}

final class CancelComplaintButtonClickEvent extends CancelComplaintEvent {
  final String complaintId;

  CancelComplaintButtonClickEvent({required this.complaintId});
}
