class Constants {
  static final text = _Text();
  static final assets = _Assets();
}

class _Text {
  final String loginTitle = 'Iniciar Sesión';
  final String nameTextField = 'Nombre';
  final String lastNameTextField = 'Contraseña';
  final String loginButtonTitle = 'Iniciar Sesión';
  final String loginErrorMessage =
      'Datos incorrectos, por favor valida nuevamente.';
  final String homeToastErrorMessage = 'Ha ocurrido un error inésperado';
  final String homePageErrorMessage = 'No hay posts disponibles';
}

class _Assets {
  final String logo = 'assets/logo.svg';
}
