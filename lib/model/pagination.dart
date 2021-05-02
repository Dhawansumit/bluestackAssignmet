import 'dart:convert';

import 'package:bluestackassignment/model/tournament_data_model.dart';
import 'package:flutter/foundation.dart';


class Pagination {
  final TournamentData tournamentData;
  final int page;
  final String errorMessage;
  final String cursor;
  Pagination({
    this.tournamentData,
    this.page,
    this.errorMessage,
    this.cursor
  });

  Pagination.initial()
      : tournamentData = null,
        page = 1,
        errorMessage = '',
  cursor="";

  bool get refreshError => errorMessage != '' && tournamentData.data.tournaments.length <= 20;

  Pagination copyWith({
    TournamentData tournamentData,
    int page,
    String errorMessage,
  }) {
    return Pagination(
      tournamentData: tournamentData ?? this.tournamentData,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
      cursor: tournamentData.data.cursor ??   this.tournamentData.data.cursor
    );
  }

  // @override
  // String toString() => 'MoviePagination(movies: $tournamentData, page: $page, errorMessage: $errorMessage)';
  //
  // @override
  // bool operator ==(Object o) {
  //   if (identical(this, o)) return true;
  //
  //   return o is Pagination && listEquals(o.tournamentData, tournamentData) && o.page == page && o.errorMessage == errorMessage;
  // }

  @override
  int get hashCode => tournamentData.hashCode ^ page.hashCode ^ errorMessage.hashCode;
}