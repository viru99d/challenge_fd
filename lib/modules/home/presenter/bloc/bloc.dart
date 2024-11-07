import 'package:challenge_fd/core/constants.dart';
import 'package:challenge_fd/modules/home/domain/entity/post_entity.dart';
import 'package:challenge_fd/modules/home/domain/use_cases/get_posts_use_case.dart';
import 'package:challenge_fd/modules/home/domain/use_cases/log_out_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPostsUseCase getPostsUseCase;
  final LogOutUseCase logOutUseCase;

  HomeBloc({
    required this.getPostsUseCase,
    required this.logOutUseCase,
  }) : super(
          const InitialState(
            Model(),
          ),
        ) {
    on<GetPostsEvent>(_getPostEvent);
    on<LogOutEvent>(_logOutEvent);
    on<SearchPostsEvent>(_searchPostsEvent);
  }

  Future<void> _getPostEvent(
    GetPostsEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(
        LoadingPostState(state.model),
      );

      final posts = await getPostsUseCase.call();

      emit(
        LoadedPostState(
          state.model.copyWith(
            posts: posts,
            allPosts: posts,
          ),
        ),
      );
    } catch (e) {
      if (state.model.posts.isEmpty) {
        emit(
          EmptyPostState(state.model),
        );
        return;
      }
      emit(
        ErrorState(
          state.model,
          errorMessage: Constants.text.homeToastErrorMessage,
        ),
      );
    }
  }

  Future<void> _logOutEvent(
    LogOutEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(
        LoadingState(state.model),
      );

      await logOutUseCase.call();

      emit(
        UnloggedState(state.model),
      );
    } catch (e) {
      emit(
        ErrorState(
          state.model,
          errorMessage: Constants.text.homeToastErrorMessage,
        ),
      );
    }
  }

  void _searchPostsEvent(
    SearchPostsEvent event,
    Emitter<HomeState> emit,
  ) {
    List<PostEntity> filteredPosts = [];

    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(
        LoadedPostState(
          state.model.copyWith(
            posts: state.model.allPosts,
          ),
        ),
      );

      return;
    }
    final matchingUserIds = state.model.allPosts
        .where((post) => post.title.toLowerCase().contains(query))
        .map((post) => post.userId)
        .toSet();

    filteredPosts = state.model.allPosts
        .where((post) => matchingUserIds.contains(post.userId))
        .toList();

    emit(
      LoadedPostState(
        state.model.copyWith(
          posts: filteredPosts,
        ),
      ),
    );
  }
}
