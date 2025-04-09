import 'package:brasil_cripto/viewmodels/home_viewmodel.dart';
import 'package:brasil_cripto/views/favorites_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel homeViewModel;

  HomeView({super.key, required this.homeViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brasil Cripto'),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.star),
          onPressed: () {
            Navigator.pushNamed(context, '/favorites');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              onChanged: homeViewModel.setSearchQuery,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Digite o nome da criptomoeda desejada',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Observer(
                builder: (_) {
                  final coins = homeViewModel.filteredCoins;

                  if (homeViewModel.errorMessage != null) {
                    return Center(child: Text(homeViewModel.errorMessage!));
                  }

                  if (homeViewModel.allCoins.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (coins.isEmpty) {
                    return const Center(
                      child: Text('Nenhuma criptomoeda encontrada'),
                    );
                  }

                  return ListView.builder(
                    itemCount: coins.length,
                    itemBuilder: (context, index) {
                      final coin = coins[index];
                      final price =
                          coin.price.isNaN
                              ? '0.00'
                              : coin.price.toStringAsFixed(2);
                      final change =
                          coin.change24h.isNaN
                              ? '0.00'
                              : coin.change24h.toStringAsFixed(2);
                      final volume =
                          coin.volume.isNaN
                              ? '0'
                              : coin.volume.toStringAsFixed(0);
                      final sparkline = coin.sparkline; // List<double>

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          title: Text(
                            '${coin.name} (${coin.symbol.toUpperCase()})',
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('💰 Preço: \$ $price'),
                              Text(
                                '📈 Variação 24h: $change%',
                                style: TextStyle(
                                  color:
                                      coin.change24h >= 0
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                              Text('📊 Volume: \$ $volume'),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 40,
                                child:
                                    sparkline.isNotEmpty
                                        ? LineChart(
                                          LineChartData(
                                            gridData: FlGridData(show: false),
                                            titlesData: FlTitlesData(
                                              show: false,
                                            ),
                                            borderData: FlBorderData(
                                              show: false,
                                            ),
                                            lineBarsData: [
                                              LineChartBarData(
                                                isCurved: true,
                                                color: Colors.green,
                                                dotData: FlDotData(show: false),
                                                spots:
                                                    sparkline
                                                        .asMap()
                                                        .entries
                                                        .map((e) {
                                                          return FlSpot(
                                                            e.key.toDouble(),
                                                            e.value,
                                                          );
                                                        })
                                                        .toList(),
                                              ),
                                            ],
                                          ),
                                        )
                                        : const Text('Sem gráfico disponível'),
                              ),
                            ],
                          ),
                          trailing: Observer(
                            builder: (context) {
                              return IconButton(
                                icon: Icon(
                                  homeViewModel.isFavorite(coin.id)
                                      ? Icons.star
                                      : Icons.star_border,
                                  color:
                                      homeViewModel.isFavorite(coin.id)
                                          ? Colors.amber
                                          : Colors.grey,
                                ),
                                onPressed:
                                    () => homeViewModel.toggleFavorite(coin.id),
                              );
                            },
                          ),

                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/details',
                              arguments: coin,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
