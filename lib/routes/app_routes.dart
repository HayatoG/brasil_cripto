import 'package:flutter/material.dart';

import 'package:brasil_cripto/views/home_view.dart';
import 'package:brasil_cripto/views/details_view.dart';
import 'package:brasil_cripto/views/favorites_view.dart';
import 'package:brasil_cripto/models/coin_list_model.dart';
import 'package:brasil_cripto/viewmodels/home_viewmodel.dart';

class AppRoutes {
  static const String home = '/';
  static const String favorites = '/favorites';
  static const String details = '/details';

  static final HomeViewModel sharedViewModel = HomeViewModel();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        sharedViewModel.loadAllCoins(); // importante carregar uma vez
        return MaterialPageRoute(
          builder: (_) => HomeView(homeViewModel: sharedViewModel),
        );
      case favorites:
        return MaterialPageRoute(
          builder: (_) => FavoritesView(viewModel: sharedViewModel),
        );
      case details:
        final coin = settings.arguments as CoinListModel;
        return MaterialPageRoute(builder: (_) => DetailsView(coin: coin));
      default:
        return MaterialPageRoute(
          builder: (_) => HomeView(homeViewModel: sharedViewModel),
        );
    }
  }
}
