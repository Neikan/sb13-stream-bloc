// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart.dart';
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart_event.dart';
import 'package:mtg_stream_bloc/consts/keys.dart';
import 'package:mtg_stream_bloc/consts/translations.dart';
import 'package:mtg_stream_bloc/models/mtg_card_info/mtg_card_info.dart';
import 'package:mtg_stream_bloc/ui/components/app_header.dart';
import 'package:mtg_stream_bloc/ui/components/app_text.dart';
import 'package:mtg_stream_bloc/ui/screens/screen_cards/components/list_cards/list_card.dart';

class ScreenCart extends StatefulWidget {
  final List<MtgCardInfo> cards;
  final BlocCart blocCart;

  const ScreenCart({
    super.key,
    required this.cards,
    required this.blocCart,
  });

  @override
  State<ScreenCart> createState() => _ScreenCardsState();
}

class _ScreenCardsState extends State<ScreenCart> {
  late BlocCart _blocCart;

  @override
  void initState() {
    _blocCart = widget.blocCart;
    _blocCart.event.add(BlocCartEventInit());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _blocCart.state,
      builder: (_, snapshotCart) {
        List<String> cardsInCart = [];

        final cardsToList = <MtgCardInfo>[];

        if (snapshotCart.hasData) {
          cardsInCart = snapshotCart.data!.cards;
        }

        for (final card in widget.cards) {
          if (cardsInCart.contains(card.id)) {
            cardsToList.add(card);
          }
        }

        return Scaffold(
          appBar: AppHeader(
            title: labelsCart[keyTitle]!,
          ),
          body: SafeArea(
            child: cardsInCart.isEmpty
                ? Center(
                    child: AppText(
                      text: labelsCart[keyContent]!,
                      fontSize: 16,
                    ),
                  )
                : ListCards(
                    cards: cardsToList,
                    blocCart: _blocCart,
                  ),
          ),
        );
      },
    );
  }
}
