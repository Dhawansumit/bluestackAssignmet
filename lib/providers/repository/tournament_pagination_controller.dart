import 'package:bluestackassignment/model/pagination.dart';
import 'package:bluestackassignment/utils/custom_exception.dart';
import 'package:flutter_riverpod/all.dart';

import '../../model/tournament_pagination.dart';
import '../services/tournament_service.dart';

class TournamentPaginationController
    extends StateNotifier<TournamentPagination> {
  TournamentPaginationController(
    this._tournamentDetailService, [
    TournamentPagination state,
  ]) : super(state ?? TournamentPagination.initial()) {
    getTournaments();
  }

  final TournamentDetailsService _tournamentDetailService;

  Future<void> getTournaments() async {
    try {
      final tournaments = await _tournamentDetailService.getTournamentDetails(
          cursor: state.cursor);

      state = state.copyWith(tournamentData: [
        ...state.tournamentData,
        ...tournaments.data.tournaments
      ], page: state.page + 1, cursor: tournaments.data.cursor);
    } on CustomException catch (e) {
      state = state.copyWith(errorMessage: e.message);
    }
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;
    final requestMoreData = itemPosition % 10 == 0 && itemPosition != 0;
    final pageToRequest = itemPosition ~/ 10;

    if (requestMoreData && pageToRequest + 1 >= state.page) {
      getTournaments();
    }
  }
}
