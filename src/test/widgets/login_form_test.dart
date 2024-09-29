
// test/widgets/login_form_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/widgets/login_form.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginForm Widget Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('should display email and password fields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LoginForm(),
					),
				),
			);

			expect(find.byType(TextFormField), findsNWidgets(2));
			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});

		testWidgets('should display login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LoginForm(),
					),
				),
			);

			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});

		testWidgets('should call login method on AuthCubit when login button is pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LoginForm(authCubit: mockAuthCubit),
					),
				),
			);

			await tester.enterText(find.byKey(Key('emailField')), 'zharfan@walturn.com');
			await tester.enterText(find.byKey(Key('passwordField')), 'abc123');
			await tester.tap(find.byType(ElevatedButton));

			verify(() => mockAuthCubit.login('zharfan@walturn.com', 'abc123')).called(1);
		});

		testWidgets('should show error text when email is invalid', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LoginForm(),
					),
				),
			);

			await tester.enterText(find.byKey(Key('emailField')), 'invalid_email');
			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			expect(find.text('Please enter a valid email'), findsOneWidget);
		});

		testWidgets('should show error text when password is empty', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LoginForm(),
					),
				),
			);

			await tester.enterText(find.byKey(Key('emailField')), 'zharfan@walturn.com');
			await tester.enterText(find.byKey(Key('passwordField')), '');
			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			expect(find.text('Password cannot be empty'), findsOneWidget);
		});
	});
}
