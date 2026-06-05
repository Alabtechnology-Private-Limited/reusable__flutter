
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';


  /**
   * 
   *  INFO : Try to import the FlavorConfig file.
   * 
   **/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  FlavorConfig.init(
    baseUrl: "[[[ ADD YOU'R PRODUCTION URL  ]]]",
    projectType: .dev,
    packageInfo: packageInfo,
  );
    /**
     *  [here you can add dependency injection]
     **/
  runApp(const MyApp());
}

