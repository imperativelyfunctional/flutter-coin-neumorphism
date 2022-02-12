import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cryto/coin/coin_binding.dart';
import 'package:cryto/coin/coin_list.dart';
import 'package:cryto/i18n/app_translations.dart';
import 'package:cryto/main/main_binding.dart';
import 'package:cryto/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  Locale _getLocale() {
    var locale = GetStorage().read<int>("locale");
    if (locale == null) {
      return Get.deviceLocale ?? localeEn;
    } else {
      switch (locale) {
        case 1:
          return localeZhCN;
        case 2:
          return localeZhHK;
        default:
          return localeEn;
      }
    }
  }

  await GetStorage.init();
  runApp(GetMaterialApp(
      translations: AppTranslations(),
      locale: _getLocale(),
      initialBinding: MainBinding(),
      getPages: [
        GetPage(name: '/', page: () => const Home(), binding: MainBinding()),
        GetPage(
            name: '/coins',
            page: () => const CoinListView(),
            binding: CoinBinding())
      ],
      debugShowCheckedModeBanner: false,
      title: 'appName'.tr,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Home()));
}

class Home extends GetView<MainController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.checkServer) {
      controller.ping().then((value) {
        var serverUp = value.data;
        controller.updateServerStatus(serverUp);
        if (serverUp) {
          Timer(const Duration(seconds: 5), () {
            Get.offNamed('coins');
          });
        }
      }).onError((error, stackTrace) {
        Get.snackbar('warning'.tr, 'issueConnectingToCoingecko'.tr,
            backgroundColor: Colors.amber, snackPosition: SnackPosition.BOTTOM);
      });
      controller.checkServer = false;
    }
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'images/chart.png',
                    fit: BoxFit.contain,
                  ),
                  FadeInLeft(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: BounceInDown(
                            child: Text(
                              'appName'.tr,
                              style: GoogleFonts.alfaSlabOne(
                                  color: Colors.orange, fontSize: 30),
                            ),
                          ),
                          flex: 8,
                        ),
                        Flexible(
                          child: Spin(
                            delay: const Duration(seconds: 2),
                            child: Image.asset(
                              'images/moon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: FlipInX(
                          delay: const Duration(seconds: 1),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset('images/eth.png')))),
                  Flexible(
                      flex: 1,
                      child: FlipInY(
                          delay: const Duration(seconds: 2),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset('images/bit.png')))),
                  Flexible(
                      flex: 1,
                      child: FlipInX(
                          delay: const Duration(seconds: 1),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset('images/ada.png')))),
                  Flexible(
                      flex: 1,
                      child: FlipInY(
                          delay: const Duration(seconds: 2),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset('images/polkadot.png')))),
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SpinKitHourGlass(
                      duration: Duration(seconds: 1),
                      color: Colors.lightBlue,
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FadeIn(
                      child: Text(
                        'checkingServerStatus'.tr,
                        style: const TextStyle(
                            color: Colors.amber, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ))
          ],
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bg.jpg'), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
