import 'package:api_direct_app/src/utils.dart';
import 'package:dio/dio.dart';

class DirectInterceptor extends InterceptorsWrapper {
  late Map<String, dynamic> baseHeader;

  DirectInterceptor() {
    baseHeader = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST,GET,DELETE,PUT',
      'Accept-Language': 'En'
    };
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /// add parameter required for header api
    // baseHeader['Authorization'] = Utils.inst.information.token ?? "";

    options
      ..connectTimeout = 15000
      ..receiveTimeout = 15000
      ..validateStatus = (int? status) {
        return status! > 0;
      }
      ..headers = baseHeader;
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final response = err.response;
    if (response?.statusCode == 401 &&
        response?.headers["Authorization"] != null) {
      try {
        final refreshResponse = await _tryRefresh(response!);
        handler.resolve(refreshResponse);
      } on DioError catch (e) {
        return handler.next(e);
      }
    }
  }

  Future<Response<dynamic>> _tryRefresh(Response response) async {
    dynamic res;
    try {
      res = await _refreshToken();
    } on RevokeTokenException catch (e) {
      if (RevokeTokenException is RevokeTokenExceptionForTokenError) {
        Utils.inst.addTokenExpired();
      }
      throw DioError(
        requestOptions: response.requestOptions,
        error: e,
        response: response,
      );
    }

    /// set token and refresh
    Utils.inst
        .addTokenStore(token: res["token"], refreshToken: res["refreshToken"]);
    Utils.inst.dio.options.baseUrl = response.requestOptions.baseUrl;
    return Utils.inst.dio.request<dynamic>(
      response.requestOptions.path,
      cancelToken: response.requestOptions.cancelToken,
      data: response.requestOptions.data,
      onReceiveProgress: response.requestOptions.onReceiveProgress,
      onSendProgress: response.requestOptions.onSendProgress,
      queryParameters: response.requestOptions.queryParameters,
      options: Options(
        method: response.requestOptions.method,
        sendTimeout: response.requestOptions.sendTimeout,
        receiveTimeout: response.requestOptions.receiveTimeout,
        extra: response.requestOptions.extra,
        headers: response.requestOptions.headers
          ..addAll({"Authorization": res["token"]}),
        responseType: response.requestOptions.responseType,
        contentType: response.requestOptions.contentType,
        validateStatus: response.requestOptions.validateStatus,
        receiveDataWhenStatusError:
            response.requestOptions.receiveDataWhenStatusError,
        followRedirects: response.requestOptions.followRedirects,
        maxRedirects: response.requestOptions.maxRedirects,
        requestEncoder: response.requestOptions.requestEncoder,
        responseDecoder: response.requestOptions.responseDecoder,
        listFormat: response.requestOptions.listFormat,
      ),
    );
  }

  Future<dynamic> _refreshToken() async {
    Dio dio = Dio();

    /// call refresh token
    Response response = await dio.post("refresh token");

    /// handle response refresh token for return function;
    if (response.statusCode != 201 || response.data == null) {
      throw RevokeTokenException();
    }
    return response.data;
  }
}

class RevokeTokenException implements Exception {}

/// error when connection lost or server error
class RevokeTokenExceptionForConnection extends RevokeTokenException {}

/// error when the token or refresh token is mistake;
class RevokeTokenExceptionForTokenError extends RevokeTokenException {}
