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
}
