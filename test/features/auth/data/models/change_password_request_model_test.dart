import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/data/models/change_password_request_model.dart';

void main() {
  group('ChangePasswordRequestModel', () {
    test('toJson and fromJson should work properly', () {
      final model = ChangePasswordRequestModel(password: 'old@123', newPassword: 'New@456');
      final Map<String, dynamic> json = model.toJson();
      expect(json, {
        'password': 'old@123',
        'newPassword': 'New@456',
      });
      final fromJson = ChangePasswordRequestModel.fromJson(json);
      expect(fromJson.password, 'old@123');
      expect(fromJson.newPassword, 'New@456');
    });
  });
}