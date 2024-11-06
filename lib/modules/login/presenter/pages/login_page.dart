import 'package:challenge_fd/core/constants.dart';
import 'package:challenge_fd/core/spacing.dart';
import 'package:challenge_fd/modules/login/presenter/bloc/bloc.dart';
import 'package:challenge_fd/modules/login/presenter/pages/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Constants.text.loginTitle,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                VerticalSpace.md,
                LoginTextField(
                  title: Constants.text.nameTextField,
                  onChanged: (value) {
                    loginBloc.add(
                      UpdateNameEvent(value),
                    );
                  },
                ),
                VerticalSpace.md,
                LoginTextField(
                  title: Constants.text.lastNameTextField,
                  onChanged: (value) {
                    loginBloc.add(
                      UpdateLastNameEvent(value),
                    );
                  },
                ),
                VerticalSpace.md,
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.model.canContinue
                            ? () => loginBloc.add(LoginSubmittedEvent())
                            : null,
                        child: Text(Constants.text.loginButtonTitle),
                      ),
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
