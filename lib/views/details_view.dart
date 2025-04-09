import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:brasil_cripto/models/coin_list_model.dart';
import 'package:brasil_cripto/models/coin_chart_model.dart';
import 'package:brasil_cripto/models/coin_details_model.dart';
import 'package:brasil_cripto/services/coingecko_service.dart';

class DetailsView extends StatelessWidget {
  final CoinListModel coin;
  final CoingeckoService service = CoingeckoService();

  DetailsView({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(coin.name)),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([
          service.getCoinDetails(coin.id),
          service.getCoinChart(coin.id),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Erro ao carregar dados.'));
          }

          final CoinDetailsModel details = snapshot.data![0];
          final List<CoinChartModel> prices = snapshot.data![1];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.network(details.imageUrl, height: 80)),
                const SizedBox(height: 16),
                Text(
                  '${details.name} (${details.symbol.toUpperCase()})',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                const SizedBox(height: 10),
                Text(
                  '💰 Preço atual: \$${details.currentPrice.toStringAsFixed(2)}',
                ),
                Text('🏦 Market Cap: \$${_formatNumber(details.marketCap)}'),
                Text(
                  '📊 Volume de mercado (24h): \$${_formatNumber(details.volume)}',
                ),

                const SizedBox(height: 24),
                Text(
                  '📈 Gráfico de variação (7 dias):',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),

                SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      titlesData: FlTitlesData(show: false),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          color: Colors.green,
                          spots:
                              prices.asMap().entries.map((entry) {
                                final x = entry.key.toDouble();
                                final y = entry.value.price;
                                return FlSpot(x, y);
                              }).toList(),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                Text(
                  'ℹ️ Descrição do projeto:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  details.description.isEmpty
                      ? 'Nenhuma descrição disponível.'
                      : details.description,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatNumber(double value) {
    if (value >= 1e12) return '\$${(value / 1e12).toStringAsFixed(2)} T';
    if (value >= 1e9) return '\$${(value / 1e9).toStringAsFixed(2)} B';
    if (value >= 1e6) return '\$${(value / 1e6).toStringAsFixed(2)} M';
    if (value >= 1e3) return '\$${(value / 1e3).toStringAsFixed(2)} K';
    return '\$${value.toStringAsFixed(2)}';
  }
}
