import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pragj/models/vision_description.dart';
import 'package:pragj/services/external/vision_connect.dart';
import 'package:pragj/services/firebase/storage.dart';
import '../services/firebase/storage.dart';
import 'package:pragj/utils/json_utils.dart';
import 'package:translator/translator.dart';

class HomeController extends GetxController {
  final ImagePicker picker = ImagePicker();
  final FlutterTts flutterTts = FlutterTts();
  final GoogleTranslator translator = GoogleTranslator();
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
    
    await getVisionDescriptionFromImage();
    text.value = await getLongDescription();

    isUploadLoading.value = false;
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
  /// [Vision Description]

  final VisionConnect _visionConnect = Get.put(VisionConnect());
  VisionDescription? visionDescription;

  Future<void> getVisionDescriptionFromImage() async {
    var response = await _visionConnect.describe(imageLink ?? "");
    visionDescription = VisionDescription.fromJson(getMap(response));
  }

  /// should be called after [getVisionDescriptionFromImage]
  String getShortDescription() {
    if (visionDescription != null) {
      if (visionDescription!.caption != null) {
        return visionDescription!.caption!.text ?? "";
      }
    }
    return "Algo deu errado";
  }

  /// should be called after [getVisionDescriptionFromImage]
  Future<String> getLongDescription() async {
    if (visionDescription != null) {
      if (visionDescription!.captionGPTS != null) {
        var result = await translator.translate(visionDescription!.captionGPTS!,
            from: 'en', to: 'pt');
        return result.text;
      }
    }
    return "Algo deu errado";
  }
}
}
