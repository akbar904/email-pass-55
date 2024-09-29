
import 'package:equatable/equatable.dart';

class User extends Equatable {
	final String email;
	final String password;

	User({required this.email, required this.password});

	@override
	List<Object> get props => [email, password];

	Map<String, dynamic> toJson() {
		return {
			'email': email,
			'password': password,
		};
	}

	factory User.fromJson(Map<String, dynamic> json) {
		return User(
			email: json['email'],
			password: json['password'],
		);
	}
}
