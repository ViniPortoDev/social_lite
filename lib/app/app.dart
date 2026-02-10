import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../core/ui/theme/app_theme.dart';

import '../routes/app_pages.dart';
import 'bindings/app_binding.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      theme: AppTheme.light(),
    );
  }
}
