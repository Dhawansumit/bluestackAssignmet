import 'dart:ui';

import 'package:bluestackassignment/providers/notifiers/login_notifier.dart';
import 'package:bluestackassignment/utils/commons/navigations.dart';
import 'package:bluestackassignment/utils/constants/size_config_constants.dart';
import 'package:bluestackassignment/utils/constants/string_constants.dart';
import 'package:bluestackassignment/view/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers.dart';
import 'login_screen.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      bool isUserLoggedIn = prefs.containsKey(StringConstants.authToken) ?? false;
      if (!isUserLoggedIn) {
        Future.delayed(Duration(seconds: 2), () {
          navigateWithReplacement(context: context, pageName: LoginScreen());
       });
      } else {
        Future.delayed(Duration(seconds: 2), () {
          navigateWithReplacement(context: context, pageName: HomeScreen());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: ProviderListener(
          provider: loginNotifierProvider,
          onChange: (context, state) async {
            if (state is LoginError) {
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              await _prefs.clear();
              navigateWithReplacement(
                  context: context, pageName: LoginScreen());
            }
          },
          child: Container(
              child: Center(
                  child: Container(
            width: SizeConfig.screenWidth * 0.5,
            height: SizeConfig.screenWidth * 0.5,
            child: Image.asset("assets/icons/gametv.png"),
          ))),
        ));
  }

}
