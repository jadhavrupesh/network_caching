import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../data/datasources/memory_data_source.dart';
import '../data/datasources/disk_data_source.dart';
import '../data/datasources/network_data_source.dart';
import '../data/repositories/post_repository_impl.dart';
import '../domain/usecases/get_post_use_case.dart';
import '../domain/usecases/get_all_posts_use_case.dart';
import 'bloc/post_bloc.dart';
import 'bloc/post_event.dart';
import 'bloc/post_state.dart';
import 'post_details_page.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postRepository = PostRepositoryImpl(
      memory: MemoryDataSource(),
      disk: DiskDataSource(),
      network: NetworkDataSource(),
    );
    final getPostUseCase = GetPostUseCase(postRepository);
    final getAllPostsUseCase = GetAllPostsUseCase(postRepository);
    return BlocProvider(
      create: (_) => PostBloc(
        getPostUseCase: getPostUseCase,
        getAllPostsUseCase: getAllPostsUseCase,
      )..add(FetchAllPostsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: Center(
          child: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostLoading) {
                return const CircularProgressIndicator();
              } else if (state is PostsLoaded) {
                final posts = state.posts;
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: AppColors.primaryPale,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PostDetailsPage(post: post),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post.title, style: AppTextStyles.h2),
                              const SizedBox(height: 8),
                              Text(post.body, style: AppTextStyles.body2),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is PostError) {
                return Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: Card(
                      color: AppColors.primaryPale,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 32,
                          horizontal: 24,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.wifi_off,
                              size: 48,
                              color: AppColors.primary,
                            ),
                            const SizedBox(height: 18),
                            Text(
                              'No Internet Connection',
                              style: AppTextStyles.h2,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              state.message,
                              style: AppTextStyles.body2,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.backgroundSupport,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                textStyle: AppTextStyles.h2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                context.read<PostBloc>().add(
                                  FetchAllPostsEvent(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
