import 'dart:ui';

import 'package:bluestackassignment/model/login_config_response.dart';
import 'package:bluestackassignment/model/tournament_data_model.dart';
import 'package:bluestackassignment/providers/repository/tournament_pagination_controller.dart';
import 'package:bluestackassignment/providers/services/tournament_service.dart';
import 'package:bluestackassignment/utils/commons/navigations.dart';
import 'package:bluestackassignment/utils/constants/size_config_constants.dart';
import 'package:bluestackassignment/utils/constants/string_constants.dart';
import 'package:bluestackassignment/utils/custom_exception.dart';
import 'package:bluestackassignment/view/login_screen.dart';
import 'package:bluestackassignment/view/widgets/drawer_view.dart';
import 'package:bluestackassignment/view/widgets/tournaments_view.dart';
import 'package:bluestackassignment/view/widgets/user_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers.dart';

class HomeScreen extends ConsumerWidget {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    SizeConfig().init(context);
    AsyncValue<LoginConfigResponse> userDetails = watch(userDetailsProvider);
    final paginationController = watch(tournamentPaginationControllerProvider);
    final paginationState = watch(tournamentPaginationControllerProvider.state);
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      openRatio: 0.6,
      controller: _advancedDrawerController,
      drawer: drawer(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backwardsCompatibility: false,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.white),
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            StringConstants.appName,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (context, value, child) {
                return Icon(
                  value.visible ? Icons.clear : Icons.menu,
                  color: Colors.black,
                );
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: SizeConfig.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userDetails.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, s) {
                      if (e is CustomException) {
                        if (e.message ==
                            AppLocalizations.of(context).oops_wrong) {
                          Future<SharedPreferences> _prefs =
                              SharedPreferences.getInstance();
                          _prefs.then((SharedPreferences prefs) {
                            prefs.clear();
                          });
                          navigateWithPopAllAndPush(
                              context: context, pageName: LoginScreen());
                        }
                        return _ErrorBody(message: e.message);
                      }
                      return _ErrorBody(
                          message: AppLocalizations.of(context).oops_unexpected);
                    },
                    data: (userDetails) =>
                        userDetailsWidget(userDetails, context)),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    AppLocalizations.of(context).recommended_for_you,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.textSize * 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (paginationState.refreshError) {
                        return _ErrorBody(message: paginationState.errorMessage);
                      } else if (paginationState.tournamentData.isEmpty) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return RefreshIndicator(
                        onRefresh: () {
                          return context
                              .refresh(tournamentPaginationControllerProvider)
                              .getTournaments();
                        },
                        child: tournamentDetailsWidget(
                            paginationState.tournamentData, paginationController),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({
    Key key,
    @required this.message,
  })  : assert(message != null, 'A non-null String must be provided'),
        super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: () => context.refresh(tournamentPaginationControllerProvider),
            child: Text("Try again"),
          ),
        ],
      ),
    );
  }
}
