
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/auth_cubit.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
	runApp(MyApp(authCubit: AuthCubit()));
}

class MyApp extends StatelessWidget {
	final AuthCubit authCubit;

	MyApp({required this.authCubit});

	@override
	Widget build(BuildContext context) {
		return BlocProvider(
			create: (context) => authCubit,
			child: MaterialApp(
				title: 'Simple Cubit App',
				home: BlocBuilder<AuthCubit, AuthState>(
					builder: (context, state) {
						if (state is Authenticated) {
							return HomeScreen();
						} else {
							return LoginScreen();
						}
					},
				),
			),
		);
	}
}
