import 'package:challenge_fd/modules/home/domain/repository/home_repository.dart';

class LogOutUseCase {
  final HomeRepository repository;

  LogOutUseCase(this.repository);

  Future<void> call() async {
    return await repository.logOut();
  }
}
