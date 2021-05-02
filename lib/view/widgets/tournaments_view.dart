import 'package:bluestackassignment/model/tournament_data_model.dart';
import 'package:bluestackassignment/providers/repository/tournament_pagination_controller.dart';
import 'package:bluestackassignment/utils/constants/size_config_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget tournamentDetailsWidget(List<Tournaments> tournamentData, TournamentPaginationController paginationController , ) {
  List<Tournaments> tournamentList = tournamentData;
  return ListView.builder(
    shrinkWrap: true,
      itemCount: tournamentList.length,
      itemBuilder: (BuildContext ctxt, int index) {
        paginationController.handleScrollWithIndex(index);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4.0,
            child: InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: SizeConfig.screenHeight * .12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      image: DecorationImage(
                        image: NetworkImage(tournamentList[index].coverUrl),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:10.0,right: 20.0,top:8.0,bottom: 8.0),
                              child: Text(
                                tournamentList[index].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:10.0,right: 20.0,top:8.0,bottom: 8.0),
                              child: Text(
                                tournamentList[index].gameName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,right: 20.0,top:8.0,bottom: 8.0),
                        child: new Icon(Icons.arrow_forward_ios ,size: 15,),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
