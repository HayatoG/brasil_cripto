import 'dart:convert';
import 'package:brasil_cripto/models/coin_chart_model.dart';
import 'package:brasil_cripto/models/coin_details_model.dart';
import 'package:brasil_cripto/models/coin_list_model.dart';
import 'package:http/http.dart' as http;

class CoingeckoService {
  Future<List<CoinListModel>> getMarketCoins() async {
    final url = Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets'
      '?vs_currency=usd'
      '&order=market_cap_desc'
      '&per_page=100'
      '&page=1'
      '&sparkline=true'
      '&price_change_percentage=24h',
    );

    final response = await http.get(
      url,
      headers: {'x-cg-demo-api-key': 'CG-Nz76dkEfb56bka58xdvAuCj7'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => CoinListModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar dados do mercado.');
    }
  }

  // Future<List<CoinListModel>> getListCoins() async {
  //   try {
  //     // final url = Uri.parse('https://api.coingecko.com/api/v3/coins/list');
  //     final url = Uri.parse(
  //       "https://api.coingecko.com/api/v3/coins/list?include_platform=true",
  //     );

  //     final response = await http.get(
  //       url,
  //       headers: {'x-cg-demo-api-key': 'CG-Nz76dkEfb56bka58xdvAuCj7'},
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = jsonDecode(response.body);
  //       return data.map((e) => CoinListModel.fromJson(e)).toList();
  //     } else {
  //       throw Exception(
  //         'Erro ao buscar lista de moedas: ${response.statusCode}',
  //       );
  //     }
  //   } catch (e) {
  //     throw Exception('Falha ao carregar moedas: $e');
  //   }
  // }

  Future<List<CoinChartModel>> getCoinChart(String coinId) async {
    final url = Uri.parse(
      'https://api.coingecko.com/api/v3/coins/$coinId/market_chart?vs_currency=usd&days=7',
    );

    final response = await http.get(
      url,
      headers: {'x-cg-demo-api-key': 'CG-Nz76dkEfb56bka58xdvAuCj7'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List prices = data['prices'];

      return prices.map((e) => CoinChartModel.fromList(e)).toList();
    } else {
      throw Exception('Erro ao buscar gráfico de $coinId');
    }
  }

  Future<CoinDetailsModel> getCoinDetails(String coinId) async {
    final url = Uri.parse('https://api.coingecko.com/api/v3/coins/$coinId');

    final response = await http.get(
      url,
      headers: {'x-cg-demo-api-key': 'CG-Nz76dkEfb56bka58xdvAuCj7'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CoinDetailsModel.fromJson(data);
    } else {
      throw Exception('Erro ao buscar detalhes de $coinId');
    }
  }
}
