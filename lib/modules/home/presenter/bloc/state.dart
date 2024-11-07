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

class EmptyPostState extends HomeState {
  const EmptyPostState(super.model);
}

class UpdatedTitleState extends HomeState {
  const UpdatedTitleState(super.model);
}

class UpdatedBodyState extends HomeState {
  const UpdatedBodyState(super.model);
}

class UpdatedUserIdState extends HomeState {
  const UpdatedUserIdState(super.model);
}

class SavedPostState extends HomeState {
  const SavedPostState(super.model);
}

class SavingPostState extends HomeState {
  const SavingPostState(super.model);
}

class Model extends Equatable {
  const Model({
    this.allPosts = const [],
    this.posts = const [],
    this.postEntity = const PostEntity(),
  });

  final List<PostEntity> allPosts;
  final List<PostEntity> posts;
  final PostEntity postEntity;

  @override
  List<Object?> get props => [
        allPosts,
        posts,
        postEntity,
      ];

  Model copyWith({
    List<PostEntity>? allPosts,
    List<PostEntity>? posts,
    PostEntity? postEntity,
  }) {
    return Model(
      allPosts: allPosts ?? this.allPosts,
      posts: posts ?? this.posts,
      postEntity: postEntity ?? this.postEntity,
    );
  }
}
