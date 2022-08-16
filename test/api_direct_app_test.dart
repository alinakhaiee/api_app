
import 'package:flutter_test/flutter_test.dart';

import 'package:api_direct_app/api_direct_app.dart';

void main() {
  final ApiDirectApp app =ApiDirectApp()..setInformation=UserInformation(id: 25,token: "token",refreshToken: "refreshToken");
  test('adds one to input values', () {
    app.status.listen((event) {

    });
    expect(app.getInformation.id,25);
    expect(app.getInformation.token, "token");
    app.setInformation=app.getInformation.copyWith(id: 16);
    expect(app.getInformation.id, 16);
    expect(app.getInformation.token, "token");
  });
}
