part of 'verify_otp_bloc.dart';

@immutable
sealed class VerifyOtpEvent {}

final class VerifyOtpButtonClickEvent extends VerifyOtpEvent {
  final String flatId;
  final String otp;

  VerifyOtpButtonClickEvent({required this.flatId, required this.otp});


}
