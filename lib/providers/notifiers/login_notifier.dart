import 'package:bluestackassignment/model/login_config_response.dart';
import 'package:bluestackassignment/model/user_details_model.dart';

import 'package:bluestackassignment/providers/repository/login_repository.dart';
import 'package:bluestackassignment/utils/commons/navigations.dart';
import 'package:bluestackassignment/view/home_screen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginLoaded extends LoginState {
  const LoginLoaded();
}

class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoginError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginRepository _loginRepository;
 LoginNotifier(this._loginRepository) : super(LoginInitial());

  Future<void> getLoginDetails(UserDetails user , BuildContext context) async {
    try {
      state = LoginLoading();
      await _loginRepository.fetchToken( user , context);
      navigateWithPopAllAndPush(context: context, pageName: HomeScreen());
    } catch (_) {
      state = LoginError(_.toString());
    }
  }

}
