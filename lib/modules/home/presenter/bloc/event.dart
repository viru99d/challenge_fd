part of 'bloc.dart';

abstract class HomeEvent {}

class GetPostsEvent extends HomeEvent {}

class LogOutEvent extends HomeEvent {}

class SearchPostsEvent extends HomeEvent {
  SearchPostsEvent(this.query);

  final String query;
}

class UpdateTitleEvent extends HomeEvent {
  final String title;

  UpdateTitleEvent(this.title);
}

class UpdateBodyEvent extends HomeEvent {
  final String body;

  UpdateBodyEvent(this.body);
}

class UpdateUserIdEvent extends HomeEvent {
  final int userId;

  UpdateUserIdEvent(this.userId);
}

class SavePostEvent extends HomeEvent {
  SavePostEvent();
}
