import 'package:dartz/dartz.dart';
import '../../core/network/failure.dart';
import '../entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, Post>> getPost(int id);
  Future<Either<Failure, List<Post>>> getAllPosts();
}
