import 'package:api_direct_app/src/model/model.dart';
import 'package:api_direct_app/src/repository/api_repository.dart';
import 'package:api_direct_app/src/token_State/token_state.dart';
import 'package:api_direct_app/src/utils.dart';

class ApiDirectApp {
  ApiDirectApp();

  final ApiRepository api = ApiRepository();

  Stream<TokenState> get status => Utils.inst.controller;

  UserInformation get getInformation => Utils.inst.information;

  set setInformation(UserInformation information) =>
      Utils.inst.information = information;
}
