import 'package:challenge_fd/modules/login/domain/entity/user_entity.dart';
import 'package:challenge_fd/modules/login/domain/repository/login_repository.dart';
import 'package:challenge_fd/modules/login/domain/use_cases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late MockLoginRepository mockRepository;
  late LoginUseCase loginUseCase;

  setUp(() {
    mockRepository = MockLoginRepository();
    loginUseCase = LoginUseCase(mockRepository);
  });

  group('LoginUseCase', () {
    test('should call repository.login with correct UserEntity', () async {
      final user = UserEntity(email: 'test@example.com', password: 'password');
      const response = (true, '');

      when(() => mockRepository.login(user)).thenAnswer((_) async => response);

      final result = await loginUseCase.call(user);

      expect(result, response);
      verify(() => mockRepository.login(user)).called(1);
    });

    test('should handle repository errors gracefully', () async {
      final user = UserEntity(email: 'test@example.com', password: 'password');

      when(() => mockRepository.login(user)).thenThrow(Exception());

      expect(() async => await loginUseCase.call(user), throwsException);
      verify(() => mockRepository.login(user)).called(1);
    });
  });
}
