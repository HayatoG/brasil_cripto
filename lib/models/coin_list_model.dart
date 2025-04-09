class CoinListModel {
  final String id;
  final String name;
  final String symbol;
  final String imageUrl;
  final double price;
  final double change24h;
  final double volume;
  final List<double> sparkline;

  CoinListModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change24h,
    required this.volume,
    required this.sparkline,
  });

  factory CoinListModel.fromJson(Map<String, dynamic> json) {
    return CoinListModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      imageUrl: json['image'] ?? '',
      price: json['current_price']?.toDouble() ?? 0.0,
      change24h: json['price_change_percentage_24h']?.toDouble() ?? 0.0,
      volume: json['total_volume']?.toDouble() ?? 0.0,
      sparkline:
          json['sparkline_in_7d'] != null
              ? List<double>.from(json['sparkline_in_7d']['price'] ?? [])
              : [],
    );
  }
}
