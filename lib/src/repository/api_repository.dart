import 'package:api_direct_app/src/api_routs/api_routs.dart';
import 'package:api_direct_app/src/api_status_code/api_status_code.dart';
import 'package:api_direct_app/src/model/model.dart';
import 'package:api_direct_app/src/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

part 'repository_provider.dart';

/// add api your needs
class ApiRepository extends RepositoryProvider {
  Future<ReturnResponse> login(Map<String,dynamic> data) => _callApi(
        () => Utils.inst.dio.post(apiLogin, data: data),
      );
}
