/// types response
enum StatusType {
  success,
  noContent,
  error,
  connectionError,
  unAuthorized,
  accessDenied
}

/// ReturnResponse is model return response as call api. You can change the model as for model return yourSelf rest api ;
class ReturnResponse {
  String? message;
  int? statusCode;
  dynamic payLoad;
  late StatusType? statusType;

  ReturnResponse({
    this.message,
    this.statusCode,
    this.payLoad,
    this.statusType,
  });

  factory ReturnResponse.fromJson(Map<String, dynamic> res) {
    return ReturnResponse(
      message: res['message'],
      statusCode: res['statusCode'],
      payLoad: res['payload'],
    );
  }

  ReturnResponse copyWith(
      {String? message,
      int? statusCode,
      dynamic payLoad,
      StatusType? statusType}) {
    return ReturnResponse(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      payLoad: payLoad ?? this.payLoad,
      statusType: statusType ?? this.statusType,
    );
  }
}
