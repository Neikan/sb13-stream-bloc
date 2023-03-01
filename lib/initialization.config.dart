// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes

// Package imports:
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

// Project imports:
import 'package:mtg_stream_bloc/blocs/bloc_cards/bloc_cards.dart' as _i11;
import 'package:mtg_stream_bloc/blocs/bloc_cart/bloc_cart.dart' as _i12;
import 'package:mtg_stream_bloc/services/service_card/service_card.dart' as _i7;

import 'package:mtg_stream_bloc/repository/repository_cards/repository_cards.dart'
    as _i3;
import 'package:mtg_stream_bloc/repository/repository_cards/repository_cards_imp.dart'
    as _i4;
import 'package:mtg_stream_bloc/repository/repository_cart/repository_cart.dart'
    as _i5;
import 'package:mtg_stream_bloc/repository/repository_cart/repository_cart_imp.dart'
    as _i6;
import 'package:mtg_stream_bloc/services/service_card/service_card_impl.dart'
    as _i8;
import 'package:mtg_stream_bloc/services/service_cards/service_cards.dart'
    as _i9;
import 'package:mtg_stream_bloc/services/service_cards/service_cards_impl.dart'
    as _i10;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.RepositoryCards>(() => _i4.RepositoryCardsImp());
    gh.lazySingleton<_i5.RepositoryCart>(() => _i6.RepositoryCartImp());
    gh.lazySingleton<_i7.ServiceCard>(() => _i8.ServiceCardImpl());
    gh.lazySingleton<_i9.ServiceCards>(() => _i10.ServiceCardsImpl());
    gh.factory<_i11.BlocCards>(() => _i11.BlocCards(gh<_i3.RepositoryCards>()));
    gh.factory<_i12.BlocCart>(() => _i12.BlocCart(gh<_i5.RepositoryCart>()));
    return this;
  }
}
