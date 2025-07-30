import '../../domain/entities/post.dart';
import '../models/post_model.dart';

class PostMapper {
  static Post toEntity(PostModel model) {
    return Post(
      id: model.id,
      title: model.title,
      body: model.body,
      fetchedAt: DateTime.tryParse(model.fetchedAt ?? '') ?? DateTime.now(),
    );
  }

  static PostModel toModel(Post entity) {
    return PostModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      fetchedAt: entity.fetchedAt.toIso8601String(),
    );
  }

  static PostModel fromDb(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as int,
      title: (map['title'] ?? '') as String,
      body: (map['body'] ?? '') as String,
      fetchedAt: map['fetchedAt'] as String? ?? '',
    );
  }
}
