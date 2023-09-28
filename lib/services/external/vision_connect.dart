import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class VisionConnect extends GetConnect {
  @override
  void onInit() async {
    Get.log('Base Connect Inicializado');

    //URL base
    httpClient.baseUrl = 'https://vision.astica.ai';

    httpClient.addResponseModifier((request, response) {
      if (Get.isLogEnable) {
        debugPrint(request.method);
        debugPrint('${request.url}');
      }
      debugPrint('${response.body}');
      return response;
    });

    // Json Content Type
    httpClient.defaultContentType = 'application/json; charset=utf-8';

    //Tempo de duração das requisições
    httpClient.timeout = const Duration(seconds: 15);

    //Em caso de falha, número de tentativas
    httpClient.maxAuthRetries = 2;
  }

  // Describe
  Future<Response> describe(String image) async {
    final response = await post(
      '/describe',
      <String, dynamic>{
        "tkn":
            "AA37390A-AEAC-424F-B5F9-50609B83A76A2B718330-09D9-4E24-A863-E8E8533D6BD2",
        "modelVersion": "2.1_full",
        "input": image,
        "visionParams": "gpt, describe, describe_all, tags, objects",
        "gpt_prompt": "",
        "gpt_length": "90" //FIXME: update address id
      },
    );
    return response;
  }
}
