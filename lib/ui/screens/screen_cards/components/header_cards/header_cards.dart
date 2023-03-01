// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart.dart';
import 'package:mtg_stream_bloc/consts/translations.dart';
import 'package:mtg_stream_bloc/models/mtg_card_info/mtg_card_info.dart';
import 'package:mtg_stream_bloc/ui/components/app_header.dart';
import 'package:mtg_stream_bloc/ui/components/app_icon_button.dart';
import 'package:mtg_stream_bloc/ui/screens/screen_cards/components/header_cards/button_go_to_cart.dart';

class HeaderCards extends StatelessWidget implements PreferredSizeWidget {
  final List<MtgCardInfo>? cards;
  final BlocCart? blocCart;
  final bool? isListView;
  final VoidCallback? onSwitchView;

  const HeaderCards({
    super.key,
    this.cards,
    this.blocCart,
    this.isListView,
    this.onSwitchView,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final checkIsListView = isListView == true;

    return AppHeader(
      title: labelCards,
      actions: isListView != null
          ? [
              AppIconButton(
                onPressed: !checkIsListView ? onSwitchView : null,
                child: Icon(
                  Icons.list_rounded,
                  color: checkIsListView ? Colors.red.shade900 : Colors.grey,
                ),
              ),
              AppIconButton(
                onPressed: checkIsListView ? onSwitchView : null,
                child: Icon(
                  Icons.apps_rounded,
                  color: !checkIsListView ? Colors.red.shade900 : Colors.grey,
                ),
              ),
              ButtonGoToCart(
                cards: cards,
                blocCart: blocCart,
              ),
            ]
          : null,
    );
  }
}
