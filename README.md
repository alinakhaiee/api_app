<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Sample Package management rest api


## Features
call api <br /> 
management api <br /> 
clean code <br /> 
refresh token <br /> 

## Packages
dio

## Getting started
1.add routs api in file api_routs.dart <br /> 
2.add status code as for yourself rest api <br /> 
3.change model return_response  as for model return yourSelf rest api <br /> 
4.change model user_information as for your needs <br /> 
5.add function api your needs in  file api_repository.dart as for example <br /> 
6.listen to status in api_direct_app for store token and refresh token or logout as app <br /> 



## Usage

```dart
final ApiDirectApp app =ApiDirectApp()..setInformation=UserInformation(id: 25,token: "token",refreshToken: "refreshToken");

// get information
UserInformation information= app.getInformation;

// set information
// set information after change Its parameters.
app.setInformation=UserInformation(id:10);

// call api
 ReturnResponse = await app.api.login();
 
// you listen to status
app.status.listen((event) {
});
```
