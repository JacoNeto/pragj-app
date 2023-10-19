import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pragj/controllers/home_controller.dart';
import 'package:pragj/utils/shared_widgets/my_button.dart';

class ResultPage extends StatelessWidget {
  ResultPage({super.key});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        homeController.stop();
        return true;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Resultado"),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.density_large),
                    text: "Curta",
                  ),
                  Tab(
                    icon: Icon(Icons.density_small),
                    text: "Longa",
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(homeController.shortText.value),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(() => MyButton(
                            leading: homeController.isReproducing.value
                                ? const Icon(Icons.stop)
                                : const Icon(Icons.play_arrow),
                            label: homeController.isReproducing.value
                                ? "Parar"
                                : "Reproduzir",
                            onPressed: () => homeController.isReproducing.value
                                ? homeController.stop()
                                : homeController
                                    .speak(homeController.shortText.value),
                          ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(homeController.longText.value),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(() => MyButton(
                            leading: homeController.isReproducing.value
                                ? const Icon(Icons.stop)
                                : const Icon(Icons.play_arrow),
                            label: homeController.isReproducing.value
                                ? "Parar"
                                : "Reproduzir",
                            onPressed: () => homeController.isReproducing.value
                                ? homeController.stop()
                                : homeController
                                    .speak(homeController.longText.value),
                          ))
                    ],
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}
