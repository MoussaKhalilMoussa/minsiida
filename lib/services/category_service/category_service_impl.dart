import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_nav_bar/dio_networking/dio_api_client.dart';
import 'package:simple_nav_bar/services/category_service/category_service.dart';
import 'package:simple_nav_bar/view/categories/models/category.dart';

class CategoryServiceImpl extends CategoryService {
  final DioApiClient _dio = GetIt.I<DioApiClient>();

  @override
  Future<List<Category>> getAllCategories() async {
    try {
      final response = await _dio.readDataWithoutAuth("/api/categories/");
      var data = response.data;
      var categories = data.map<Category>((d) => Category.fromJson(d)).toList();
      return categories;
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return [];
    } catch (e) {
      print("❌ Unexpected categories error: $e");
      return [];
    }
  }
}
