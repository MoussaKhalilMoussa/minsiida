import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/strings.dart';
import 'package:simple_nav_bar/dio_networking/dio_api_client.dart';
import 'package:simple_nav_bar/services/auth_service/auth_service.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';
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
      final response = await _dio.createDtaWitoutAuth("/api/auth/login", {
        "username": userName,
        "password": password,
      });

      // Ensure we got a token
      final token = response.data?['token'];
      if (token == null || token.toString().isEmpty) {
        logger.info("No token returned from server");
        return "";
      }
      return token.toString();
    } on DioException catch (e) {
      logger.severe('❌ Dio error: ${e.message}');
      if (e.type == DioExceptionType.badResponse) {
        Get.snackbar(
          maxWidth: context.screenWidth - 60,
          duration: Duration(seconds: 5),
          "Échec de la connexion",
          "Identifiants invalides",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: frindlyErrorColor,
        );

        return "";
      }
    } catch (e) {
      logger.severe("❌ Unexpected error: $e");

      Get.snackbar(
        maxWidth: context.screenWidth - 60,
        duration: Duration(seconds: 5),
        "Échec de la connexion",
        "Une erreur inattendue s'est produite.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: frindlyErrorColor,
      );
      return "";
    }
    // Ensure a return statement at the end
    return "";
  }

  @override
  Future<String> registerUser({
    required String name,
    required String userName,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final responce = await _dio.createDtaWitoutAuth("/api/auth/register", {
        "name": name,
        "username": userName,
        "email": email,
        "password": password,
      });
      return responce.data;
    } on DioException catch (e) {
      logger.severe('❌ Dio error: ${e.message}');

      Get.snackbar(
        maxWidth: context.screenWidth - 50,
        duration: Duration(seconds: 3),
        "chec de l'inscription",
        e.response?.data.toString() ?? e.message ?? "Erreur inconnue",
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: LinearGradient(
          colors: [redColor, redColor.withBrightness],
        ),
      );

      return "";
    } catch (e) {
      logger.severe("❌ Unexpected error: $e");
      VxToast.show(
        context,
        msg: "Une erreur inattendue s'est produite.",
        bgColor: redColor,
      );
      return "";
    }
  }

  @override
  Future<String> otpVerification({
    required String otpCode,
    required BuildContext context,
  }) async {
    try {
      final response = await _dio.createDtaWitoutAuth(
        "/api/auth/verify",
        {},
        queryParameters: {"code": otpCode},
      );
      return response.data.toString();
    } on DioException catch (e) {
      logger.severe('❌ Dio error: ${e.message}');
      Get.snackbar(
        maxWidth: context.screenWidth - 50,
        duration: Duration(seconds: 3),
        error,
        e.response?.data.toString() ?? e.message ?? "Erreur inconnue",
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: LinearGradient(
          colors: [redColor, redColor.withBrightness],
        ),
      );
      return "";
    } catch (e) {
      logger.severe("❌ Unexpected error: $e");
      VxToast.show(
        context,
        msg: "Une erreur inattendue s'est produite.",
        bgColor: redColor,
      );
      return "";
    }
  }

  @override
  Future<dynamic> profile() async {
    try {
      final response = await _dio.readData("/api/auth/profile");
      var profile = UserProfile.fromJson(response.data);
      return profile;
    } on DioException catch (e) {
      logger.severe('❌ Dio error: ${e.message}');
    } catch (e) {
      logger.severe("❌ Unexpected profile service impl error: $e");
    }
  }

  @override
  Future resetByEmail({
    required String email,
    required BuildContext context,
  }) async {
    try {
      final response = await _dio.createDtaWitoutAuth(
        "/api/auth/reset-request",
        {},
        queryParameters: {"email": email},
      );
      return response.data.toString();
    } on DioException catch (e) {
      logger.severe('❌ Dio error: ${e.message}');
      Get.snackbar(
        maxWidth: context.screenWidth - 50,
        duration: Duration(seconds: 3),
        error,
        e.response?.data.toString() ?? e.message ?? "Erreur inconnue",
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: LinearGradient(
          colors: [redColor, redColor.withBrightness],
        ),
      );
      return "";
    } catch (e) {
      logger.severe("❌ Unexpected error: $e");
      VxToast.show(
        context,
        msg: "Une erreur inattendue s'est produite.",
        bgColor: redColor,
      );
      return "";
    }
  }
}
