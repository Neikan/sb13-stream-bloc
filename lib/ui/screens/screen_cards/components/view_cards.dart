// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart.dart';
import 'package:mtg_stream_bloc/models/mtg_card_info/mtg_card_info.dart';
import 'package:mtg_stream_bloc/ui/screens/screen_cards/components/grid_cards/grid_cards.dart';
import 'package:mtg_stream_bloc/ui/screens/screen_cards/components/header_cards/header_cards.dart';
import 'package:mtg_stream_bloc/ui/screens/screen_cards/components/list_cards/list_card.dart';

class ViewCards extends StatefulWidget {
  final List<MtgCardInfo> cards;
  final BlocCart blocCart;

  const ViewCards({
    super.key,
    required this.cards,
    required this.blocCart,
  });

  @override
  State<ViewCards> createState() => _ViewCardsState();
}

class _ViewCardsState extends State<ViewCards> {
  bool isListView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderCards(
        cards: widget.cards,
        blocCart: widget.blocCart,
        isListView: isListView,
        onSwitchView: _handleSwitchView,
      ),
      body: SafeArea(
        child: isListView
            ? ListCards(
                cards: widget.cards,
                blocCart: widget.blocCart,
              )
            : GridCards(
                cards: widget.cards,
                blocCart: widget.blocCart,
              ),
      ),
    );
  }

  void _handleSwitchView() {
    setState(() {
      isListView = !isListView;
    });
  }
}
