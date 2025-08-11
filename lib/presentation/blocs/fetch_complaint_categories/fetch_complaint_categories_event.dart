part of 'fetch_complaint_categories_bloc.dart';

@immutable
sealed class FetchComplaintCategoriesEvent {}
final class FetchComplaintCategoriesInitialEvent extends FetchComplaintCategoriesEvent{}