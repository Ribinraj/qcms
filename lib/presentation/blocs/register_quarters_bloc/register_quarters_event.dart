part of 'register_quarters_bloc.dart';

@immutable
sealed class RegisterQuartersEvent {}

final class RegisterQuartersButtonClickEvent extends RegisterQuartersEvent {
  final RegisterNewquartersModel quarters;

  RegisterQuartersButtonClickEvent({required this.quarters});
}
