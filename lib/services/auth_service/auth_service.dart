import 'package:flutter/material.dart';

abstract class AuthService {
  Future<dynamic> userLogin({
    required String userName,
    required String password,
    required BuildContext context,
  });
}
