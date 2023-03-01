// Dart imports:
import 'dart:async';

// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mtg_stream_bloc/blocs/bloc_cards/bloc_cards_event.dart';
import 'package:mtg_stream_bloc/blocs/bloc_cards/bloc_cards_state.dart';
import 'package:mtg_stream_bloc/repository/repository_cards/repository_cards.dart';

@injectable
class BlocCards {
  final RepositoryCards _repositoryCards;

  final _controllerState = StreamController<BlocCardsState>.broadcast();
  final _controllerEvents = StreamController<BlocCardsEvent>();

  Stream<BlocCardsState> get state => _controllerState.stream;
  Sink<BlocCardsEvent> get event => _controllerEvents.sink;

  BlocCardsState _currentState = const BlocCardsState(
    cards: [],
    error: '',
    isLoading: true,
  );

  BlocCards(this._repositoryCards) {
    _controllerEvents.stream.listen(_handleEvents);
  }

  void dispose() {
    _controllerState.close();
    _controllerEvents.close();
  }

  Future<void> _handleEvents(BlocCardsEvent event) async {
    if (event is BlocCardsEventInit) await _init();

    _controllerState.add(_currentState);
  }

  Future<void> _init() async {
    try {
      final cards = await _repositoryCards.load();

      _currentState = _currentState.copyWith(
        cards: cards,
        isLoading: false,
      );
    } on DioError catch (e) {
      _currentState = _currentState.copyWith(
        error: e.error.toString(),
        isLoading: false,
      );
    }
  }
}
