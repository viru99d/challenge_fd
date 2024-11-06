// presentation/bloc/auth_bloc.dart
import 'package:challenge_fd/modules/screen/domain/use_cases/check_autentication_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  final CheckAuthenticationUseCase screenUseCase;

  ScreenBloc(this.screenUseCase) : super(InitialState()) {
    on<CheckAuthentication>(_onCheckAuthentication);
  }

  Future<void> _onCheckAuthentication(
    CheckAuthentication event,
    Emitter<ScreenState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    final isAuthenticated = await screenUseCase.call();
    if (isAuthenticated) {
      emit(AuthenticatedState());
    } else {
      emit(UnauthenticatedState());
    }
  }
}
