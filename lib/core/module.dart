import 'package:challenge_fd/core/config/preferences/preferences.dart';
import 'package:challenge_fd/modules/login/data/repository/login_repository_impl.dart';
import 'package:challenge_fd/modules/login/domain/repository/login_repository.dart';
import 'package:challenge_fd/modules/login/presenter/bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => Preferences()),
    Bind.factory<LoginRepository>(
      (i) => LoginRepositoryImpl(
        preferences: i.get<Preferences>(),
      ),
    ),
    Bind.factory(
      (i) => LoginBloc(
        i.get<LoginRepository>(),
      ),
    ),
  ];

  @override
  List<ModularRoute> get routes => [];
}
