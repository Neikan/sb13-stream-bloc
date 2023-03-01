// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart.dart';
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart_event.dart';
import 'package:mtg_stream_bloc/consts/keys.dart';
import 'package:mtg_stream_bloc/models/mtg_card_info/mtg_card_info.dart';
import 'package:mtg_stream_bloc/ui/screens/screen_cards/components/grid_cards/grid_card_preview.dart';

class GridCards extends StatefulWidget {
  final List<MtgCardInfo> cards;
  final BlocCart blocCart;

  const GridCards({
    super.key,
    required this.cards,
    required this.blocCart,
  });

  @override
  State<GridCards> createState() => _GridCardsState();
}

class _GridCardsState extends State<GridCards> {
  late BlocCart _blocCart;

  @override
  void initState() {
    _blocCart = widget.blocCart;
    _blocCart.event.add(BlocCartEventInit());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const PageStorageKey(keyCardsGrid),
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
      ),
      itemCount: widget.cards.length,
      itemBuilder: (_, index) => GridCardPreview(
        card: widget.cards[index],
        blocCart: _blocCart,
      ),
    );
  }
}
