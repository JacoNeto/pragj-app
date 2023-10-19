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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text(
            "Resultado",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Text(homeController.longText.value,
                          textAlign: TextAlign.justify),
                    ])),
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
                          : homeController.speak(homeController.longText.value),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
