import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_fd/modules/login/domain/entity/user_entity.dart';
import 'package:challenge_fd/modules/login/domain/use_cases/login_use_case.dart';
import 'package:challenge_fd/modules/login/presenter/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class FakeUserEntity extends Fake implements UserEntity {}

class FakeLoginEvent extends LoginEvent {}

void main() {
  late LoginBloc loginBloc;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginBloc = LoginBloc(mockLoginUseCase);
    registerFallbackValue(FakeUserEntity());
  });

  tearDown(() {
    loginBloc.close();
  });

  group('LoginEvent', () {
    test('props of LoginEvent are empty by default', () {
      final event = FakeLoginEvent();
      expect(event.props, isEmpty);
    });
    test('UpdateNameEvent should support value equality', () {
      expect(UpdateNameEvent('challenge@fudo'),
          equals(UpdateNameEvent('challenge@fudo')));
      expect(UpdateNameEvent('challenge@fudo'),
          isNot(equals(UpdateNameEvent('password'))));
    });

    test('UpdateLastNameEvent should support value equality', () {
      expect(UpdateLastNameEvent('challenge@fudo'),
          equals(UpdateLastNameEvent('challenge@fudo')));
      expect(UpdateLastNameEvent('password'),
          isNot(equals(UpdateLastNameEvent('challenge@fudo'))));
    });

    test('different event types are not equal', () {
      expect(
          UpdateNameEvent('John'), isNot(equals(UpdateLastNameEvent('John'))));
    });
  });

  group('Model', () {
    test('canContinue is false when name and lastName are empty', () {
      const model = Model();
      expect(model.canContinue, isFalse);
    });

    test('canContinue is false when name is empty and lastName is not empty',
        () {
      const model = Model(lastName: 'passowrd');
      expect(model.canContinue, isFalse);
    });

    test('canContinue is false when name is not empty and lastName is empty',
        () {
      const model = Model(name: 'challenge@fudo');
      expect(model.canContinue, isFalse);
    });

    test('canContinue is true when both name and lastName are not empty', () {
      const model = Model(name: 'challenge@fudo', lastName: 'passowrd');
      expect(model.canContinue, isTrue);
    });
  });

  group('LoginBloc', () {
    test('initial state is InitialState', () {
      expect(loginBloc.state, equals(const InitialState(Model())));
    });

    blocTest<LoginBloc, LoginState>(
      'emits [UpdateNameState] when UpdateNameEvent is added',
      build: () => loginBloc,
      act: (bloc) => bloc.add(UpdateNameEvent('challenge@fudo')),
      expect: () => [
        const UpdateNameState(
          Model(name: 'challenge@fudo'),
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [UpdateLastNameState] when UpdateLastNameEvent is added',
      build: () => loginBloc,
      act: (bloc) => bloc.add(UpdateLastNameEvent('password')),
      expect: () => [
        const UpdateLastNameState(
          Model(lastName: 'password'),
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoadingState, LoginSuccessState] when LoginSubmittedEvent is added and loginUseCase returns success',
      build: () {
        when(() => mockLoginUseCase.call(any())).thenAnswer(
          (_) async => (true, ''),
        );
        return loginBloc;
      },
      act: (bloc) {
        bloc.add(UpdateNameEvent('challenge@fudo'));
        bloc.add(UpdateLastNameEvent('password'));
        bloc.add(LoginSubmittedEvent());
      },
      expect: () => [
        const UpdateNameState(
          Model(name: 'challenge@fudo'),
        ),
        const UpdateLastNameState(
          Model(
            name: 'challenge@fudo',
            lastName: 'password',
          ),
        ),
        const LoadingState(
          Model(
            name: 'challenge@fudo',
            lastName: 'password',
          ),
        ),
        const LoginSuccessState(
          Model(
            name: 'challenge@fudo',
            lastName: 'password',
          ),
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoadingState, LoginFailureState] when LoginSubmittedEvent is added and loginUseCase return email invalid',
      build: () {
        when(() => mockLoginUseCase.call(any())).thenAnswer(
          (_) async => (false, 'El email es incorrecto, ingrese otro'),
        );
        return loginBloc;
      },
      act: (bloc) {
        bloc.add(UpdateNameEvent('challenge'));
        bloc.add(UpdateLastNameEvent('password'));
        bloc.add(LoginSubmittedEvent());
      },
      expect: () => [
        const UpdateNameState(
          Model(name: 'challenge'),
        ),
        const UpdateLastNameState(
          Model(
            name: 'challenge',
            lastName: 'password',
          ),
        ),
        const LoadingState(
          Model(
            name: 'challenge',
            lastName: 'password',
          ),
        ),
        const LoginFailureState(
          Model(name: 'challenge', lastName: 'password'),
          errorMessage: 'El email es incorrecto, ingrese otro',
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoadingState, LoginFailureState] when LoginSubmittedEvent is added and loginUseCase return password invalid',
      build: () {
        when(() => mockLoginUseCase.call(any())).thenAnswer(
          (_) async => (false, 'La contraseña es incorrecta, ingrese otra'),
        );
        return loginBloc;
      },
      act: (bloc) {
        bloc.add(UpdateNameEvent('challenge@fudo'));
        bloc.add(UpdateLastNameEvent('123'));
        bloc.add(LoginSubmittedEvent());
      },
      expect: () => [
        const UpdateNameState(
          Model(name: 'challenge@fudo'),
        ),
        const UpdateLastNameState(
          Model(
            name: 'challenge@fudo',
            lastName: '123',
          ),
        ),
        const LoadingState(
          Model(
            name: 'challenge@fudo',
            lastName: '123',
          ),
        ),
        const LoginFailureState(
          Model(name: 'challenge@fudo', lastName: '123'),
          errorMessage: 'La contraseña es incorrecta, ingrese otra',
        ),
      ],
    );
  });
}
