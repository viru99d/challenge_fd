import 'package:challenge_fd/core/config/routes.dart';
import 'package:challenge_fd/core/constants.dart';
import 'package:challenge_fd/modules/screen/presenter/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScreenPage extends StatelessWidget {
  const ScreenPage({
    super.key,
    required this.screenBloc,
  });

  final ScreenBloc screenBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => screenBloc..add(CheckAuthentication()),
      child: BlocListener<ScreenBloc, ScreenState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {}
          if (state is UnauthenticatedState) {
            Modular.to.navigate(Routes.login);
          }
        },
        child: Scaffold(
          body: Center(
            child: SvgPicture.asset(
              Constants.assets.logo,
            ),
          ),
        ),
      ),
    );
  }
}
