import 'package:cryto/coin/coin_list_tab.dart';
import 'package:cryto/coin/favorite_tab.dart';
import 'package:cryto/coin/settings_tab.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'coin_controller.dart';

class CoinListView extends GetView<CoinController> {
  const CoinListView({Key? key}) : super(key: key);

  @override
  StatelessElement createElement() {
    controller.getTop100CoinMarketsByMarketCap('usd').then((value) {
      controller.setMarkets = value.data;
      controller.updateShowCoins(true);
    }).onError((error, stackTrace) {
      //TODO Error handling should be implemented for production app
    });
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(
          () {
            return BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: controller.indexOfTab.value,
              unselectedIconTheme: IconThemeData(color: Colors.grey.shade400),
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              onTap: (index) => {controller.updateTabIndex(index)},
              items: [
                BottomNavigationBarItem(
                    icon: Neumorphic(
                      style: const NeumorphicStyle(
                          shadowDarkColor: Colors.blueGrey,
                          color: Colors.white),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(FontAwesomeIcons.chartLine),
                      ),
                    ),
                    activeIcon: Neumorphic(
                      style: const NeumorphicStyle(
                          depth: -2,
                          shadowDarkColor: Colors.blueGrey,
                          color: Colors.white),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          FontAwesomeIcons.chartLine,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    label: 'top100'.tr),
                BottomNavigationBarItem(
                    icon: Neumorphic(
                      style: const NeumorphicStyle(
                          shadowDarkColor: Colors.blueGrey,
                          color: Colors.white),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(FontAwesomeIcons.heart),
                      ),
                    ),
                    activeIcon: Neumorphic(
                      style: const NeumorphicStyle(
                          depth: -2,
                          shadowDarkColor: Colors.blueGrey,
                          color: Colors.white),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          FontAwesomeIcons.heart,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                    label: 'favorite'.tr),
                BottomNavigationBarItem(
                    icon: Neumorphic(
                      style: const NeumorphicStyle(
                          shadowDarkColor: Colors.blueGrey,
                          color: Colors.white),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(FontAwesomeIcons.wrench),
                      ),
                    ),
                    activeIcon: Neumorphic(
                      style: const NeumorphicStyle(
                          depth: -2,
                          shadowDarkColor: Colors.blueGrey,
                          color: Colors.white),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          FontAwesomeIcons.wrench,
                          color: Colors.amberAccent,
                        ),
                      ),
                    ),
                    label: 'settings'.tr),
              ],
            );
          },
        ),
        body: CustomScrollView(slivers: [
          SliverAppBar(
              backgroundColor: Colors.black,
              pinned: true,
              automaticallyImplyLeading: false,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'coinListTitle'.tr,
                  style: GoogleFonts.aleo(color: Colors.amberAccent),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'images/chart.jpeg',
                      fit: BoxFit.fill,
                    ),
                    Row(
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        Flexible(
                            flex: 6,
                            child: Opacity(
                              opacity: 0.6,
                              child: Image.asset(
                                'images/tokens.png',
                              ),
                            )),
                        const Spacer(
                          flex: 2,
                        )
                      ],
                    )
                  ],
                ),
              )),
          Obx(() {
            if (controller.indexOfTab.value == 0) {
              return prepareCoinList(controller, context);
            } else if (controller.indexOfTab.value == 1) {
              return renderFavoriteTab();
            } else {
              return renderSettingsTab(controller);
            }
          }),
        ]));
  }
}
