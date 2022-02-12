import 'package:coingecko_api/data/market.dart';
import 'package:get/get.dart';

class MarketRow {
  var favorite = false.obs;
  final Market market;

  MarketRow(this.favorite, this.market);
}
