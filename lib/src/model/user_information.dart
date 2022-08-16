import 'package:equatable/equatable.dart';

///UserInformation have information required call api. You can change this as for your needs
/// You must set this model after login ,sign up,....
// ignore: must_be_immutable
class UserInformation extends Equatable {
  late int? id;
  late String? token;
  late String? refreshToken;
  late int? acceptLanguage;

  UserInformation({this.id, this.refreshToken, this.token, this.acceptLanguage});
  UserInformation copyWith({int? id, String? token, String? refreshToken, int? acceptLanguage}) {
    return UserInformation(
      id: id ?? this.id,
      refreshToken: refreshToken ?? this.refreshToken,
      token: token ?? this.token,
      acceptLanguage: acceptLanguage ?? this.acceptLanguage,
    );
  }

  @override
  List<Object?> get props => [id, token, refreshToken, acceptLanguage,];
}