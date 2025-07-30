import 'package:dartz/dartz.dart';
import '../../core/network/failure.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/memory_data_source.dart';
import '../datasources/disk_data_source.dart';
import '../datasources/network_data_source.dart';
import '../mappers/post_mapper.dart';

class PostRepositoryImpl implements PostRepository {
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    // 1. Try memory
    final memPosts = memory.getAllPosts();
    if (memPosts.isNotEmpty && memPosts.every((p) => p.isUpToDate())) {
      return Right(memPosts);
    }

    // 2. Try disk
    final diskPosts = await disk.getAllPosts();
    if (diskPosts.isNotEmpty && diskPosts.every((p) => p.isUpToDate())) {
      diskPosts.forEach(memory.savePost);
      return Right(diskPosts);
    }

    // 3. Try network
    final netResult = await network.fetchAllPosts();
    return netResult.fold((failure) => Left(failure), (netPosts) {
      for (final postModel in netPosts) {
        final entity = PostMapper.toEntity(postModel);
        disk.savePost(entity);
        memory.savePost(entity);
      }
      final posts = netPosts.map(PostMapper.toEntity).toList();
      return Right(posts);
    });
  }

  final MemoryDataSource memory;
  final DiskDataSource disk;
  final NetworkDataSource network;

  PostRepositoryImpl({
    required this.memory,
    required this.disk,
    required this.network,
  });

  @override
  Future<Either<Failure, Post>> getPost(int id) async {
    // 1. Try memory
    final memPost = memory.getPost(id);
    if (memPost != null && memPost.isUpToDate()) {
      return Right(memPost);
    }

    // 2. Try disk
    final diskPost = await disk.getPost(id);
    if (diskPost != null && diskPost.isUpToDate()) {
      memory.savePost(diskPost);
      return Right(diskPost);
    }

    // 3. Try network
    final netResult = await network.fetchPost(id);
    return netResult.fold((failure) => Left(failure), (netPostModel) async {
      final entity = PostMapper.toEntity(netPostModel);
      await disk.savePost(entity);
      memory.savePost(entity);
      return Right(entity);
    });
  }
}
