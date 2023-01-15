import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:prastuti_23/config/env.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';
import 'package:prastuti_23/utils/routes/routes.dart';
import 'package:prastuti_23/views/loading/events_view_loading.dart';
import 'package:flutter/services.dart';
import 'package:prastuti_23/utils/utils.dart';
import 'config/appTheme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await selectedAppTheme.init();
  // await isLoggedIn.init();
  runApp(const ProviderScope(child: MyApp()));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

    

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black
    ));

    return MaterialApp(
      title: 'Prastuti',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: RouteNames.splashView,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

