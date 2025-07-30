import '../../domain/entities/post.dart';

class MemoryDataSource {
  List<Post> getAllPosts() => _cache.values.toList();
  final Map<int, Post> _cache = {};

  Post? getPost(int id) => _cache[id];

  void savePost(Post post) {
    _cache[post.id] = post;
  }

  void clear() {
    _cache.clear();
  }
}
