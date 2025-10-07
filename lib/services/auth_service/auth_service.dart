import 'package:flutter/material.dart';


abstract class AuthService {
  Future<dynamic> userLogin({
    required String userName,
    required String password,
    required BuildContext context,
  });

  Future<dynamic> registerUser({
    required String name,
    required String userName,
    required String email,
    required String password,
    required BuildContext context,
  });

  Future<dynamic> otpVerification({
    required String otpCode,
    required BuildContext context,
  });

  Future<dynamic> loggedInUserProfile();

  Future<dynamic> resetByEmail({
    required String email,
    required BuildContext context,
  });

}
