import 'package:challenge_fd/core/config/routes.dart';
import 'package:challenge_fd/core/constants.dart';
import 'package:challenge_fd/core/spacing.dart';
import 'package:challenge_fd/modules/login/presenter/bloc/bloc.dart';
import 'package:challenge_fd/widgets/primary_button.dart';
import 'package:challenge_fd/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
    required this.loginBloc,
  });

  final LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginBloc,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(
            Spacing.md,
          ),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoadingState) {
                const CircularProgressIndicator();
              }
              if (state is LoginFailureState) {
                Fluttertoast.showToast(
                  msg: state.errorMessage,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  fontSize: 16.0,
                );
              }

              if (state is LoginSuccessState) {
                Modular.to.navigate(Routes.home);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Constants.text.loginTitle,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.orange,
                  ),
                ),
                VerticalSpace.md,
                PrimaryTextField(
                  title: Constants.text.nameTextField,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    loginBloc.add(
                      UpdateNameEvent(value),
                    );
                  },
                ),
                VerticalSpace.md,
                PrimaryTextField(
                  title: Constants.text.lastNameTextField,
                  oscureText: true,
                  onChanged: (value) {
                    loginBloc.add(
                      UpdateLastNameEvent(value),
                    );
                  },
                ),
                VerticalSpace.md,
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return PrimaryButton(
                      onPressed: state.model.canContinue
                          ? () => loginBloc.add(LoginSubmittedEvent())
                          : null,
                      title: Constants.text.loginButtonTitle,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
