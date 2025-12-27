import 'package:dio/dio.dart';
import 'package:chat_app/data/network/dio/network_interceptor.dart';
import 'package:chat_app/data/network/utils/api_end_points.dart';
import 'package:chat_app/view/utils/const/app_constants.dart';
class ApiClient {
  final Dio _dio;

  ApiClient()
      : _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 40),
      receiveTimeout: const Duration(seconds: 40),
    ),
  ) {
    _dio.interceptors.add(networkInterceptor(_dio));
  }


  /// Set headers and header Authorization
  Future<Map<String, dynamic>> getHeader({bool isTokenRequiredInHeader = false}) async{
    Map<String, dynamic> headers = {
      AppConstants.accept: AppConstants.headerAccept,
      AppConstants.contentType: AppConstants.headerContentType,
    };
    if (isTokenRequiredInHeader) {
      ///Authorization Header
      final accessToken = '';
      if (accessToken!= null) {
        headers.addAll(
            {'Authorization': 'Bearer $accessToken}'},
        );
      }
    }
    return headers;
  }

  /*
  * ----GET Request
  * */
  Future<dynamic> getRequest(String endPoint) async {
    try {
      _dio.options.headers = await getHeader();
      return await _dio.get(endPoint);
    } catch (e) {
      rethrow;
    }
  }

  /*
  * ----POST Request
  * */
  Future<dynamic> postRequest(String endPoint, String? requestBody) async {
    try {
      _dio.options.headers = await getHeader();
      return await _dio.post(endPoint, data: requestBody);
    } catch (e) {
      rethrow;
    }
  }


}