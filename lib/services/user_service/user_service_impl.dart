import 'package:dio/dio.dart';
import 'package:simple_nav_bar/dio_networking/dio_api_client.dart';
import 'package:simple_nav_bar/services/user_service/user_service.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';

class UserServiceImpl implements UserService {
  final DioApiClient _dio = GetIt.I<DioApiClient>();

  @override
  Future<UserProfile> getUser({required int userId}) async {
    try {
      final response = await _dio.readData("/api/user/$userId");
      var user = UserProfile.fromJson(response.data['data']);
      return user;
    } on DioException catch (e) {
      logger.severe('❌ Dio error: ${e.message}');
    } catch (e) {
      logger.severe("❌ Unexpected error in get user service impl error: $e");
    }
    throw Exception('Failed to fetch user');
  }

  @override
  Future<UserProfile?> updateProfile({
    required UserProfile newUserProfile,
    required int userId,
  }) async {
    try {
      var response = await _dio.updateData(
        "/api/user/$userId",
        newUserProfile.toJson(), // Correct way to convert UserProfile to Map<String, dynamic>
      );
      print("=============&&&&&&&&&&&&================");
      print(response.data);
      return UserProfile.fromJson(response.data['data']); // Use response.data['data'] for consistency
    } on DioException catch (e) {
      logger.severe('❌ Dio error in update profile service: ${e.message}');
    } catch (e) {
      logger.severe("❌ Unexpected in update profile service impl error: $e");
    }
    return null;
  }
}
