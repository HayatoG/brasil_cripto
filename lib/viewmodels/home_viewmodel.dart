import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:brasil_cripto/models/coin_list_model.dart';
import 'package:brasil_cripto/services/coingecko_service.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  final CoingeckoService _service = CoingeckoService();

  @observable
  ObservableList<CoinListModel> allCoins = ObservableList<CoinListModel>();

  @observable
  ObservableList<String> favoriteIds = ObservableList<String>();

  @observable
  String searchQuery = '';

  @observable
  String? errorMessage;

  @computed
  List<CoinListModel> get filteredCoins {
    if (searchQuery.isEmpty) return allCoins.toList();
    return allCoins
        .where(
          (coin) => coin.name.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
  }

  @action
  void setSearchQuery(String value) {
    searchQuery = value;
  }

  @action
  Future<void> loadAllCoins() async {
    try {
      errorMessage = null;
      final coins = await _service.getMarketCoins(); // novo endpoint
      allCoins = ObservableList.of(coins);
      await loadFavorites(); // garante que favoritos carregam juntos
    } catch (e) {
      errorMessage = 'Erro ao carregar moedas: $e';
    }
  }

  @action
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('favorites') ?? [];
    favoriteIds = ObservableList.of(ids);
  }

  @action
  Future<void> toggleFavorite(String coinId) async {
    final prefs = await SharedPreferences.getInstance();

    if (favoriteIds.contains(coinId)) {
      favoriteIds.remove(coinId);
    } else {
      favoriteIds.add(coinId);
    }

    await prefs.setStringList('favorites', favoriteIds.toList());
  }

  bool isFavorite(String coinId) {
    return favoriteIds.contains(coinId);
  }
}
