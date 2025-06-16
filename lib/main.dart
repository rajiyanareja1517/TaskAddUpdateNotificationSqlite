import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'helper/NotificationService.dart';
import 'view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init(); // 🔔 Initialize
  runApp(GetMaterialApp(  // ✅ must be GetMaterialApp
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

