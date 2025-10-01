import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:simple_nav_bar/constants/strings.dart';

class TokenUtils {
  static final _storage = GetStorage();

  /// Save token in storage
  static Future<void> saveToken(String token) async {
    await _storage.write(authToken, token);
  }

  /// Read token from storage
  static String? getToken() {
    return _storage.read<String>(authToken);
  }

  /// Decode token payload using jwt_decoder
  static Map<String, dynamic>? decodeToken() {
    final token = getToken();
    if (token == null || JwtDecoder.isExpired(token)) return null;

    return JwtDecoder.decode(token);
  }

  /// Extract user from decoded payload and save it to storage
  static Future<Map<String, dynamic>?> extractAndSaveUser() async {
    final payload = decodeToken();
    if (payload == null) return null;

    // If user is stored under "user"
    final user = payload['user'] ??
        payload; // fallback: store full payload if no "user" key

    await _storage.write('user', user);
    return user is Map<String, dynamic> ? user : null;
  }

  /// Retrieve saved user
  static Map<String, dynamic>? getUser() {
    return _storage.read('user');
  }

  /// Clear storage (logout)
  static Future<void> clear() async {
    await _storage.erase();
  }
}
