import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/profile/domain/entity/user_entity.dart';

void main() {
  group('UserEntity', () {
    test('Should return a valid userEnityt from Json', () {
      final json = {
        'username': 'test_user',
        'email': 'test@email.com',
      };
      final user = UserEntity.fromJson(json);

      expect(user.username, 'test_user');
      expect(user.email, 'test@email.com');
    });

    test('should have a correct props for equality', () {
      const user1 = UserEntity(username: 'user1', email: 'user1@email.com');
      const user2 = UserEntity(username: 'user1', email: 'user1@email.com');
      const user3 = UserEntity(username: 'user3', email: 'user3@email.com');

      expect(user1, equals(user2));
      expect(user1, isNot(equals(user3)));
    });
  });

  group('TokenEntity', () {
    test('should return a valid TokenEntity from JSON', () {
      final json = {
        'token': 'someTokenString',
        '_id': '12345',
      };

      final token = TokenEntity.fromJson(json);

      expect(token.token, 'someTokenString');
      expect(token.id, '12345');
    });

    test('should have correct props for equality', () {
      const token1 = TokenEntity(token: 'token1', id: 'id1');
      const token2 = TokenEntity(token: 'token1', id: 'id1');
      const token3 = TokenEntity(token: 'token2', id: 'id2');

      expect(token1, equals(token2));
      expect(token1, isNot(equals(token3)));
    });
  });
}
