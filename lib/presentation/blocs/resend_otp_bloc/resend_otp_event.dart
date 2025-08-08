part of 'resend_otp_bloc.dart';

@immutable
sealed class ResendOtpEvent {}
final class ResendOtpClickEvent extends ResendOtpEvent {
  final String flatId;

  ResendOtpClickEvent({required this.flatId});
}
