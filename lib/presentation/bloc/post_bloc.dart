import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_post_use_case.dart';
import '../../domain/usecases/get_all_posts_use_case.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostUseCase getPostUseCase;
  final GetAllPostsUseCase getAllPostsUseCase;

  PostBloc({required this.getPostUseCase, required this.getAllPostsUseCase})
    : super(PostInitial()) {
    on<FetchPostEvent>(_onFetchPost);
    on<FetchAllPostsEvent>(_onFetchAllPosts);
    add(FetchAllPostsEvent());
  }

  Future<void> _onFetchPost(
    FetchPostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());
    final result = await getPostUseCase(event.postId);
    result.fold(
      (failure) => emit(PostError(failure.message)),
      (post) => emit(PostLoaded(post)),
    );
  }

  Future<void> _onFetchAllPosts(
    FetchAllPostsEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());
    final result = await getAllPostsUseCase();
    result.fold(
      (failure) => emit(PostError(failure.message)),
      (posts) => emit(PostsLoaded(posts)),
    );
  }
}
