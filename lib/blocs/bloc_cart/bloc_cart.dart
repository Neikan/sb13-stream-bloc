// Dart imports:
import 'dart:async';

// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart_event.dart';
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart_state.dart';
import 'package:mtg_stream_bloc/repository/repository_cart/repository_cart.dart';

@injectable
class BlocCart {
  final RepositoryCart _repositoryCart;

  final _controllerState = StreamController<BlocCartState>.broadcast();
  final _controllerEvents = StreamController<BlocCartEvent>();

  Stream<BlocCartState> get state => _controllerState.stream;
  Sink<BlocCartEvent> get event => _controllerEvents.sink;

  BlocCartState _currentState = const BlocCartState(
    cards: [],
  );

  BlocCart(this._repositoryCart) {
    _controllerEvents.stream.listen(_handleEvents);
  }

  void dispose() {
    _controllerState.close();
    _controllerEvents.close();
  }

  void _handleEvents(BlocCartEvent event) {
    if (event is BlocCartEventInit) _init();

    if (event is BlocCartEventAdd) _add(event);

    if (event is BlocCartEventRemove) _remove(event);

    _controllerState.add(_currentState);
  }

  void _init() {
    _setState();
  }

  void _add(BlocCartEventAdd event) {
    _repositoryCart.add(event.cardId);

    _setState();
  }

  void _remove(BlocCartEventRemove event) async {
    _repositoryCart.remove(event.cardId);

    _setState();
  }

  void _setState() {
    _currentState = _currentState.copyWith(cards: _repositoryCart.data);
  }
}
