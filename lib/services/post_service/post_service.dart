import 'package:flutter/material.dart';
import 'package:simple_nav_bar/models/post.dart';

abstract class PostService {
  Future<dynamic> addPost(Post post, BuildContext context);

  Future<List<Post>> getAllMyPosts(int userId);

  Future<List<Post>> getFeaturedPosts();

  Future<List<Post>> getTrendingPosts();

  Future<List<Post>> getSuggestedPosts({required int userId});

  Future<List<Post>> getMyFavoritesPosts({required int userId});

  Future<List<Post>> getPostsByCategoryNameOrId({required int categoryId});

  Future<String?> viewPost({required int postId});

  Future<String?> reportPost({
    required int postId,
    required int userId,
    required String reason,
  });
}
