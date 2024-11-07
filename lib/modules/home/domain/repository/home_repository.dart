import 'package:challenge_fd/modules/home/data/models/post_model.dart';
import 'package:challenge_fd/modules/home/domain/entity/post_entity.dart';

abstract class HomeRepository {
  Future<List<PostEntity>> getPosts();
  Future<void> logOut();
  Future<void> savePost(PostModel postModel);
}
