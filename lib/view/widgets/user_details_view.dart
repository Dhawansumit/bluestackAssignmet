import 'package:bluestackassignment/model/login_config_response.dart';
import 'package:bluestackassignment/utils/constants/size_config_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Widget userDetailsWidget(LoginConfigResponse userDetails,
    BuildContext context) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 10, right: 25.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: SizeConfig.screenWidth * 0.2,
                height: SizeConfig.screenWidth * 0.2,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.network(userDetails.imageURL),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userDetails.userName,
                        style: TextStyle(
                            fontSize: SizeConfig.textSize * 10,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.indigo, width: 1),
                      ),
                      // minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(15.0, 5.0, 25.0, 5.0),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(userDetails.rating.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.textSize * 10,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Elo Rating",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: SizeConfig.textSize * 5,
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.screenWidth * .28,
                  height: SizeConfig.screenHeight * .1,
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          const Color(0xFFD4145A),
                          const Color(0xFFFBB03B),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userDetails.tournamentsPlayed.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text(AppLocalizations
                            .of(context)
                            .tournaments + "\n" + AppLocalizations
                            .of(context)
                            .played,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth * .28,
                  height: SizeConfig.screenHeight * .1,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Colors.white),
                      right: BorderSide(color: Colors.white),
                    ),
                    gradient: new LinearGradient(
                        colors: [
                          const Color(0xFFc33764),
                          const Color(0xFF1d2671),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userDetails.tournamentWon.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text(AppLocalizations
                            .of(context)
                            .tournaments + "\n" + AppLocalizations
                            .of(context)
                            .won,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth * .28,
                  height: SizeConfig.screenHeight * .1,
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          const Color(0xFFff9966),
                          const Color(0xFFff5e62),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            ((userDetails.tournamentWon /
                                userDetails.tournamentsPlayed) *
                                100)
                                .floor()
                                .toString() +
                                "%",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              //fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text(AppLocalizations
                            .of(context)
                            .winning + "\n" + AppLocalizations
                            .of(context)
                            .percentage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              // fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}