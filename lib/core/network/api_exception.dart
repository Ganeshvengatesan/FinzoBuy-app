import 'package:dio/dio.dart';
import '../constants/app_strings.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  factory ApiException.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        return ApiException(message: "Request to API server was cancelled");
      case DioExceptionType.connectionTimeout:
        return ApiException(message: AppStrings.errorTimeout);
      case DioExceptionType.receiveTimeout:
        return ApiException(message: "Receive timeout in connection with API server");
      case DioExceptionType.sendTimeout:
        return ApiException(message: "Send timeout in connection with API server");
      case DioExceptionType.connectionError:
        return ApiException(message: AppStrings.errorNoInternet);
      case DioExceptionType.badCertificate:
        return ApiException(message: "SSL certificate validation failed");
      case DioExceptionType.badResponse:
        return ApiException.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
      case DioExceptionType.unknown:
      default:
        if (dioException.message?.contains("SocketException") ?? false) {
          return ApiException(message: AppStrings.errorNoInternet);
        }
        return ApiException(message: AppStrings.errorSomethingWentWrong);
    }
  }

  factory ApiException.fromResponse(int? statusCode, dynamic responseData) {
    final String defaultMessage;
    switch (statusCode) {
      case 400:
        defaultMessage = AppStrings.errorBadRequest;
        break;
      case 401:
        defaultMessage = AppStrings.errorUnauthorized;
        break;
      case 403:
        defaultMessage = AppStrings.errorForbidden;
        break;
      case 404:
        defaultMessage = AppStrings.errorNotFound;
        break;
      case 500:
        defaultMessage = AppStrings.errorInternalServer;
        break;
      default:
        defaultMessage = AppStrings.errorSomethingWentWrong;
    }

    String message = defaultMessage;

    // Attempt to extract server error message if available
    if (responseData != null && responseData is Map<String, dynamic>) {
      if (responseData.containsKey('message')) {
        message = responseData['message'].toString();
      } else if (responseData.containsKey('error')) {
        message = responseData['error'].toString();
      }
    }

    return ApiException(message: message, statusCode: statusCode);
  }

  @override
  String toString() => message;
}
