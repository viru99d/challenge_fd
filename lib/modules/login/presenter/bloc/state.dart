part of 'bloc.dart';

abstract class LoginState extends Equatable {
  final Model model;

  const LoginState(this.model);

  @override
  List<Object?> get props => [model];
}

class InitialState extends LoginState {
  const InitialState(super.model);
}

class LoadingState extends LoginState {
  const LoadingState(super.model);
}

class UpdateNameState extends LoginState {
  const UpdateNameState(super.model);
}

class UpdateLastNameState extends LoginState {
  const UpdateLastNameState(super.model);
}

class LoginFailureState extends LoginState {
  const LoginFailureState(super.model, {required this.errorMessage});

  final String errorMessage;
}

class LoginSuccessState extends LoginState {
  const LoginSuccessState(super.model);
}

class Model extends Equatable {
  const Model({
    this.name = '',
    this.lastName = '',
  });

  final String name;
  final String lastName;

  bool get canContinue => name.isNotEmpty && lastName.isNotEmpty;

  @override
  List<Object?> get props => [
        name,
        lastName,
      ];

  Model copyWith({
    String? name,
    String? lastName,
  }) {
    return Model(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
    );
  }
}
