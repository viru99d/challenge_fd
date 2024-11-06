import 'package:challenge_fd/core/config/preferences/preferences.dart';
import 'package:challenge_fd/modules/login/login_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => Preferences()),
  ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/login',
          module: LoginModule(),
        ),
      ];
}
