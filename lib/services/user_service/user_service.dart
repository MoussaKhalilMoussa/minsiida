import 'package:simple_nav_bar/view/profile/model/user_profile.dart';

abstract class UserService {
  Future<dynamic> getUser({required int userId});
  Future<UserProfile?> updateProfile({
    required UserProfile newUserProfile,
    required int userId,
  });
}
