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

class ErrorState extends HomeState {
  const ErrorState(super.model, {required this.errorMessage});

  final String errorMessage;
}

class LoadingState extends HomeState {
  const LoadingState(super.model);
}

class UnloggedState extends HomeState {
  const UnloggedState(super.model);
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
