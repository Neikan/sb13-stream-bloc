// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart.dart';
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart_state.dart';
import 'package:mtg_stream_bloc/consts/routes.dart';
import 'package:mtg_stream_bloc/models/mtg_card_info/mtg_card_info.dart';
import 'package:mtg_stream_bloc/ui/components/app_icon_button.dart';

const int _cartCountMax = 99;

class ButtonGoToCart extends StatelessWidget {
  final List<MtgCardInfo>? cards;
  final BlocCart? blocCart;

  const ButtonGoToCart({
    super.key,
    this.cards,
    required this.blocCart,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocCartState>(
      stream: blocCart!.state,
      builder: (BuildContext _, AsyncSnapshot<BlocCartState> snapshot) {
        int count = 0;

        if (snapshot.hasData) {
          count = snapshot.data!.cards.length;
        }

        final countText = count > 0
            ? count > _cartCountMax
                ? '$_cartCountMax+'
                : '$count'
            : '';

        return AppIconButton(
          padding: const EdgeInsets.only(right: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.shopping_cart_checkout,
                color: Colors.grey,
              ),
              if (countText.isNotEmpty)
                Positioned(
                  top: 8,
                  right: 0,
                  child: Container(
                    padding: _getBadgePadding(countText),
                    decoration: _getBadgeDecoration(countText),
                    alignment: Alignment.center,
                    child: Text(
                      countText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          onPressed: () {
            final arguments = {
              'cards': cards,
              'blocCart': blocCart,
            };

            Navigator.of(context).pushNamed(
              routeCart,
              arguments: arguments,
            );
          },
        );
      },
    );
  }

  BoxDecoration _getBadgeDecoration(String countText) {
    if (countText.length > 1) {
      return BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.red.shade900,
        borderRadius: const BorderRadius.all(Radius.circular(56)),
      );
    }

    return BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.red.shade900,
    );
  }

  EdgeInsets _getBadgePadding(String countText) {
    if (countText.length > 1) {
      return const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      );
    }

    return const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 2,
    );
  }
}
