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
        final statusCode = e.response?.statusCode;
        final message = e.response?.data;

        if (statusCode == 500 && message.toString().contains("L'utilisateur")) {
          print("🚫 User does not have a subscription");
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
          print("🚫 User does not have a subscription");
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
          print("🚫 User does not have a subscription");
          Get.snackbar(
            maxWidth: context.screenWidth - 60,
            duration: Duration(seconds: 15),
            "Échec",
            "Vous avez atteint la limite d'annonces actives",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: frindlyErrorColor,
          );
        } else {
          print("❌ Dio error: ${e.message}");
        }
      }
    } catch (e) {
      print("❌ Unexpected error: $e");
    }
  }
}
