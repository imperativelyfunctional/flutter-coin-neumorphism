import 'package:cryto/coin/coin_controller.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

renderSettingsTab(CoinController controller) {
  controller.getVersion();
  return SliverList(
      delegate: SliverChildListDelegate.fixed([
    Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey.shade400),
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NeumorphicIcon(
                  FontAwesomeIcons.language,
                  style: const NeumorphicStyle(color: Colors.amber),
                ),
                Obx(() {
                  return Row(children: [
                    NeumorphicRadio(
                      style: NeumorphicRadioStyle(
                          selectedColor: Colors.blue,
                          unselectedColor: Colors.lightBlue.shade200),
                      groupValue: controller.langGroupValue.value,
                      value: 0,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "EN",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onChanged: (value) {
                        controller.updateLang(value);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    NeumorphicRadio(
                      style: NeumorphicRadioStyle(
                          selectedColor: Colors.blue,
                          unselectedColor: Colors.lightBlue.shade200),
                      groupValue: controller.langGroupValue.value,
                      value: 1,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "简体",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onChanged: (value) {
                        controller.updateLang(value);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    NeumorphicRadio(
                      style: NeumorphicRadioStyle(
                          selectedColor: Colors.blue,
                          unselectedColor: Colors.lightBlue.shade200),
                      groupValue: controller.langGroupValue.value,
                      value: 2,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "繁體",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onChanged: (value) {
                        controller.updateLang(value);
                      },
                    ),
                  ]);
                })
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey.shade400),
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NeumorphicIcon(
                  FontAwesomeIcons.list,
                  style: const NeumorphicStyle(color: Colors.green),
                ),
                NeumorphicButton(
                  style: const NeumorphicStyle(color: Colors.deepOrange),
                  onPressed: () => {
                    Get.defaultDialog(
                        barrierDismissible: false,
                        radius: 6,
                        title: 'warning'.tr,
                        content: Text(
                          'deleteWarningMessage'.tr,
                          style: GoogleFonts.lato(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold),
                        ),
                        cancel: NeumorphicButton(
                          style: const NeumorphicStyle(
                              color: Colors.blue,
                              shadowLightColor: Colors.white,
                              shadowDarkColor: Colors.grey),
                          onPressed: () => {Get.back()},
                          child: SizedBox(
                            width: 50,
                            child: Center(
                              child: Text('cancel'.tr,
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        confirm: NeumorphicButton(
                          style: const NeumorphicStyle(
                              color: Colors.red,
                              shadowLightColor: Colors.white,
                              shadowDarkColor: Colors.grey),
                          onPressed: () {
                            controller.clearData();
                            Get.back();
                          },
                          child: SizedBox(
                            width: 50,
                            child: Center(
                              child: Text(
                                'ok'.tr,
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ))
                  },
                  child: Text(
                    'clearData'.tr,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey.shade400),
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NeumorphicIcon(
                  FontAwesomeIcons.infoCircle,
                  size: 22,
                  style: const NeumorphicStyle(
                    color: Colors.lightBlue,
                  ),
                ),
                Obx(() {
                  return NeumorphicText(
                    'ver'.trArgs([controller.version.value]),
                    style: const NeumorphicStyle(color: Colors.brown),
                  );
                }),
              ],
            ),
          ),
        )
      ],
    )
  ]));
}
