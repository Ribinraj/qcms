part of 'fetch_quarters_bloc.dart';

@immutable
sealed class FetchQuartersEvent {}

final class FetchQuartersInitialFEtchingEvent extends FetchQuartersEvent {
  final String divisionId;

  FetchQuartersInitialFEtchingEvent({required this.divisionId});
}
