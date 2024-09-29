
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_cubit_app/cubits/auth_cubit.dart';
import 'package:com.example.simple_cubit_app/widgets/logout_button.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Home'),
				actions: [
					LogoutButton(),
				],
			),
			body: Center(
				child: Text('Welcome to the Home Screen!'),
			),
		);
	}
}
