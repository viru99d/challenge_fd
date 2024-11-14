import 'package:challenge_fd/modules/login/domain/entity/user_entity.dart';
import 'package:challenge_fd/modules/login/domain/use_cases/login_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(
    this.loginUseCase,
  ) : super(
          const InitialState(
            Model(),
          ),
        ) {
    on<UpdateNameEvent>(_changeNameEvent);
    on<UpdateLastNameEvent>(_changeLastNameEvent);
    on<LoginSubmittedEvent>(_handleLogin);
  }

  void _changeNameEvent(
    UpdateNameEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      UpdateNameState(
        state.model.copyWith(
          name: event.name,
        ),
      ),
    );
  }

  void _changeLastNameEvent(
    UpdateLastNameEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      UpdateLastNameState(
        state.model.copyWith(
          lastName: event.lastName,
        ),
      ),
    );
  }

  void _handleLogin(LoginSubmittedEvent event, Emitter<LoginState> emit) async {
    emit(LoadingState(state.model));

    final userEntity = UserEntity(
      email: state.model.name,
      password: state.model.lastName,
    );

    final isAuthenticated = await loginUseCase.call(userEntity);

    if (isAuthenticated.$1) {
      emit(LoginSuccessState(state.model));
    } else {
      emit(
        LoginFailureState(
          state.model,
          errorMessage: isAuthenticated.$2,
        ),
      );
    }
  }
}
