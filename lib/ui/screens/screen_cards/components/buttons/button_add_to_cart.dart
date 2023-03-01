// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart.dart';
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart_event.dart';

class ButtonAddToCart extends StatelessWidget {
  final String cardId;
  final BlocCart blocCart;

  const ButtonAddToCart({
    super.key,
    required this.cardId,
    required this.blocCart,
  });

  @override
  Widget build(BuildContext context) {
    List<String> cardsInCart = [];

    return StreamBuilder(
      stream: blocCart.state,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          cardsInCart = snapshot.data!.cards;
        }

        if (cardsInCart.contains(cardId)) {
          return IconButton(
            icon: Icon(
              Icons.remove_shopping_cart_outlined,
              color: Colors.red.shade800,
            ),
            onPressed: () => blocCart.event.add(BlocCartEventRemove(cardId)),
          );
        }

        return IconButton(
          icon: Icon(
            Icons.add_shopping_cart_outlined,
            color: Colors.green.shade800,
          ),
          onPressed: () => blocCart.event.add(BlocCartEventAdd(cardId)),
        );
      },
    );
  }
}
