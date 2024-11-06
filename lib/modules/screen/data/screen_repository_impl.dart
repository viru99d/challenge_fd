import 'package:challenge_fd/core/config/preferences/preferences.dart';
import 'package:challenge_fd/modules/screen/domain/repository/screen_repository.dart';

class ScreenRepositoryImpl implements ScreenRepository {
  ScreenRepositoryImpl(this.preferences);

  final Preferences preferences;

  @override
  Future<bool> isAuthenticated() async {
    return preferences.isAuthenticated;
  }
}
