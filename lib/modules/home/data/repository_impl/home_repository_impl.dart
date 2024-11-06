import 'package:challenge_fd/modules/home/data/models/post_model.dart';
import 'package:challenge_fd/modules/home/domain/repository/home_repository.dart';
import 'package:dio/dio.dart';

class HomeRepositoryImpl implements HomeRepository {
  final Dio dio;

  HomeRepositoryImpl(this.dio);

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await dio.get('/posts');
    final List data = response.data;
    return data.map((e) => PostModel.fromJson(e)).toList();
  }
}
