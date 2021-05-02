import 'dart:convert';
import 'package:bluestackassignment/model/login_config_response.dart';
import 'package:bluestackassignment/providers/services/login_service.dart';
import 'package:bluestackassignment/utils/constants/string_constants.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluestackassignment/model/user_details_model.dart';


abstract class LoginRepository {
  Future fetchToken(UserDetails user , BuildContext context);

}

class LoginDataRepository implements LoginRepository {
  LoginService _loginService;
  LoginDataRepository(){
    _loginService = new LoginService();
  }
  @override
  Future fetchToken(UserDetails user , BuildContext context) async {
    String token = await _loginService.getAccessToken(user);
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      prefs.setString(StringConstants.authToken, token);
    });
  //   return configResponse;
  }


}




