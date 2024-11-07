import 'package:challenge_fd/modules/home/data/models/post_model.dart';
import 'package:challenge_fd/modules/home/domain/repository/home_repository.dart';

class SavePostUseCase {
  final HomeRepository repository;

  SavePostUseCase(this.repository);

  Future<void> call(PostModel postModel) async {
    return await repository.savePost(postModel);
  }
}
