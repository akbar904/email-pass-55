
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:com.example.simple_cubit_app/screens/home_screen.dart';

class MockAuthCubit extends MockCubit<void> implements AuthCubit {}

void main() {
	group('HomeScreen', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('renders HomeScreen with Logout button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: HomeScreen(),
				),
			);

			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('Logout button triggers logout', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: HomeScreen(),
				),
			);

			final logoutButton = find.text('Logout');
			expect(logoutButton, findsOneWidget);

			await tester.tap(logoutButton);
			await tester.pump();

			verify(() => authCubit.logout()).called(1);
		});
	});
}
