part of 'bloc.dart';

abstract class HomeState extends Equatable {
  final Model model;

  const HomeState(this.model);

  @override
  List<Object?> get props => [model];
}

class InitialState extends HomeState {
  const InitialState(super.model);
}

class LoadingPostState extends HomeState {
  const LoadingPostState(super.model);
}

class LoadedPostState extends HomeState {
  const LoadedPostState(super.model);
}

class ErrorPostState extends HomeState {
  const ErrorPostState(super.model, {required this.errorMessage});

  final String errorMessage;
}

class Model extends Equatable {
  const Model({
    this.posts = const [],
  });

  final List<PostEntity> posts;

  @override
  List<Object?> get props => [
        posts,
      ];

  Model copyWith({
    List<PostEntity>? posts,
  }) {
    return Model(
      posts: posts ?? this.posts,
    );
  }
}
