part of 'register_newdivision_bloc.dart';

@immutable
sealed class RegisterNewdivisionEvent {}

final class RegisterNewdvisionButtonClickEvent
    extends RegisterNewdivisionEvent {
  final RegisterNewdivisionModel divsion;

  RegisterNewdvisionButtonClickEvent({required this.divsion});
}
