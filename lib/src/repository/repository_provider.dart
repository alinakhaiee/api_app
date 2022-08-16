
part of 'api_repository.dart';
abstract class RepositoryProvider {
  Future<ReturnResponse> _callApi(Future<Response> Function() call) async {
    Response res;
    try {
      res = await call();
      if (kDebugMode) {
        print('request => ${res.requestOptions.path}');
      }
      if (kDebugMode) {
        print('response => ${res.data}');
      }
      if (kDebugMode) {
        print('body => ${res.requestOptions.data}');
      }
      if (kDebugMode) {
        print('token => ${res.requestOptions.headers['Authorization']}');
      }
      ReturnResponse responseModel = ReturnResponse.fromJson(res.data);
      responseModel.statusType = responseModel.statusCode.toStatusType;
      if (responseModel.statusType == StatusType.error) {
        /// call api create log to server
      }
      return responseModel;
    } catch (e) {
      /// call api create log to server
      if (e is DioError) {
        switch (e.type) {
          case DioErrorType.other:
            ReturnResponse returnResponse = ReturnResponse();
            returnResponse.statusCode = ApiStatusCode.dioError;
            returnResponse.statusType = StatusType.error;
            returnResponse.message = e.error.message ?? 'serverError';
            return returnResponse;
          default:
            ReturnResponse returnResponse = ReturnResponse();
            returnResponse.statusType = StatusType.connectionError;
            returnResponse.message = 'connectionLost';
            return returnResponse;
        }
      }
      return ReturnResponse(
          statusType: StatusType.error, message: 'serverError');
    }
  }
}

extension on int? {
  StatusType get toStatusType {
    switch (this) {
      case ApiStatusCode.success:
        return StatusType.success;
      case ApiStatusCode.noContent:
        return StatusType.noContent;
      case ApiStatusCode.unAuthorized:
        return StatusType.unAuthorized;
      case ApiStatusCode.accessDenied:
        return StatusType.accessDenied;
      default:
        return StatusType.error;
    }
  }
}
