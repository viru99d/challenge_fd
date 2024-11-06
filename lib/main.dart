import 'package:challenge_fd/core/config/config.dart';
import 'package:challenge_fd/core/module.dart';
import 'package:challenge_fd/modules/login/presenter/bloc/bloc.dart';
import 'package:challenge_fd/modules/login/presenter/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  Config.init();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(
        loginBloc: Modular.get<LoginBloc>(),
      ),
    );
  }
}
