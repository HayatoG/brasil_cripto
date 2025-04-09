import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:brasil_cripto/viewmodels/home_viewmodel.dart';

class FavoritesView extends StatelessWidget {
  final HomeViewModel viewModel;

  const FavoritesView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: Observer(
        builder: (_) {
          final coins =
              viewModel.allCoins
                  .where((coin) => viewModel.isFavorite(coin.id))
                  .toList();

          if (coins.isEmpty) {
            return const Center(child: Text('Nenhuma moeda favorita'));
          }

          return ListView.builder(
            itemCount: coins.length,
            itemBuilder: (context, index) {
              final coin = coins[index];
              return ListTile(
                title: Text(coin.name),
                subtitle: Text(coin.symbol.toUpperCase()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: const Text('Remover'),
                            content: Text('Deseja remover ${coin.name}?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  viewModel.toggleFavorite(coin.id);
                                  Navigator.pop(context);
                                },
                                child: const Text('Remover'),
                              ),
                            ],
                          ),
                    );
                  },
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/details', arguments: coin);
                },
              );
            },
          );
        },
      ),
    );
  }
}
