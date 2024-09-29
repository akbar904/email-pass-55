
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_cubit_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = AuthCubit();
		});

		tearDown(() {
			authCubit.close();
		});

		test('Initial state is AuthInitial', () {
			expect(authCubit.state, isA<AuthInitial>());
		});

		blocTest<AuthCubit, AuthState>(
			'login emits [Authenticated] when email and password are correct',
			build: () => authCubit,
			act: (cubit) => cubit.login('zharfan@walturn.com', 'abc123'),
			expect: () => [isA<Authenticated>()],
		);

		blocTest<AuthCubit, AuthState>(
			'login emits [Unauthenticated] when email or password are incorrect',
			build: () => authCubit,
			act: (cubit) => cubit.login('wrong@walturn.com', 'wrongpassword'),
			expect: () => [isA<Unauthenticated>()],
		);

		blocTest<AuthCubit, AuthState>(
			'logout emits [Unauthenticated]',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [isA<Unauthenticated>()],
		);
	});
}
