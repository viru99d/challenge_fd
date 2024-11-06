import 'package:challenge_fd/modules/screen/domain/repository/screen_repository.dart';

class CheckAuthenticationUseCase {
  final ScreenRepository screenRepository;

  CheckAuthenticationUseCase(this.screenRepository);

  Future<bool> call() async {
    return await screenRepository.isAuthenticated();
  }
}
