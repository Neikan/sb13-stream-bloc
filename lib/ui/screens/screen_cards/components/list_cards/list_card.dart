// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart.dart';
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart_event.dart';
import 'package:mtg_stream_bloc/consts/keys.dart';
import 'package:mtg_stream_bloc/models/mtg_card_info/mtg_card_info.dart';
import 'package:mtg_stream_bloc/ui/screens/screen_cards/components/list_cards/list_card_preview.dart';

class ListCards extends StatefulWidget {
  final List<MtgCardInfo> cards;
  final BlocCart blocCart;

  const ListCards({
    super.key,
    required this.cards,
    required this.blocCart,
  });

  @override
  State<ListCards> createState() => _ScreenCardsState();
}

class _ScreenCardsState extends State<ListCards> {
  late BlocCart _blocCart;

  @override
  void initState() {
    _blocCart = widget.blocCart;
    _blocCart.event.add(BlocCartEventInit());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const PageStorageKey(keyCardsList),
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemCount: widget.cards.length,
      itemBuilder: (_, index) => ListCardPreview(
        card: widget.cards[index],
        blocCart: _blocCart,
      ),
    );
  }
}
