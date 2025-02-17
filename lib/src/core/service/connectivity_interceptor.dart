import 'package:dio/dio.dart';

import '../constants/string_constants.dart';
import '../utils/internet_connectivity_utils.dart';
import '../utils/toast_utils.dart';
import 'exceptions.dart';

class ConnectivityInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!await isInternetConnectivity()) {
      ToastUtils.showFailed(message: StringConstants.pleaseCheckInternet);
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.unknown,
          error: const CheckConnectionException(),
        ),
      );
    }
    return handler.next(options);
  }
}
