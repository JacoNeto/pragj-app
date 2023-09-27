import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pragj/controllers/home_controller.dart';
import 'package:pragj/utils/shared_widgets/my_button.dart';

class ResultPage extends StatelessWidget {
  ResultPage({super.key});

  final HomeController homeController = Get.find();

  final text =
      "Os animes são uma forma de entretenimento japonesa que conquistou o mundo com sua rica narrativa e personagens cativantes. Com estilos que variam de ação frenética a dramas emocionantes, os animes atraem uma ampla gama de públicos. A arte vibrante e a trilha sonora envolvente são elementos que tornam cada série única. Alguns animes exploram temas profundos, enquanto outros oferecem comédia e escapismo. Com uma vasta lista de títulos para escolher, os fãs de anime podem encontrar algo que se encaixe perfeitamente em seus gostos pessoais, tornando essa forma de entretenimento verdadeiramente diversificada e envolvente.";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        homeController.stop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Resultado")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(homeController.text.value),
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
                          : homeController.speak(homeController.text.value),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
