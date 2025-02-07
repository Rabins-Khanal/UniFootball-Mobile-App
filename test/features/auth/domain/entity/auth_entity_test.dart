import 'package:flutter_test/flutter_test.dart';
import 'package:uni_football_app/features/auth/domain/entity/auth_entity.dart';

void main() {
  group('AuthEntity Tests', () {
    test(
        'AuthEntity equality should be based on userId, fullName, image, email, username, and password',
        () {
      // Arrange
      const userId1 = '1';
      const email1 = 'test1@test.com';
      const username1 = 'testuser1';
      const password1 = 'password1';
      const fullName1 = 'Test User One';
      const image1 = 'image_url_1';

      const userId2 = '2';
      const email2 = 'test2@test.com';
      const username2 = 'testuser2';
      const password2 = 'password2';
      const fullName2 = 'Test User Two';
      const image2 = 'image_url_2';

      const authEntity1 = AuthEntity(
        userId: userId1,
        fullName: fullName1,
        image: image1,
        email: email1,
        username: username1,
        password: password1,
      );
      const authEntity2 = AuthEntity(
        userId: userId1,
        fullName: fullName1,
        image: image1,
        email: email1,
        username: username1,
        password: password1,
      );
      const authEntity3 = AuthEntity(
        userId: userId2,
        fullName: fullName2,
        image: image2,
        email: email2,
        username: username2,
        password: password2,
      );

      // Act & Assert
      expect(authEntity1, equals(authEntity2)); // Same values for all fields
      expect(authEntity1,
          isNot(equals(authEntity3))); // Different values for some fields
    });

    test(
        'AuthEntity props should contain userId, fullName, image, email, username, and password in correct order',
        () {
      // Arrange
      const userId = '1';
      const email = 'test@test.com';
      const username = 'testuser';
      const password = 'password';
      const fullName = 'Test User';
      const image = 'image_url';

      const authEntity = AuthEntity(
        userId: userId,
        fullName: fullName,
        image: image,
        email: email,
        username: username,
        password: password,
      );

      // Act & Assert
      expect(authEntity.props,
          [userId, fullName, image, email, username, password]);
    });

    test('AuthEntity should allow creation with null userId and image', () {
      // Arrange
      const email = 'test@test.com';
      const username = 'testuser';
      const password = 'password';
      const fullName = 'fullname';
      const image = null; // image can be null

      const authEntity = AuthEntity(
        userId: null,
        fullName: fullName,
        image: image,
        email: email,
        username: username,
        password: password,
      );

      // Act & Assert
      expect(authEntity.userId, null);
      expect(authEntity.email, email);
      expect(authEntity.username, username);
      expect(authEntity.password, password);
      expect(authEntity.fullName, fullName);
      expect(authEntity.image, image); // image is null here
    });
  });
}
