import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

import '../routes/app_pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: AppPages.routes,
    );
  }
}
