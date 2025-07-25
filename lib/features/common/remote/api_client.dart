import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/uris.dart';

part 'api_client.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  return ApiClient();
}

class ApiClient {
  static const String _baseUrl = Uris.base;
  static const int _timeout = 30000; // 30 seconds

  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(milliseconds: _timeout),
        receiveTimeout: const Duration(milliseconds: _timeout),
        sendTimeout: const Duration(milliseconds: _timeout),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'zoneId': '[1]',
          'latitude': '23.735129',
          'longitude': '90.425614'
        },
      ),
    );
  }

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException();
      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);
      case DioExceptionType.cancel:
        return RequestCancelledException();
      case DioExceptionType.connectionError:
        return NoInternetException();
      default:
        return UnknownException();
    }
  }

  Exception _handleResponseError(Response? response) {
    if (response == null) return UnknownException();

    switch (response.statusCode) {
      case 400:
        return BadRequestException(response.data['message']);
      case 401:
        return UnauthorizedException();
      case 403:
        return ForbiddenException();
      case 404:
        return NotFoundException();
      case 500:
        return ServerException();
      default:
        return UnknownException();
    }
  }
}

// Custom Exceptions
class TimeoutException implements Exception {
  final String message = 'Connection timeout';
}

class NoInternetException implements Exception {
  final String message = 'No internet connection';
}

class RequestCancelledException implements Exception {
  final String message = 'Request cancelled';
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);
}

class UnauthorizedException implements Exception {
  final String message = 'Unauthorized access';
}

class ForbiddenException implements Exception {
  final String message = 'Access forbidden';
}

class NotFoundException implements Exception {
  final String message = 'Resource not found';
}

class ServerException implements Exception {
  final String message = 'Internal server error';
}

class UnknownException implements Exception {
  final String message = 'An unknown error occurred';
}
