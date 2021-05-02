import 'package:bluestackassignment/model/tournament_data_model.dart';
import 'package:bluestackassignment/utils/custom_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class TournamentDetailsService {
  TournamentDetailsService( this._dio);


  final Dio _dio;

  Future<TournamentData> getTournamentDetails({String cursor = ""}) async {
    try {
      final response = await Dio().get(
        cursor == ""
            ? "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all"
            : "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor=" +
                cursor,
      );
      TournamentData tournamentData = TournamentData.fromJson(response.data);
      return tournamentData;
    } on DioError catch (dioError) {
      throw CustomException.fromDioError(dioError);
    }
  }
}
