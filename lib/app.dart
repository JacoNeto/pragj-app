import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/home/home_page.dart';

class PragJ extends StatelessWidget {
  const PragJ({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PragJ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.highContrastDark(),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
