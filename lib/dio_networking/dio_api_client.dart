import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:simple_nav_bar/constants/strings.dart';

final getIt = GetIt.instance;

class DioApiClient {
  final Dio dio;
  final CancelToken cancelToken = CancelToken();
  final storage = GetStorage();
  factory DioApiClient() => DioApiClient._internal();

  DioApiClient._internal()
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
          headers: {},
          responseType: ResponseType.json,
          contentType: 'application/json',
          validateStatus: (status) {
            return status != null && status >= 200 && status < 400;
          },
          requestEncoder: (request, options) {
            return utf8.encode(request.toString());
          },
          responseDecoder: (responseBytes, options, responseBody) {
            return utf8.decode(responseBytes);
          },
          listFormat: ListFormat.multi,
        ),
      ) {
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('Response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          print('Error: ${error.message}');
          if (error.response?.statusCode == 401) {
            print('Token expired');
          }
          return handler.next(error);
        },
      ),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
      ),
    ]);
  }

  static void setup() {
    getIt.registerLazySingleton(() => DioApiClient._internal());
  }

  // POST - Create
  Future<Response> createData(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic> authorization = getAuthorizationHeader();

    requestOptions.headers!.addAll(authorization);

    try {
      final response = await dio.post(
        endpoint,
        data: jsonEncode(data),
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        options: requestOptions,
      );
      return response;
    } catch (e) {
      print('Error creating data: $e');
      rethrow;
    }
  }

  Future<Response> createDtaWitoutAuth(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: jsonEncode(data),
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      print('Error creating data: $e');
      rethrow;
    }
  }

  Map<String, dynamic> getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    String accessToken = storage.read(authToken);
    if (accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  // GET - Read
  Future<Response> readData(String endpoint, {Options? options}) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic> authorization = getAuthorizationHeader();

    requestOptions.headers!.addAll(authorization);
    try {
      final response = await dio.get(
        endpoint,
        cancelToken: cancelToken,
        options: requestOptions,
      );
      return response;
    } catch (e) {
      print('Error reading data: $e');
      rethrow;
    }
  }

  // PUT - Update
  Future<Response> updateData(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await dio.put(
        endpoint,
        data: jsonEncode(data),
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      print('Error updating data: $e');
      rethrow;
    }
  }

  // DELETE - Delete
  Future<Response> deleteData(String endpoint) async {
    try {
      final response = await dio.delete(endpoint, cancelToken: cancelToken);
      return response;
    } catch (e) {
      print('Error deleting data: $e');
      rethrow;
    }
  }

  // File uploading
  Future<Response> uploadFile(String endpoint, String filePath) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        filePath,
        filename: filePath.split('/').last,
      ),
    });
    try {
      final response = await dio.post(
        endpoint,
        data: formData,
        cancelToken: cancelToken,
        options: Options(contentType: 'multipart/form-data'),
      );
      return response;
    } catch (e) {
      print('Error uploading file: $e');
      rethrow;
    }
  }

  // File downloading
  Future<void> downloadFile(String endpoint, String savePath) async {
    try {
      await dio.download(
        endpoint,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print('Progress: ${(received / total * 100).toStringAsFixed(0)}%');
          }
        },
      );
      print('File downloaded to: $savePath');
    } catch (e) {
      print('Error downloading file: $e');
      rethrow;
    }
  }
}
