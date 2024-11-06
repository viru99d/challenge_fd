import 'package:challenge_fd/core/config/preferences/preferences.dart';
import 'package:challenge_fd/modules/login/data/repository/login_repository_impl.dart';
import 'package:challenge_fd/modules/login/domain/repository/login_repository.dart';
import 'package:challenge_fd/modules/login/domain/use_cases/login_use_case.dart';
import 'package:challenge_fd/modules/login/presenter/bloc/bloc.dart';
import 'package:challenge_fd/modules/login/presenter/pages/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<LoginRepository>(
      (i) => LoginRepositoryImpl(
        preferences: i.get<Preferences>(),
      ),
    ),
    Bind.factory(
      (i) => LoginUseCase(
        i.get<LoginRepository>(),
      ),
    ),
    Bind.factory(
      (i) => LoginBloc(
        i.get<LoginUseCase>(),
      ),
    ),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) {
            return LoginPage(
              loginBloc: Modular.get<LoginBloc>(),
            );
          },
        ),
      ];
}
