import 'dart:convert';

import 'package:get/get.dart';

Map<String, dynamic> getMap(Response response) {
  final decodedObj = json.decode(response.bodyString.toString());
  return decodedObj;
}
