import 'package:challenge_fd/core/constants.dart';
import 'package:challenge_fd/modules/home/domain/entity/post_entity.dart';
import 'package:challenge_fd/modules/home/domain/use_cases/get_posts_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPostsUseCase getPostsUseCase;

  HomeBloc(this.getPostsUseCase)
      : super(
          const InitialState(
            Model(),
          ),
        ) {
    on<GetPostsEvent>(_getPostEvent);
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
          ),
        ),
      );
    } catch (e) {
      emit(
        ErrorPostState(
          state.model,
          errorMessage: Constants.text.homeToastErrorMessage,
        ),
      );
    }
  }
}
