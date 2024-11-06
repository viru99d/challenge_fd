import 'package:challenge_fd/modules/home/domain/entity/post_entity.dart';

abstract class HomeRepository {
  Future<List<PostEntity>> getPosts();
}
