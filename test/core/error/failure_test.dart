import 'package:flutter_test/flutter_test.dart';
import 'package:uni_football_app/core/error/failure.dart';

void main() {
  group('Failure Class Tests', () {
    test('LocalDatabaseFailure should have correct message and props', () {
      // Arrange
      const message = 'Database failure';
      const failure = LocalDatabaseFailure(message: message);

      // Act & Assert
      expect(failure.message, message);
      expect(failure.props, [message]);
    });
    test('ApiFailure equality based on message and statusCode', () {
      // Arrange
      const message1 = 'API request failed';
      const statusCode1 = 404;
      const message2 = 'Not found';
      const statusCode2 = 404;

      const failure1 = ApiFailure(statusCode1, message: message1);
      const failure2 = ApiFailure(statusCode1, message: message1);
      const failure3 = ApiFailure(statusCode2, message: message2);

      // Act & Assert
      expect(failure1, equals(failure2)); // Same message and statusCode
      expect(
          failure1, isNot(equals(failure3))); // Different message or statusCode
    });
    test('LocalDatabaseFailure equality based on message', () {
      // Arrange
      const message1 = 'Database failure';
      const message2 = 'Database error';

      const failure1 = LocalDatabaseFailure(message: message1);
      const failure2 = LocalDatabaseFailure(message: message1);
      const failure3 = LocalDatabaseFailure(message: message2);

      // Act & Assert
      expect(failure1, equals(failure2)); // Same message
      expect(failure1, isNot(equals(failure3))); // Different message
    });
  });
}
