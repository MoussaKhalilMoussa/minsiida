import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/models/post.dart';
import 'package:simple_nav_bar/services/post_service/post_service.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_nav_bar/dio_networking/dio_api_client.dart';
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
      print('❌ Dio error: ${e.message}');
      if (e.type == DioExceptionType.badResponse) {
        Get.snackbar(
          maxWidth: context.screenWidth - 60,
          duration: Duration(seconds: 3),
          "Échec de la connexion",
          "Identifiants invalides",
          snackPosition: SnackPosition.BOTTOM,
          backgroundGradient: LinearGradient(
            colors: [redColor, redColor.withBrightness],
          ),
        );
        throw Exception("Identifiants invalides");
      }
      throw Exception("Erreur lors de l'ajout du post: ${e.message}");
    } catch (e) {
      print("❌ Unexpected error: $e");
      Get.snackbar(
        maxWidth: context.screenWidth - 60,
        duration: Duration(seconds: 3),
        "Échec de la connexion",
        "Une erreur inattendue s'est produite.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: LinearGradient(
          colors: [redColor, redColor.withBrightness],
        ),
      );
      throw Exception("Une erreur inattendue s'est produite.");
    }
  }
}
