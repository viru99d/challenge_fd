import 'package:challenge_fd/core/config/preferences/preferences.dart';
import 'package:challenge_fd/modules/home/home_module.dart';
import 'package:challenge_fd/modules/login/login_module.dart';
import 'package:challenge_fd/modules/screen/screen_module.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => Preferences()),
    Bind.lazySingleton(
      (i) => Dio(
        BaseOptions(
          baseUrl: 'https://jsonplaceholder.typicode.com',
          connectTimeout: const Duration(seconds: 2),
          receiveTimeout: const Duration(seconds: 3),
        ),
      ),
    ),
  ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          Modular.initialRoute,
          module: ScreenModule(),
        ),
        ModuleRoute(
          '/login',
          module: LoginModule(),
        ),
        ModuleRoute(
          '/home',
          module: HomeModule(),
        ),
      ];
}
