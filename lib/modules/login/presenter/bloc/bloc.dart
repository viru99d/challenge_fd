import 'package:challenge_fd/core/constants.dart';
import 'package:challenge_fd/modules/login/domain/entity/user_entity.dart';
import 'package:challenge_fd/modules/login/domain/repository/login_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc(
    this.loginRepository,
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

    final isAuthenticated = await loginRepository.login(userEntity);

    if (isAuthenticated) {
      emit(LoginSuccessState(state.model));
    } else {
      emit(
        LoginFailureState(
          state.model,
          errorMessage: Constants.loginErrorMessage,
        ),
      );
    }
  }
}
