import 'package:bluestackassignment/utils/commons/navigations.dart';
import 'package:bluestackassignment/utils/constants/size_config_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_screen.dart';


Widget drawer(BuildContext context) {
  return SafeArea(
    child: Container(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.3,
              height: SizeConfig.screenWidth * 0.3,
              margin: const EdgeInsets.only(
                top: 24.0,
                bottom: 64.0,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.home),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home),
              title: Text(AppLocalizations
                  .of(context)
                  .home),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.account_circle_rounded),
              title: Text(AppLocalizations
                  .of(context)
                  .profile),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.favorite),
              title: Text(AppLocalizations
                  .of(context)
                  .favourites),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.settings),
              title: Text(AppLocalizations
                  .of(context)
                  .settings),
            ),
            ListTile(
              onTap: () {
                Future<SharedPreferences> _prefs =
                SharedPreferences.getInstance();
                _prefs.then((SharedPreferences prefs) {
                  prefs.clear();
                });
                navigateWithPopAllAndPush(
                    context: context, pageName: LoginScreen());
              },
              leading: Icon(Icons.logout),
              title: Text(AppLocalizations
                  .of(context)
                  .logout),
            ),
            Spacer(),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 12,
                color: Colors.white54,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: Text(AppLocalizations
                    .of(context)
                    .tc),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}