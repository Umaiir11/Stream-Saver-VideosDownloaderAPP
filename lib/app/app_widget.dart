import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'configs/app_routes.dart';
import 'service/binding_service.dart';

class StreamSaver extends StatelessWidget {
  const StreamSaver({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      // minTextAdapt: true,
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(color: Colors.white),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
            useMaterial3: true,
          ),
          initialBinding: PermissionBinding(),
          initialRoute: Routes.dashboard,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
