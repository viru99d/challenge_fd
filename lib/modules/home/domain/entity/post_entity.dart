class PostEntity {
  final int? id;
  final String title;
  final String body;
  final int userId;

  const PostEntity({
    this.id,
    this.title = '',
    this.body = '',
    this.userId = 0,
  });

  factory PostEntity.empty() => const PostEntity(
        body: '',
        title: '',
        userId: 0,
      );

  PostEntity copyWith({
    int? id,
    String? title,
    String? body,
    int? userId,
  }) {
    return PostEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      userId: userId ?? this.userId,
    );
  }
}
