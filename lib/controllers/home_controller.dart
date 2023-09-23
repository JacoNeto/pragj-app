import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../services/firebase/storage.dart';

class HomeController extends GetxController {
  final ImagePicker picker = ImagePicker();
  final FlutterTts flutterTts = FlutterTts();

  // ignore: unnecessary_cast
  Rx<XFile?> imageXFile = (null as XFile?).obs;
  // ignore: unnecessary_cast
  Rx<File?> imageFile = (null as File?).obs;

  // generated text
  Rx<String> text = "".obs;
  // audio reproducing ui
  var isReproducing = false.obs;

  @override
  void onInit() {
    flutterTts.awaitSpeakCompletion(false);
    flutterTts.setQueueMode(1);
    flutterTts.setLanguage("pt");
    flutterTts.setSpeechRate(0.7);
    flutterTts.setVoice({"name": "Karen", "locale": "pt-BR"});
    flutterTts.setCompletionHandler(() {
      isReproducing.value = false;
    });
    super.onInit();
  }

  bool hasImageFile() {
    return imageXFile.value != null;
  }

  Future<void> pickImageFromGallery() async {
    imageXFile.value = await picker.pickImage(source: ImageSource.gallery);
    imageFile.value = File(imageXFile.value!.path);
  }

  Future<void> pickImageFromCamera() async {
    imageXFile.value = await picker.pickImage(source: ImageSource.camera);
    imageFile.value = File(imageXFile.value!.path);
  }

  void clearImage() {
    imageXFile.value = null;
    imageFile.value = null;
  }

  void speak(String text) async {
    isReproducing.value = true;
    await flutterTts.speak(text);
  }

  void stop() async {
    isReproducing.value = false;
    await flutterTts.stop();
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  /// [Image upload]
  String? imageLink = "";
  var isUploadLoading = false.obs;

  Future<void> uploadImage() async {
    isUploadLoading.value = true;
    print("ALOOOOOOOOOOOOOOOO ${imageFile.value}");

    if (imageFile.value != null) {
      imageLink = await StorageClient()
          .uploadImageToFirebase(imageFile: imageFile.value!);
    }

    isUploadLoading.value = false;
  }
}
