import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'connectivity_interceptor.dart';
import 'exceptions.dart';

typedef SerializerFunction<T> = T Function(Map<String, dynamic> data);

class DioService {
  DioService({
    Iterable<Interceptor> interceptors = const [],
    int timeoutMilliseconds = 30000,
  }) {
    _dio.interceptors.add(ConnectivityInterceptor());
    _dio.interceptors.addAll(interceptors);

    _dio.options.baseUrl = dotenv.env['BASE_URL'] ?? '';

    _dio.options.responseType = ResponseType.plain;
    _dio.options.headers[HttpHeaders.acceptHeader] = ContentType.json.toString();

    _dio.options.connectTimeout = Duration(milliseconds: timeoutMilliseconds);
    _dio.options.receiveTimeout = Duration(milliseconds: timeoutMilliseconds);
  }

  void dispose() {
    _dio.close(force: true);
  }

  final Dio _dio = Dio();

  final _serializerFunctions = <Type, SerializerFunction<dynamic>>{};

  void addSerializerFunctions(Map<Type, SerializerFunction<dynamic>> map) {
    _serializerFunctions.addAll(map);
  }

  Future<T> get<T>(
    String uri, {
    Options? options,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<String>(
        uri,
        options: options,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      return _decodeJson(response.data!);
    } on Exception catch (e, st) {
      await _handleException(e: e, st: st);
      rethrow;
    }
  }

  Future<T> post<T>(
    String uri, {
    Options? options,
    Object? requestData,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<String>(
        uri,
        options: options,
        data: requestData,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return _decodeJson<T>(response.data!);
    } on Exception catch (e, st) {
      await _handleException(e: e, st: st);
      rethrow;
    }
  }

  Future<T?> postNullable<T>(
    String uri, {
    Options? options,
    Object? requestData,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<String>(
        uri,
        options: options,
        data: requestData,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.data == null || (response.data as String).isEmpty) {
        return null;
      }

      return _decodeJson<T>(response.data!);
    } on Exception catch (e, st) {
      await _handleException(e: e, st: st);
      rethrow;
    }
  }

  Future<T> put<T>(
    String uri, {
    Options? options,
    Object? requestData,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put<String>(
        uri,
        options: options,
        data: requestData,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return _decodeJson(response.data!);
    } on Exception catch (e, st) {
      await _handleException(e: e, st: st);
      rethrow;
    }
  }

  Future<T> patch<T>(
    String uri, {
    Options? options,
    Object? requestData,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch<String>(
        uri,
        options: options,
        data: requestData,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return _decodeJson(response.data!);
    } on Exception catch (e, st) {
      await _handleException(e: e, st: st);
      rethrow;
    }
  }

  Future<T> delete<T>(
    String uri, {
    Options? options,
    Object? requestData,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete<String>(
        uri,
        options: options,
        data: requestData,
        queryParameters: queryParameters,
      );

      return _decodeJson(response.data!);
    } on Exception catch (e, st) {
      await _handleException(e: e, st: st);
      rethrow;
    }
  }

  Stream<Uint8List> streamPost(
    String uri, {
    Options? options,
    Object? requestData,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async* {
    try {
      final response = await _dio.post<ResponseBody>(
        uri,
        options: (options ?? Options()).copyWith(
          responseType: ResponseType.stream,
        ),
        data: requestData,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      yield* response.data!.stream;
    } on Exception catch (e, st) {
      await _handleException(e: e, st: st);
      rethrow;
    }
  }

  static Type _typeOf<T>() => T;

  Future<T> _decodeJson<T>(String jsonString) async {
    if (jsonString.isEmpty) jsonString = '{}';

    if (_typeOf<T>() == _typeOf<dynamic>()) {
      return jsonString as T;
    }

    final dynamic decoded = json.decode(jsonString);
    if (_typeOf<T>() == _typeOf<Map<String, dynamic>>()) {
      return decoded;
    } else if (_typeOf<T>() == _typeOf<List<Map<String, dynamic>>>()) {
      return List<Map<String, dynamic>>.from(decoded) as T;
    }

    if (_serializerFunctions.containsKey(T)) {
      return _serializerFunctions[T]!.call(decoded);
    }

    throw const SerializerFunctionException();
  }

  Future<void> _handleException({
    required Exception e,
    required StackTrace st,
  }) async {
    if (e is! DioException) {
      if (e is SocketException) {
        throw const CheckConnectionException();
      }
      throw e;
    }

    if (e.type == DioExceptionType.unknown && (e.message?.contains('SocketException') ?? false)) {
      throw const CheckConnectionException();
    }

    if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
      throw const ConnectionTimeoutException();
    }

    final List<String>? contentType = e.response?.headers[Headers.contentTypeHeader];
    if (contentType != null && contentType.isNotEmpty) {
      final bool isContentTypeHtml = contentType.any(
        (str) => str.contains('application/html') || str.contains('text/html'),
      );
      if (isContentTypeHtml) {
        throw HttpServiceException(
          statusCode: e.response?.statusCode ?? 422,
          message: e.response?.statusMessage ?? 'Invalid content type: HTML',
        );
      }
    }

    if (e.type == DioExceptionType.badResponse && e.response != null) {
      final dynamic responseBody = e.response!.data;
      if (responseBody != null && responseBody is String && responseBody.isNotEmpty) {
        // extract message & errors

        const String? message = null;
        const Map<String, dynamic>? errors = null;

        throw HttpServiceException(
          statusCode: e.response!.statusCode!,
          message: message ?? 'Sorry, an error occurred.',
          errors: errors,
        );
      }

      throw HttpServiceException(statusCode: e.response!.statusCode!);
    }

    throw e;
  }
}
