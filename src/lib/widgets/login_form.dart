
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';

class LoginForm extends StatefulWidget {
	final AuthCubit? authCubit;

	const LoginForm({Key? key, this.authCubit}) : super(key: key);

	@override
	_LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
	final _formKey = GlobalKey<FormState>();
	final _emailController = TextEditingController();
	final _passwordController = TextEditingController();

	@override
	void dispose() {
		_emailController.dispose();
		_passwordController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Form(
			key: _formKey,
			child: Column(
				children: <Widget>[
					TextFormField(
						key: Key('emailField'),
						controller: _emailController,
						decoration: InputDecoration(
							labelText: 'Email',
						),
						validator: (value) {
							if (value == null || value.isEmpty) {
								return 'Please enter an email';
							} else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
								return 'Please enter a valid email';
							}
							return null;
						},
					),
					TextFormField(
						key: Key('passwordField'),
						controller: _passwordController,
						decoration: InputDecoration(
							labelText: 'Password',
						),
						obscureText: true,
						validator: (value) {
							if (value == null || value.isEmpty) {
								return 'Password cannot be empty';
							}
							return null;
						},
					),
					ElevatedButton(
						onPressed: () {
							if (_formKey.currentState?.validate() ?? false) {
								final email = _emailController.text;
								final password = _passwordController.text;
								final authCubit = widget.authCubit ?? context.read<AuthCubit>();

								if (email == 'zharfan@walturn.com' && password == 'abc123') {
									authCubit.login(email, password);
								} else {
									ScaffoldMessenger.of(context).showSnackBar(
										SnackBar(content: Text('Invalid credentials')),
									);
								}
							}
						},
						child: Text('Login'),
					),
				],
			),
		);
	}
}
