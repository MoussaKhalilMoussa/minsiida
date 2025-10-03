import 'package:dio/dio.dart';
import 'package:simple_nav_bar/dio_networking/dio_api_client.dart';
import 'package:simple_nav_bar/services/user_service/user_service.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';

class UserServiceImpl implements UserService{

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
      logger.severe("❌ Unexpected user service impl error: $e");
    }
    throw Exception('Failed to fetch user');
  }
  
}