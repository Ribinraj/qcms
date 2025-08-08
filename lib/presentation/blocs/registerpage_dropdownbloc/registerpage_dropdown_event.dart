part of 'registerpage_dropdown_bloc.dart';

@immutable
sealed class RegisterpageDropdownEvent {}

final class RegisterpageDropdownFetchingInitailEvent
    extends RegisterpageDropdownEvent {}

final class SearchDivisonsEvent extends RegisterpageDropdownEvent {
  final String query;

  SearchDivisonsEvent({required this.query});
}

final class SearchQuartersEvent extends RegisterpageDropdownEvent {
  final String query;

  SearchQuartersEvent({required this.query});
}
