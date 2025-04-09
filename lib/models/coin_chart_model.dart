class CoinChartModel {
  final DateTime time;
  final double price;

  CoinChartModel({required this.time, required this.price});

  factory CoinChartModel.fromList(List<dynamic> list) {
    return CoinChartModel(
      time: DateTime.fromMillisecondsSinceEpoch(list[0]),
      price: list[1].toDouble(),
    );
  }
}
