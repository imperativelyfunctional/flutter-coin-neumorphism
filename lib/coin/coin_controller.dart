import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/coingecko_result.dart';
import 'package:coingecko_api/data/coin_short.dart';
import 'package:coingecko_api/data/market.dart';
import 'package:cryto/coin/model.dart';
import 'package:cryto/i18n/app_translations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CoinController extends GetxController {
  final _coinApi = CoinGeckoApi();

  final _fetching = true;

  List<MarketRow> markets = [];

  var showCoins = false.obs;
  var indexOfTab = 0.obs;
  var version = "".obs;

  var langGroupValue = (GetStorage().read<int>('locale') ?? 0).obs;

  clearData() {
    for (var element in markets) {
      element.favorite.value = false;
    }
  }

  getVersion() {
    PackageInfo.fromPlatform().then((value) {
      version.value = "${value.version} - Build:${value.buildNumber}";
    }).onError((error, stackTrace) {});
  }

  updateTabIndex(index) {
    indexOfTab.value = index;
  }

  favoriteMarket(MarketRow market) {
    market.favorite.value = !market.favorite.value;
  }

  updateLang(index) {
    langGroupValue.value = index;
    switch (index) {
      case 0:
        Get.updateLocale(localeEn);
        GetStorage().write('locale', 0);
        break;
      case 1:
        Get.updateLocale(localeZhCN);
        GetStorage().write('locale', 1);
        break;
      default:
        Get.updateLocale(localeZhHK);
        GetStorage().write('locale', 2);
        break;
    }
  }

  Future<CoinGeckoResult<List<CoinShort>>> getCoins() {
    return _coinApi.coins.listCoins();
  }

  Future<CoinGeckoResult<List<Market>>> getCoinMarkets(
      String currency, List<String> ids) {
    return _coinApi.coins.listCoinMarkets(
        vsCurrency: currency,
        coinIds: ids,
        sparkline: true,
        priceChangePercentageIntervals: ['24h', '7d']);
  }

  Future<CoinGeckoResult<List<Market>>> getTop100CoinMarketsByMarketCap(
    String currency,
  ) {
    return _coinApi.coins.listCoinMarkets(
        vsCurrency: currency,
        sparkline: true,
        priceChangePercentageIntervals: ['24h', '7d']);
  }

  bool get getFetchingCoinMarkets {
    return _fetching;
  }

  set setFetchingCoinMarket(fetching) {
    fetching = fetching;
  }

  set setMarkets(List<Market> markets) {
    var marketRows = markets.map((e) => MarketRow(false.obs, e)).toList();
    marketRows
        .sort((a, b) => b.market.marketCap!.compareTo(a.market.marketCap!));
    this.markets = marketRows;
  }

  List<MarketRow> get getMarkets {
    return markets;
  }

  void updateShowCoins(bool value) {
    showCoins.value = value;
    update();
  }
}
