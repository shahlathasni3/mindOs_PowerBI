import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:mindos_2/provider/mainProvider.dart';
import 'package:mindos_2/splashPage.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

// global object for accessing device screen size
late Size mq;

void main() {
  
  // integrate Gemini with API
  Gemini.init(apiKey: "AIzaSyCJoM-BbHlnwrf4V8fECEjFSC1cabHyErU");
  WidgetsFlutterBinding.ensureInitialized();
  // enter full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // for setting orientation to portrait only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).then((value){
    _initializeFirebase();
    runApp(const MyApp());
  });

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'mindOs',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: splashPage(),
      ),
    );
  }
}
_initializeFirebase() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
