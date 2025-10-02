import 'package:flutter/material.dart';
import 'package:simple_nav_bar/models/post.dart';

abstract class PostService {
  Future<dynamic> addPost(Post post, BuildContext context);

  Future<List<Post>> getAllPost(int userId);
}
