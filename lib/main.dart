import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';
import 'package:prastuti_23/utils/routes/routes.dart';
import 'package:prastuti_23/views/loading/events_view_loading.dart';
import 'package:flutter/services.dart';

import 'config/appTheme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black
    ));

    return MaterialApp(
      title: 'Prastuti',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       initialRoute: RouteNames.splashView,
       onGenerateRoute: Routes.generateRoute,
    );
  }
}
