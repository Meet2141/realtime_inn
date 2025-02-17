// import 'dart:io';
//
// import 'package:clean_architecture_seed/src/core/extensions/string_extensions.dart';
// import 'package:clean_architecture_seed/src/core/utils/log_utils.dart';
// import 'package:dio/dio.dart';
// import 'package:stack_trace/stack_trace.dart';
//
// typedef AuthenticationRepositoryGetter = AuthenticationRepository Function();
//
// class ApiTokenInterceptor extends Interceptor {
//   ApiTokenInterceptor(
//     this._authenticationRepositoryGetter,
//   );
//
//   final AuthenticationRepositoryGetter _authenticationRepositoryGetter;
//
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     Chain.capture(
//       () {
//         final String? apiToken = _authenticationRepositoryGetter().user?.apiToken;
//         if (apiToken.isNullNotEmpty) {
//           options.headers['Authorization'] = 'Bearer $apiToken';
//         }
//
//         handler.next(options);
//       },
//       onError: (error, stackChain) {
//         LogUtils.print(error, st: stackChain, message: 'token-interceptor-failed');
//         handler.reject(
//           DioException(
//             requestOptions: options,
//             error: error,
//             stackTrace: stackChain,
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Future<void> onError(
//     DioException err,
//     ErrorInterceptorHandler handler,
//   ) async {
//     if (err.type == DioExceptionType.badResponse && err.response?.statusCode == HttpStatus.forbidden) {
//       LogUtils.print(err, st: err.stackTrace, message: 'onError');
//       await _authenticationRepositoryGetter().signOut();
//     }
//     super.onError(err, handler);
//   }
// }
