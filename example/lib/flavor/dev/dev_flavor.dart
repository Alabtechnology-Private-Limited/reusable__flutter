
import 'package:flutter/material.dart';


  /**
   * 
   *  INFO : Try to import the FlavorConfig file.
   * 
   **/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig.init(
    baseUrl: "[[[ ADD YOU'R DEVELOPMENT URL  ]]]",
    projectType: .dev,
    version: "[[[ ADD YOU'R DEVELOPMENT VERSION  ]]]",
  );

    /**
     *  [here you can add dependency injection]
     **/
     
  runApp(const MyApp());
}
