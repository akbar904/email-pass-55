
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:com.example.simple_cubit_app/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) {
		if (email == 'zharfan@walturn.com' && password == 'abc123') {
			emit(Authenticated(User(email: email, password: password)));
		} else {
			emit(Unauthenticated());
		}
	}

	void logout() {
		emit(Unauthenticated());
	}
}

abstract class AuthState extends Equatable {
	@override
	List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
	final User user;

	Authenticated(this.user);

	@override
	List<Object> get props => [user];
}

class Unauthenticated extends AuthState {}
