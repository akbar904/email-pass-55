
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/models/user_model.dart';

void main() {
	group('User Model Tests', () {
		test('User model should be instantiated with email and password', () {
			final user = User(email: 'zharfan@walturn.com', password: 'abc123');
			expect(user.email, 'zharfan@walturn.com');
			expect(user.password, 'abc123');
		});

		test('User model should support value equality', () {
			final user1 = User(email: 'zharfan@walturn.com', password: 'abc123');
			final user2 = User(email: 'zharfan@walturn.com', password: 'abc123');
			expect(user1, equals(user2));
		});

		test('User model should be serialized to JSON', () {
			final user = User(email: 'zharfan@walturn.com', password: 'abc123');
			final json = user.toJson();
			expect(json, {
				'email': 'zharfan@walturn.com',
				'password': 'abc123',
			});
		});

		test('User model should be deserialized from JSON', () {
			final json = {
				'email': 'zharfan@walturn.com',
				'password': 'abc123',
			};
			final user = User.fromJson(json);
			expect(user.email, 'zharfan@walturn.com');
			expect(user.password, 'abc123');
		});
	});
}
