part of 'send_otp_bloc.dart';

@immutable
sealed class SendOtpState {}

final class SendOtpInitial extends SendOtpState {}
final class SendOtpLoadingState extends SendOtpState {}

final class SendOtpSuccess extends SendOtpState {
  final String flatId;

  SendOtpSuccess({required this.flatId});


}

final class SendOtpFailure extends SendOtpState {
  final String error;
  SendOtpFailure({required this.error});
}
