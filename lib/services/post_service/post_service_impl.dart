import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/models/post.dart';
import 'package:simple_nav_bar/services/post_service/post_service.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_nav_bar/dio_networking/dio_api_client.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:velocity_x/velocity_x.dart';

class PostServiceImpl implements PostService {
  final DioApiClient _dio = GetIt.I<DioApiClient>();

  @override
  Future<dynamic> addPost(Post post, BuildContext context) async {
    try {
      final response = await _dio.createDtaWitoutAuth("/api/ads/", {
        "categoryId": post.categoryId,
        "user_id": post.userId,
        "title": post.title,
        "description": post.description,
        "mediaUrls": post.mediaUrls,
        "price": post.price,
        "date": post.date,
        "subCategoryId": post.subCategoryId,
        "productCondition": post.productCondition,
        "characteristics": post.characteristics,
      });
      /* final data = Post.fromJson(response.data);
      print(data); */
      return response.data;
    } on DioException catch (e) {
      logger.severe('❌ Dio error addPost service: ${e.message}');
      if (e.type == DioExceptionType.badResponse) {
        final statusCode = e.response?.statusCode;
        final message = e.response?.data;

        if (statusCode == 500 && message.toString().contains("L'utilisateur")) {
          logger.warning("🚫 User does not have a subscription service");
          Get.snackbar(
            maxWidth: context.screenWidth - 60,
            duration: Duration(seconds: 15),
            "Échec",
            "Vous n'avez pas d'abonnement",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: frindlyErrorColor,
          );
        } else if (statusCode == 500 &&
            message.toString().contains("limite mensuelle")) {
          logger.warning("🚫 User does not have limite mensuelle service");
          Get.snackbar(
            maxWidth: context.screenWidth - 60,
            duration: Duration(seconds: 15),
            "Échec",
            "Vous avez atteint la limite mensuelle d'annonces actives",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: frindlyErrorColor,
          );
        } else if (statusCode == 500 &&
            message.toString().contains("limite d'annonces")) {
          logger.warning("🚫 User does not have limite d'annonces service");
          Get.snackbar(
            maxWidth: context.screenWidth - 60,
            duration: Duration(seconds: 15),
            "Échec",
            "Vous avez atteint la limite d'annonces actives",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: frindlyErrorColor,
          );
        } else {
          logger.severe("❌ Dio error addPost service 2: ${e.message}");
        }
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in addPost service: $e");
    }
  }

  @override
  Future<List<Post>> getAllMyPosts(int userId) async {
    try {
      final response = await _dio.readDataWithoutAuth(
        "/api/user/getAdsByUserId/$userId",
      );

      if (response.data != null && response.data["data"] != null) {
        final List<dynamic> data = response.data["data"];
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      // 👇 handle the "no posts" case gracefully
      if (e.response?.statusCode == 404 ||
          e.response!.data.toString().contains(
            "Pas d'annonces trouvées pour cet utilisateur",
          )) {
        logger.info("ℹ️ No posts found for this user");
        return [];
      }

      logger.severe("❌ Error in fetching posts service: $e");
      throw Exception("Failed to fetch posts due to DioException service");
    } catch (e) {
      logger.severe("❌ Unexpected error in getAllMyPosts service: $e");
      throw Exception("Failed to fetch posts service");
    }
  }

  @override
  Future<List<Post>> getFeaturedPosts() async {
    try {
      final response = await _dio.readDataWithoutAuth("/api/ads/featured");

      if (response.data != null) {
        final List<dynamic> data = response.data;

        // Convert JSON list → List<Post>
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        logger.severe("❌ Error in fetching featured posts service: $e");
      }
      throw Exception(
        "Failed to fetch featured posts due to DioException service",
      );
    } catch (e) {
      logger.severe("❌ Unexpected error in getFeaturedAdds service: $e");
      throw Exception("Failed to fetch featured posts service");
    }
  }

  @override
  Future<List<Post>> getTrendingPosts() async {
    try {
      final response = await _dio.readDataWithoutAuth(
        "/api/ads/trending",
        queryParameters: {"limit": 20},
      );

      if (response.data != null) {
        final List<dynamic> data = response.data;

        // Convert JSON list → List<Post>
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        logger.severe("❌ Error in fetching trending posts service: $e");
      }
      throw Exception(
        "Failed to fetch trending posts due to DioException service",
      );
    } catch (e) {
      logger.severe("❌ Unexpected error in getTrendingPosts service: $e");
      throw Exception("Failed to fetch trending posts service");
    }
  }

  @override
  Future<List<Post>> getSuggestedPosts({required int userId}) async {
    try {
      final response = await _dio.readDataWithoutAuth(
        "/api/user/for-you",
        queryParameters: {"userId": userId, "limit": 20},
      );

      if (response.data != null) {
        final List<dynamic> data = response.data;

        // Convert JSON list → List<Post>
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        logger.severe("❌ Error in fetching suggested posts service: $e");
      }
      throw Exception("Failed to fetch suggested posts due to DioException");
    } catch (e) {
      logger.severe("❌ Unexpected error in getSuggestedPosts service: $e");
      throw Exception("Failed to fetch suggested posts service");
    }
  }

  @override
  Future<List<Post>> getMyFavoritesPosts({required int userId}) async {
    try {
      final response = await _dio.readDataWithoutAuth(
        "/api/user/getAdsByLikedUserId/$userId",
      );
      if (response.data != null && response.data["data"] != null) {
        final List<dynamic> data = response.data["data"];

        // Convert JSON list → List<Post>
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        logger.severe("❌ Error in fetching my favorite posts service: $e");
      }
      throw Exception(
        "Failed to fetch my favorite posts due to DioException service",
      );
    } catch (e) {
      logger.severe("❌ Unexpected error in getMyFavoritesPosts service: $e");
      throw Exception("Failed to fetch my favorite posts service");
    }
  }

  Future<void> unlikePost({required int postId, required int userId}) async {
    try {
      final response = await _dio.deleteData(
        "/api/user/$userId/unlike/$postId",
      );
      logger.info("✅ ${response.data}");
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        logger.severe('❌ Dio error in unlikePost service: ${e.message}');
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in unlikePost service: $e");
    }
  }

  Future<void> likePost({required int postId, required int userId}) async {
    try {
      final response = await _dio.createDtaWitoutAuth(
        "/api/user/$userId/like/$postId",
        {},
      );
      logger.info("✅ ${response.data}");
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        logger.severe('❌ Dio error in likePost service: ${e.message}');
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in likePost service: $e");
    }
  }

  @override
  Future<List<Post>> getPostsByCategoryNameOrId({
    required int categoryId,
  }) async {
    try {
      final response = await _dio.readDataWithoutAuth(
        "/api/ads/category/$categoryId",
      );
      if (response.data != null && response.data["content"] != null) {
        final List<dynamic> data = response.data["content"];

        // Convert JSON list → List<Post>
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        logger.severe("❌ Error in fetching posts by category id service: $e");
      }
      throw Exception(
        "Failed to fetch posts by category id due to DioException service",
      );
    } catch (e) {
      logger.severe(
        "❌ Unexpected error in getPostsByCategoryNameOrId service: $e",
      );
      throw Exception("Failed to fetch posts by category id, service");
    }
  }

  @override
  Future<String?> viewPost({required int postId}) async {
    try {
      final response = await _dio.createDtaWitoutAuth(
        "/api/ads/$postId/view",
        {},
      );
      if (response.data != null) {
        return response.data;
      } else {
        return "";
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        logger.severe("❌ Error in viewing post by id service: $e");
      }
      throw Exception(
        "Failed to view a post by id due to DioException service",
      );
    } catch (e) {
      logger.severe("❌ Unexpected error in viewPost service: $e");
      throw Exception("Failed to view post by post id, service");
    }
  }

  @override
  Future<String?> reportPost({
    required int postId,
    required int userId,
    required String reason,
  }) async {
    try {
      final response = await _dio.createDtaWitoutAuth(
        "/api/ads/$postId/report",
        {"reporterId": userId, "reason": reason},
      );
      if (response.data != null) {
        print("%%%%%%%%%%%%%%%%%%%%%%%");
        print(response.data);
        return response.data;
      } else {
        return "";
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        logger.severe("❌ Error in reporting post by id service: $e");
      }
      throw Exception(
        "Failed to report a post by id due to DioException service",
      );
    } catch (e) {
      logger.severe("❌ Unexpected error in reportPost service: $e");
      throw Exception("Failed to report post by post id, service");
    }
  }
}
