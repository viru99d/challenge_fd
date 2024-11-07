import 'package:challenge_fd/modules/home/domain/entity/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({
    super.id,
    required super.title,
    required super.body,
    required super.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      userId: json['userId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'title': title,
      'body': body,
      'userId': userId,
      if (id != null) 'id': id,
    };
    return data;
  }
}
