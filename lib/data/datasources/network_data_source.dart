import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../models/post_model.dart';
import 'package:dartz/dartz.dart';
import '../../core/network/failure.dart';

class NetworkDataSource {
  final Dio _dio;

  NetworkDataSource([Dio? dio])
    : _dio = dio ?? Dio()
        ..interceptors.addAll([
          PrettyDioLogger(
            requestBody: true,
            requestHeader: true,
            enabled: true,
          ),
        ]);

  Future<Either<Failure, List<PostModel>>> fetchAllPosts() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/posts',
        options: Options(
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data is List) {
        final posts = (response.data as List)
            .map((json) => PostModel.fromJson(json))
            .toList();
        return Right(posts);
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } catch (e) {
      if (e is DioException) {
        String msg;
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            msg =
                'Connection timed out. Please check your internet connection.';
            break;
          case DioExceptionType.badResponse:
            msg = 'Received invalid response from server.';
            break;
          case DioExceptionType.cancel:
            msg = 'Request was cancelled.';
            break;
          case DioExceptionType.connectionError:
            msg = 'No internet connection. Please check your network.';
            break;
          case DioExceptionType.unknown:
          default:
            msg = 'Network error occurred. Please try again.';
        }
        return Left(NetworkFailure(msg));
      }
      return Left(NetworkFailure('Network error occurred. Please try again.'));
    }
  }

  Future<Either<Failure, PostModel>> fetchPost(int id) async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/posts/$id',
        options: Options(
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data != null) {
        return Right(PostModel.fromJson(response.data));
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
