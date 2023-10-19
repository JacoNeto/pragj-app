import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pragj/controllers/home_controller.dart';
import 'package:pragj/pages/result/result_page.dart';
import 'package:pragj/utils/shared_widgets/my_button.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "PragJ",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() => _homeController.hasImageFile()
                      ? GestureDetector(
                          onLongPress: () {
                            _homeController.speak(
                                "Há uma imagem selecionada. Toque no botão mais embaixo para gerar a descrição.");
                          },
                          child: Stack(
                            children: [
                              SizedBox(
                                  height: 500,
                                  width: 500,
                                  child: kIsWeb
                                      ? Image.network(_homeController
                                          .imageXFile.value!.path)
                                      : Image.file(File(_homeController
                                          .imageFile.value!.path))),
                              CloseButton(
                                onPressed: () => _homeController.clearImage(),
                              )
                            ],
                          ),
                        )
                      : GestureDetector(
                          onLongPress: () {
                            _homeController.speak(
                                "Você ainda não selecionou uma imagem. Toque em um dos botões abaixo para selecionar uma foto.");
                          },
                          child: const Material(
                            child: SizedBox(
                              height: 400,
                              width: double.infinity,
                              child: Icon(Icons.image),
                            ),
                          ),
                        )),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onLongPress: () {
                          _homeController.speak(
                              "Use este botão para selecionar uma imagem pela galeria");
                        },
                        child: MyButton(
                          leading: const Icon(
                            Icons.photo,
                            color: Colors.black,
                          ),
                          label: "Galeria",
                          onPressed: () {
                            _homeController.pickImageFromGallery();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onLongPress: () {
                          _homeController.speak(
                              "Use este botão para selecionar uma imagem pela câmera");
                        },
                        child: MyButton(
                          leading:
                              const Icon(Icons.camera, color: Colors.black),
                          label: "Foto",
                          onPressed: () {
                            _homeController.pickImageFromCamera();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.all(8),
                    child: _homeController.hasImageFile()
                        ? GestureDetector(
                            onLongPress: () {
                              _homeController.speak(
                                  "Use este botão para gerar um texto longo");
                            },
                            child: MyButton(
                              leading: _homeController.isUploadLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Icon(Icons.generating_tokens),
                              label: "Gerar texto",
                              onPressed: () async {
                                await _homeController.uploadImage();
                                Get.to(ResultPage());
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
