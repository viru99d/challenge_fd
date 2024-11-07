import 'package:challenge_fd/core/constants.dart';
import 'package:challenge_fd/modules/home/data/models/post_model.dart';
import 'package:challenge_fd/modules/home/domain/entity/post_entity.dart';
import 'package:challenge_fd/modules/home/domain/use_cases/get_posts_use_case.dart';
import 'package:challenge_fd/modules/home/domain/use_cases/log_out_use_case.dart';
import 'package:challenge_fd/modules/home/domain/use_cases/save_post_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPostsUseCase getPostsUseCase;
  final LogOutUseCase logOutUseCase;
  final SavePostUseCase savePostUseCase;

  HomeBloc({
    required this.getPostsUseCase,
    required this.logOutUseCase,
    required this.savePostUseCase,
  }) : super(
          const InitialState(
            Model(),
          ),
        ) {
    on<GetPostsEvent>(_getPostEvent);
    on<LogOutEvent>(_logOutEvent);
    on<SearchPostsEvent>(_searchPostsEvent);
    on<UpdateTitleEvent>(_updateTitleEvent);
    on<UpdateBodyEvent>(_updateBodyEvent);
    on<UpdateUserIdEvent>(_updateUserIdEvent);
    on<SavePostEvent>(_savePostEvent);
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

  void _updateTitleEvent(
    UpdateTitleEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      UpdatedTitleState(
        state.model.copyWith(
          postEntity: state.model.postEntity.copyWith(
            title: event.title,
          ),
        ),
      ),
    );
  }

  void _updateBodyEvent(
    UpdateBodyEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      UpdatedBodyState(
        state.model.copyWith(
          postEntity: state.model.postEntity.copyWith(
            body: event.body,
          ),
        ),
      ),
    );
  }

  void _updateUserIdEvent(
    UpdateUserIdEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      UpdatedUserIdState(
        state.model.copyWith(
          postEntity: state.model.postEntity.copyWith(
            userId: event.userId,
          ),
        ),
      ),
    );
  }

  Future<void> _savePostEvent(
    SavePostEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(
        SavingPostState(state.model),
      );

      final postModel = PostModel(
        title: state.model.postEntity.title,
        body: state.model.postEntity.body,
        userId: state.model.postEntity.userId,
      );

      await savePostUseCase.call(postModel);

      emit(
        SavedPostState(state.model),
      );
    } catch (e) {
      emit(
        ErrorState(
          state.model,
          errorMessage: Constants.text.savePostError,
        ),
      );
    }
  }
}
