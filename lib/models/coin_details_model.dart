class CoinDetailsModel {
  final String id;
  final String name;
  final String symbol;
  final String description;
  final String imageUrl;
  final double currentPrice;
  final double marketCap;
  final double volume;

  CoinDetailsModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.description,
    required this.imageUrl,
    required this.currentPrice,
    required this.marketCap,
    required this.volume,
  });

  factory CoinDetailsModel.fromJson(Map<String, dynamic> json) {
    return CoinDetailsModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      description: json['description']['en'] ?? '',
      imageUrl: json['image']['large'] ?? '',
      currentPrice:
          json['market_data']['current_price']['usd']?.toDouble() ?? 0.0,
      marketCap: json['market_data']['market_cap']['usd']?.toDouble() ?? 0.0,
      volume: json['market_data']['total_volume']['usd']?.toDouble() ?? 0.0,
    );
  }
}
