import 'dart:async';

import 'package:api_direct_app/src/interceptor/direct_interceptor.dart';
import 'package:api_direct_app/src/model/model.dart';
import 'package:api_direct_app/src/token_State/token_state.dart';
import 'package:dio/dio.dart';

class Utils {
  static final Utils inst = Utils.privateConstructor();

  Utils.privateConstructor();

  factory Utils() {
    return inst;
  }

  final String baseUrl = "";
  late UserInformation information=UserInformation();
  final Dio dio = Dio()..interceptors.add(DirectInterceptor());
  final _controller = StreamController<TokenState>();
  Stream<TokenState> get controller=>_controller.stream;


  Stream<TokenState> get status async* {
    yield* _controller.stream;
  }

  void addTokenExpired() {
    _controller.add(TokenStateExpired());
  }

  void addTokenStore({required String token, required String refreshToken}) {
    _controller.add(TokenStateStore(refreshToken: refreshToken, token: token));
  }
}
