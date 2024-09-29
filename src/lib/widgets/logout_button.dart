
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';

class LogoutButton extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return ElevatedButton(
			onPressed: () {
				context.read<AuthCubit>().logout();
			},
			child: Text('Logout'),
		);
	}
}
