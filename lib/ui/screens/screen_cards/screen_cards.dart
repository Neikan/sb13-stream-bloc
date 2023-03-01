// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:mtg_stream_bloc/blocs/bloc_cards/bloc_cards.dart';
import 'package:mtg_stream_bloc/blocs/bloc_cards/bloc_cards_event.dart';
import 'package:mtg_stream_bloc/blocs/bloc_cards/bloc_cards_state.dart';
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart.dart';
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart_event.dart';
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart_state.dart';
import 'package:mtg_stream_bloc/ui/components/app_error_data.dart';
import 'package:mtg_stream_bloc/ui/screens/screen_cards/components/header_cards/header_cards.dart';
import 'package:mtg_stream_bloc/ui/screens/screen_cards/components/loader_cards.dart';
import 'package:mtg_stream_bloc/ui/screens/screen_cards/components/view_cards.dart';

class ScreenCards extends StatefulWidget {
  const ScreenCards({super.key});

  @override
  State<ScreenCards> createState() => _ScreenCardsState();
}

class _ScreenCardsState extends State<ScreenCards> {
  late BlocCards _blocCards;
  late BlocCart _blocCart;

  @override
  void initState() {
    _blocCart = GetIt.I.get<BlocCart>();
    _blocCart.event.add(BlocCartEventInit());

    _blocCards = GetIt.I.get<BlocCards>();
    _blocCards.event.add(BlocCardsEventInit());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocCartState>(
      stream: _blocCart.state,
      builder: (_, snapshotCart) {
        if (snapshotCart.hasData) {
          return StreamBuilder<BlocCardsState>(
            stream: _blocCards.state,
            builder: (_, snapshotCards) {
              if (!snapshotCards.hasData) return const LoaderCards();

              if (snapshotCards.hasError) {
                return Scaffold(
                  appBar: HeaderCards(blocCart: _blocCart),
                  body: AppErrorData(text: snapshotCards.data!.error),
                );
              }

              if (snapshotCards.data!.isLoading) return const LoaderCards();

              return ViewCards(
                cards: snapshotCards.data!.cards,
                blocCart: _blocCart,
              );
            },
          );
        }

        return const LoaderCards();
      },
    );
  }

  @override
  void dispose() {
    _blocCards.dispose();
    // _blocCart.dispose();

    super.dispose();
  }
}
