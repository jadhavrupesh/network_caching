import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class PostDetailsPage extends StatelessWidget {
  final dynamic post;
  const PostDetailsPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title, style: AppTextStyles.h2),
            const SizedBox(height: 16),
            Text(post.body, style: AppTextStyles.body1),
            const SizedBox(height: 24),
            Row(
              children: [
                const Icon(Icons.tag, size: 16, color: AppColors.neutralDarkGray),
                const SizedBox(width: 8),
                Text('ID: ${post.id}', style: AppTextStyles.body2),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: AppColors.neutralDarkGray),
                const SizedBox(width: 8),
                Text('Fetched: ${post.fetchedAt}', style: AppTextStyles.body2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
