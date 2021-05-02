import 'package:bluestackassignment/model/login_config_response.dart';
import 'package:bluestackassignment/providers/notifiers/login_notifier.dart';
import 'package:bluestackassignment/providers/repository/login_repository.dart';
import 'package:bluestackassignment/providers/repository/tournament_pagination_controller.dart';
import 'package:bluestackassignment/providers/repository/user_details_repository.dart';
import 'package:bluestackassignment/providers/services/tournament_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/tournament_data_model.dart';

final loginRepositoryProvider = Provider.autoDispose<LoginRepository>(
  (ref) => LoginDataRepository(),
);

final loginNotifierProvider = StateNotifierProvider.autoDispose(
  (ref) => LoginNotifier(ref.watch(loginRepositoryProvider)),
);

final userDetailsProvider = FutureProvider<LoginConfigResponse>((ref) async {
  return  fetchUserDetails();
});


final tournamentServiceProvider = Provider<TournamentDetailsService>((ref) {
  return TournamentDetailsService(Dio());
});
final tournamentPaginationControllerProvider = StateNotifierProvider<TournamentPaginationController>((ref) {
  final tournamentDetailsService = ref.read(tournamentServiceProvider);
  return TournamentPaginationController(tournamentDetailsService);
});
