
import 'package:bluestackassignment/model/tournament_data_model.dart';


class TournamentPagination {
  final List<Tournaments> tournamentData;
  final int page;
  final String errorMessage;
  final String cursor;
  TournamentPagination({
    this.tournamentData,
    this.page,
    this.errorMessage,
    this.cursor
  });

  TournamentPagination.initial()
      : tournamentData = [],
        page = 1,
        errorMessage = '',
        cursor ="";

  bool get refreshError => errorMessage != '' && tournamentData.length <= 20;

  TournamentPagination copyWith({
    List<Tournaments> tournamentData,
    int page,
    String errorMessage,
    String cursor
  }) {
    return TournamentPagination(
      tournamentData: tournamentData ?? this.tournamentData,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
      cursor: cursor ?? this.cursor
    );
  }

}
