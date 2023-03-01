// Package imports:
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mtg_stream_bloc/models/mtg_card_info/mtg_card_info.dart';
import 'package:mtg_stream_bloc/models/mtg_cards/mtg_cards.dart';
import 'package:mtg_stream_bloc/repository/repository_cards/repository_cards.dart';
import 'package:mtg_stream_bloc/services/service_cards/service_cards.dart';

@LazySingleton(as: RepositoryCards)
class RepositoryCardsImp extends RepositoryCards {
  const RepositoryCardsImp();

  static List<MtgCardInfo> state = [];

    @override
  List<MtgCardInfo> get data => state;

  @override
  Future<List<MtgCardInfo>> load() async {
    final response = await GetIt.I.get<ServiceCards>().getCards();

    if (response.statusCode == 200) {
      final MtgCards mtgCards = MtgCards.fromJson(response.data);

      state = [...mtgCards.cards];
    }

    return state;
  }
}
