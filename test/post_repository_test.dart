// import 'package:flutter_test/flutter_test.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:network_caching/data/datasources/memory_data_source.dart';
// import 'package:network_caching/data/datasources/disk_data_source.dart';
// import 'package:network_caching/data/datasources/network_data_source.dart';
// import 'package:network_caching/data/repositories/post_repository.dart';
// import 'package:network_caching/domain/entities/post.dart';

// void main() {
//   sqfliteFfiInit();
//   databaseFactory = databaseFactoryFfi;
//   group('PostRepository', () {
//     late MemoryDataSource memory;
//     late DiskDataSource disk;
//     late NetworkDataSource network;
//     late PostRepository repo;

//     setUp(() {
//       memory = MemoryDataSource();
//       disk = DiskDataSource();
//       network = NetworkDataSource();
//       repo = PostRepository(memory: memory, disk: disk, network: network);
//     });

//     test('fetches from network and caches to disk and memory', () async {
//       final post = await repo.getPost(1);
//       expect(post, isNotNull);
//       expect(post!.id, 1);
//       expect(memory.getPost(1), isNotNull);
//       final diskPost = await disk.getPost(1);
//       expect(diskPost, isNotNull);
//     });

//     test('returns memory cache if fresh', () async {
//       final now = DateTime.now();
//       final cached = Post(
//         id: 2,
//         title: 'Cached',
//         body: 'Memory',
//         fetchedAt: now,
//       );
//       memory.savePost(cached);
//       final post = await repo.getPost(2);
//       expect(post, equals(cached));
//     });

//     test('returns disk cache if fresh and memory is empty', () async {
//       final now = DateTime.now();
//       final cached = Post(id: 3, title: 'Disk', body: 'Cache', fetchedAt: now);
//       await disk.savePost(cached);
//       final post = await repo.getPost(3);
//       expect(post, isNotNull);
//       expect(post!.id, 3);
//       expect(memory.getPost(3), isNotNull);
//     });

//     test('fetches from network if cache is stale', () async {
//       final old = DateTime.now().subtract(const Duration(hours: 1));
//       final stale = Post(id: 4, title: 'Stale', body: 'Old', fetchedAt: old);
//       memory.savePost(stale);
//       await disk.savePost(stale);
//       final post = await repo.getPost(4);
//       expect(post, isNotNull);
//       expect(post!.id, 4);
//       expect(post.title, isNot('Stale'));
//     });
//   });
// }
