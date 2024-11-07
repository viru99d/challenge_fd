part of 'bloc.dart';

abstract class HomeEvent {}

class GetPostsEvent extends HomeEvent {}

class LogOutEvent extends HomeEvent {}

class SearchPostsEvent extends HomeEvent {
  SearchPostsEvent(this.query);

  final String query;
}
