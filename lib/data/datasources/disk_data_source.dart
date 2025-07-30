import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/entities/post.dart';
import '../mappers/post_mapper.dart';

class DiskDataSource {
  Future<List<Post>> getAllPosts() async {
    if (_db == null) await init();
    final maps = await _db!.query(_tableName);
    return maps.map((m) => PostMapper.toEntity(PostMapper.fromDb(m))).toList();
  }

  static const String _tableName = 'posts';
  Database? _db;

  Future<void> init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'posts.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY,
            title TEXT,
            body TEXT,
            fetchedAt TEXT
          )
        ''');
      },
    );
  }

  Future<Post?> getPost(int id) async {
    if (_db == null) await init();
    final maps = await _db!.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return PostMapper.toEntity(PostMapper.fromDb(maps.first));
    }
    return null;
  }

  Future<void> savePost(Post post) async {
    if (_db == null) await init();
    await _db!.insert(
      _tableName,
      PostMapper.toModel(post).toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
