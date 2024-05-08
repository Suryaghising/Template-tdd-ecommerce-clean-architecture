import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/core/routes/route_constants.dart';
import './utils/theme_config.dart';

import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/routes/app_router.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;
import './utils/custom_scroll_behaviour.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  usePathUrlStrategy();
  runApp(MyApp(router: sl<AppRouter>()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.router}) : super(key: key);

  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kThemeData,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.kRoot,
      onGenerateRoute: (settings) => router.generateRoute(settings),
      builder: (context, child) {
        return ScrollConfiguration(
            behavior: CustomScrollBehaviour(), child: child!);
      },
    );
  }
}
