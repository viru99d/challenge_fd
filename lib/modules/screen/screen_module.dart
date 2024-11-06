import 'package:challenge_fd/core/config/preferences/preferences.dart';
import 'package:challenge_fd/modules/screen/data/screen_repository_impl.dart';
import 'package:challenge_fd/modules/screen/domain/repository/screen_repository.dart';
import 'package:challenge_fd/modules/screen/domain/use_cases/check_autentication_use_case.dart';
import 'package:challenge_fd/modules/screen/presenter/bloc/bloc.dart';
import 'package:challenge_fd/modules/screen/presenter/pages/screen_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ScreenModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<ScreenRepository>(
      (i) => ScreenRepositoryImpl(
        i.get<Preferences>(),
      ),
    ),
    Bind.factory(
      (i) => CheckAuthenticationUseCase(
        i.get<ScreenRepository>(),
      ),
    ),
    Bind.factory(
      (i) => ScreenBloc(
        i.get<CheckAuthenticationUseCase>(),
      ),
    ),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) {
            return ScreenPage(
              screenBloc: Modular.get<ScreenBloc>(),
            );
          },
        ),
      ];
}
