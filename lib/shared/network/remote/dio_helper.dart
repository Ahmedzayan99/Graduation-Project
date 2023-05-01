import 'package:dio/dio.dart';

class DioHelper {
  // Create Object From Dio
  static late Dio dio;

  // Initial Value For Dio

  static init() {
    dio = Dio(
        // Here Base Url
        BaseOptions(
            // base Url For Online Groceries
            baseUrl: 'http://192.168.1.26:8000/api/',
            receiveDataWhenStatusError: true,
            // increase time connect
            connectTimeout: const Duration(seconds: 120).inMilliseconds,
            receiveTimeout: const Duration(seconds: 120).inMilliseconds,
            headers: {'Content-Type': 'application/json'}));

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: false,
      responseHeader: false,
      requestBody: true,
      request: true,
    ));
  }

  //Function For Get Data
  static Future<Response> getData(
      {
        required String url,
        Map<String, dynamic>? query,
        String lang = 'en',
        String? accessToken}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': lang,
      'Authorization': 'Bearer $accessToken'
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  // Function For Post Data
  static Future<Response> postData({
        required String url,
        Map<String, dynamic>? query,
        String lang = 'en',
        String? accessToken,
        required Map<String, dynamic> data}) async
         {
              dio.options.headers = {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Accept-Language': lang,
              'Authorization': 'Bearer $accessToken'
          };

    return await dio.post(url, queryParameters: query, data: data);
  }

  // Function For Post Data
  static Future<Response> postWithoutData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? accessToken,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': lang,
      'Authorization': 'Bearer $accessToken'
    };

    return await dio.post(
      url,
      queryParameters: query,
    );
  }

  // Function For Update User Data
  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? query,
      String lang = 'en',
      String? accessToken,
      required Map<String, dynamic> data}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': lang,
      'Authorization': 'Bearer $accessToken'
    };

    return await dio.put(url, queryParameters: query, data: data);
  }

  // Function For Update User Data (patch)
  static Future<Response> patchData(
      {required String url,
      Map<String, dynamic>? query,
      String lang = 'en',
      String? accessToken,
      required Map<String, dynamic> data}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': lang,
      'Authorization': 'Bearer $accessToken'
    };

    return await dio.patch(url, queryParameters: query, data: data);
  }
}
