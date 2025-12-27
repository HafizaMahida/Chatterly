import 'package:dio/dio.dart';
import 'package:chat_app/data/network/dio/common_error_model.dart';
import 'package:chat_app/view/utils/const/app_constants.dart';
import 'dart:convert';

import 'package:chat_app/view/utils/widgets/common_dialogs.dart';
InterceptorsWrapper networkInterceptor(Dio client) {
  CancelToken cancelToken = CancelToken();

  return InterceptorsWrapper(
    onRequest: (request, handler) async {
      AppConstants.constant.showLog('Request path: ${request.path}');
      AppConstants.constant.showLog('Request: ${request.data.toString()}');
      request.cancelToken = cancelToken;
      handler.next(request);
    },

    onResponse: (response, handler) {
      AppConstants.constant.showLog('Response path: ${response.realUri.path}');
      AppConstants.constant.showLog('Response:${response.toString()}');
      handler.next(response);
    },

    onError: (error, handler) async {
    final response = error.response;
    AppConstants.constant.showLog('Error response: ${error.response}');

    try {
      if (response == null) {
        showErrorDialog(
          error.type == DioExceptionType.connectionError
              ? 'Connectivity issue. Check your network!'
              : error.type == DioExceptionType.connectionTimeout
              ? 'Connection Timeout!'
              : 'Network error occurred',
          dismissible: true,
        );
        handler.reject(error);
        return;
      }

      /// Parse common error model
      CommonErrorModel commonModel = CommonErrorModel.fromJson(jsonDecode(response.toString()));

      final statusCode = commonModel.statusCode;

      /// -------------------------------
      ///      OTHER STATUSES
      /// -------------------------------
      showErrorDialog(commonModel.message ?? commonModel.messages?.join(", ") ?? "Unexpected error", dismissible: true,);
      handler.reject(error);
      return;
    } catch (e) {
      showErrorDialog("Something went wrong: $e", dismissible: true);
      handler.reject(
        DioException(
          requestOptions: response?.requestOptions ?? error.requestOptions,
          response: response,
        ),
      );
    }
  },
  );
}
