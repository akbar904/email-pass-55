
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('Main App Initialization Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('App starts with LoginScreen as initial route', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp(authCubit: authCubit));
			expect(find.byType(LoginScreen), findsOneWidget);
		});

		testWidgets('Navigates to HomeScreen on successful login', (WidgetTester tester) async {
			whenListen(
				authCubit,
				Stream.fromIterable([Unauthenticated(), Authenticated()]),
				initialState: Unauthenticated(),
			);

			await tester.pumpWidget(MyApp(authCubit: authCubit));
			await authCubit.login('zharfan@walturn.com', 'abc123');
			await tester.pumpAndSettle();

			expect(find.byType(HomeScreen), findsOneWidget);
		});

		testWidgets('Displays LogoutButton on HomeScreen', (WidgetTester tester) async {
			whenListen(
				authCubit,
				Stream.fromIterable([Authenticated()]),
				initialState: Authenticated(),
			);

			await tester.pumpWidget(MyApp(authCubit: authCubit));
			await tester.pumpAndSettle();

			expect(find.byType(LogoutButton), findsOneWidget);
		});

		testWidgets('Navigates back to LoginScreen on logout', (WidgetTester tester) async {
			whenListen(
				authCubit,
				Stream.fromIterable([Authenticated(), Unauthenticated()]),
				initialState: Authenticated(),
			);

			await tester.pumpWidget(MyApp(authCubit: authCubit));
			await authCubit.logout();
			await tester.pumpAndSettle();

			expect(find.byType(LoginScreen), findsOneWidget);
		});
	});
}
