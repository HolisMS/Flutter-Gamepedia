import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamebot/bloc/games_event.dart';
import 'package:gamebot/bloc/games_state.dart';
import 'package:gamebot/model/games_model.dart';
import 'package:gamebot/repository/repository_games.dart';

class GamePopularBloc extends Bloc<GamesEvent, GamesState> {
  final RepositoryGames repository;

  GamePopularBloc(this.repository) : super(GameInitialstate());

  @override
  Stream<GamesState> mapEventToState(GamesEvent event) async* {
    if (event is FetchGamesPopularEvent) {
      yield* _getAllGames();
    }
  }

  Stream<GamesState> _getAllGames() async* {
    try {
      yield GameLoadingState();

      List<GamesModel> games = await repository.getGamesPopular();

      yield GameLoadedState(games);
    } catch (e) {
      print(e);
      yield GameErrorState(e.toString());
    }
  }
}
