import 'package:bluestackassignment/providers/notifiers/login_notifier.dart';
import 'package:bluestackassignment/utils/commons/navigations.dart';
import 'package:bluestackassignment/utils/constants/size_config_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:bluestackassignment/model/user_details_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../providers.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool disableLoginButton = false;

  TextEditingController textPasswordController = new TextEditingController();
  TextEditingController textUserNameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Center(
            child: Stack(
              children: [
                Consumer(
                    builder: (context, watch, child) {
                      final state = watch(loginNotifierProvider.state);
                      if (state is LoginInitial) {
                        return buildLoginScreen();
                      } else if (state is LoginLoading) {
                        return buildLoading();
                      } else if (state is LoginError) {
                        return PlatformAlertDialog(
                          title: Text(
                            AppLocalizations.of(context).error,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Text(state.message),
                          actions: <Widget>[
                            PlatformDialogAction(
                                child: Text(
                                  "OK",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: ()
                                {
                                      context.read(loginNotifierProvider).state = LoginInitial();
                                      navigateWithPopAllAndPush(
                                          context: context, pageName: LoginScreen());
                                    }),
                          ],
                        );
                      } else {
                        return buildLoginScreen();
                      }
                    },
                    child: buildLoginScreen()),
              ],
            ),
          ),
        ));
  }

  Widget buildLoginScreen() {

    return SingleChildScrollView(
      child: Center(
        child: Form(
          autovalidate: true, //check for validation while typing
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: SizeConfig.screenWidth * 0.5,
                  height: SizeConfig.screenWidth * 0.3,
                  child: Image.asset("assets/icons/GameTv-login-logo.png")),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    controller: textUserNameController,
                    onChanged: (value) {
                      setState(() {
                        disableLoginButton = formkey.currentState.validate();
                      });
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        hintText: AppLocalizations.of(context).username),
                    validator: MultiValidator([
                      RequiredValidator(errorText: AppLocalizations.of(context).required),
                      MinLengthValidator(3,
                          errorText: AppLocalizations.of(context).username_min_val),
                      MaxLengthValidator(10,
                          errorText:
                          AppLocalizations.of(context).username_max_val)
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                    controller: textPasswordController,
                    onChanged: (value) {
                      setState(() {
                        disableLoginButton = formkey.currentState.validate();
                      });
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        hintText: AppLocalizations.of(context).password),
                    validator: MultiValidator([
                      RequiredValidator(errorText: AppLocalizations.of(context).required),
                      MinLengthValidator(3,
                          errorText: AppLocalizations.of(context).password_min_val),
                      MaxLengthValidator(10,
                          errorText:
                          AppLocalizations.of(context).password_max_val)
                    ])
                    //validatePassword,        //Function to check validation
                    ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: disableLoginButton ? Colors.black : Colors.grey,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        context
                            .read(loginNotifierProvider)
                            .getLoginDetails(
                                new UserDetails(
                                    username: textUserNameController.value.text,
                                    password:
                                        textPasswordController.value.text),
                                context);
                      } else {
                      }
                    },
                    child: Text(AppLocalizations.of(context).login,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PlatformCircularProgressIndicator(),
      ],
    ));
  }
}
