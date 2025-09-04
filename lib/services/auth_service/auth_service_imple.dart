import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/dio_networking/dio_api_client.dart';
import 'package:simple_nav_bar/services/auth_service/auth_service.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthServiceImple implements AuthService {
  final DioApiClient _dio = GetIt.I<DioApiClient>();

  @override
  Future<String> userLogin({
    required String userName,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final response = await _dio.createData("/api/auth/login", {
        "username": userName,
        "password": password,
      });

      // Ensure we got a token
      final token = response.data?['token'];
      if (token == null || token.toString().isEmpty) {
        VxToast.show(
          context,
          msg: "No token returned from server",
          bgColor: redColor,
        );
        return "";
      }
      return token.toString();
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');

      Get.snackbar(
        maxWidth: context.screenWidth - 50,
        duration: Duration(seconds: 3),
        "Login Failed",
        e.response?.data.toString() ?? e.message ?? "Unknown error",
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: LinearGradient(
          colors: [redColor, redColor.withBrightness],
        ),
      );

      return "";
    } catch (e) {
      print("❌ Unexpected error: $e");
      VxToast.show(
        context,
        msg: "Unexpected error occurred",
        bgColor: redColor,
      );
      return "";
    }
  }
}
