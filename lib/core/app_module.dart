import 'package:challenge_fd/core/config/preferences/preferences.dart';
import 'package:challenge_fd/modules/login/login_module.dart';
import 'package:challenge_fd/modules/screen/presenter/pages/screen_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => Preferences()),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) {
            return const ScreenPage();
          },
        ),
        ModuleRoute(
          '/login',
          module: LoginModule(),
        ),
      ];
}
