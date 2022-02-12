import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:cryto/coin/coin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

prepareCoinList(CoinController controller, BuildContext context) {
  return Obx(() {
    return controller.showCoins.value
        ? SlidableAutoCloseBehavior(
            child: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                var marketRow = controller.markets[index];
                var market = marketRow.market;
                var prices = market.sparklineIn7d!.price;
                var priceIncreased = prices.last - prices.first >= 0;
                var marketNameWidth =
                    MediaQuery.of(context).size.width / 3 - 60;
                return Obx(() {
                  var favorite = marketRow.favorite.value;
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      ),
                      color: Colors.white,
                    ),
                    child: Slidable(
                      groupTag: 'a',
                      startActionPane: ActionPane(
                        extentRatio: 1 / 4,
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) =>
                                {controller.favoriteMarket(marketRow)},
                            backgroundColor: Colors.amberAccent,
                            foregroundColor:
                                favorite ? Colors.red : Colors.white,
                            icon: Icons.favorite,
                            label: 'favorite'.tr,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 40.0,
                                    height: 40.0,
                                    child: Image.network(market.image!),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: marketNameWidth,
                                        child: Text(
                                          market.name,
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          style: favorite
                                              ? GoogleFonts.lato(
                                                  color: Colors.redAccent,
                                                  fontWeight: FontWeight.bold,
                                                  backgroundColor:
                                                      Colors.amberAccent)
                                              : GoogleFonts.lato(
                                                  color: Colors.lightBlue),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        '${index + 1}. ${market.symbol.toUpperCase()}',
                                        style: GoogleFonts.lato(
                                            color: Colors.black),
                                      ),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Text(
                                      '\$${market.currentPrice}',
                                      style: GoogleFonts.roboto(
                                          color: Colors.amber),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      child: Sparkline(
                                        lineColor: priceIncreased
                                            ? Colors.green
                                            : Colors.red,
                                        data: prices,
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  children: [
                                    Text(
                                      '1d %: ${market.priceChangePercentage24h?.toStringAsFixed(2)}',
                                      style: GoogleFonts.lato(
                                          color: Colors.purple),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      '7d %: ${market.priceChangePercentage7dInCurrency?.toStringAsFixed(2)}',
                                      style: GoogleFonts.lato(
                                          color: Colors.deepPurpleAccent),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      '1d \$: ${market.priceChange24h?.toStringAsFixed(2)}',
                                      style:
                                          GoogleFonts.lato(color: Colors.teal),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
              }, childCount: controller.markets.length),
            ),
          )
        : SliverToBoxAdapter(
            child: Shimmer.fromColors(
              direction: ShimmerDirection.ltr,
              baseColor: Colors.green[300]!,
              highlightColor: Colors.green[100]!,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, __) => Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 45.0,
                                  height: 45.0,
                                  color: Colors.purple,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 100,
                                      color: Colors.purple,
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      height: 10,
                                      width: 100,
                                      color: Colors.purple,
                                    ),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  itemCount: 20,
                ),
              ),
            ),
          );
  });
}
