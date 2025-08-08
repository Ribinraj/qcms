part of 'registerpage_dropdown_bloc.dart';

@immutable
sealed class RegisterpageDropdownState {}

final class RegisterpageDropdownInitial extends RegisterpageDropdownState {}

final class RegisterpageDropdownLoadingState
    extends RegisterpageDropdownState {}

final class RegisterpageDropdownSuccessState extends RegisterpageDropdownState {
  final List<DivisionsModel> divisions;
  final List<DivisionsModel> filtereddivisions;
  final List<QuartersModel> quarters;
  final List<QuartersModel> filteredquarters;

  RegisterpageDropdownSuccessState({
    required this.divisions,
    required this.filtereddivisions,
    required this.quarters,
    required this.filteredquarters,
  });

  RegisterpageDropdownSuccessState copyWith({
    List<DivisionsModel>? filterdDivisions,
    List<QuartersModel>? filteredQuarters,
  }) {
    return RegisterpageDropdownSuccessState(
      divisions: divisions,
      filtereddivisions: filterdDivisions ?? filtereddivisions,
      quarters: quarters,
      filteredquarters: filteredQuarters ?? filteredquarters,
    );
  }
}

final class RegisterpageDropdownErrorState extends RegisterpageDropdownState {
  final String error;

  RegisterpageDropdownErrorState({required this.error});
}
