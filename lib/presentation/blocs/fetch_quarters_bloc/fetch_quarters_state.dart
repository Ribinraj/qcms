part of 'fetch_quarters_bloc.dart';

@immutable
sealed class FetchQuartersState {}

final class FetchQuartersInitial extends FetchQuartersState {}

final class FetchQuartersLoadingState extends FetchQuartersState {}

final class FetchQuartersSuccessState extends FetchQuartersState {
  final List<QuartersModel> quarters;

  FetchQuartersSuccessState({required this.quarters});
}

final class FetchQuartersErrorState extends FetchQuartersState {
  final String message;

  FetchQuartersErrorState({required this.message});
}
