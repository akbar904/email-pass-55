
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_cubit_app/screens/login_screen.dart';
import 'package:com.example.simple_cubit_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('renders login form', (tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LoginScreen(),
					),
				),
			);
			expect(find.byType(LoginForm), findsOneWidget);
		});

		testWidgets('renders email field', (tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LoginScreen(),
					),
				),
			);
			expect(find.byKey(Key('emailField')), findsOneWidget);
		});

		testWidgets('renders password field', (tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LoginScreen(),
					),
				),
			);
			expect(find.byKey(Key('passwordField')), findsOneWidget);
		});

		testWidgets('renders login button', (tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LoginScreen(),
					),
				),
			);
			expect(find.byKey(Key('loginButton')), findsOneWidget);
		});
	});

	group('AuthCubit Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = AuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'emits [Authenticated] when login is successful with correct credentials',
			build: () => authCubit,
			act: (cubit) => cubit.login('zharfan@walturn.com', 'abc123'),
			expect: () => [isA<Authenticated>()],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [Unauthenticated] when login fails with incorrect credentials',
			build: () => authCubit,
			act: (cubit) => cubit.login('wrong@walturn.com', 'wrongpassword'),
			expect: () => [isA<Unauthenticated>()],
		);
	});
}
