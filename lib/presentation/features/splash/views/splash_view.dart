import 'package:flutter/material.dart';
import 'package:template/core/routes/route_constants.dart';
import '../../../../../presentation/widgets/responsive_text.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  startTimer(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((value) => Navigator.pushReplacementNamed(context, Routes.kHome));
  }

  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return const Scaffold(
      body: Center(child: ResponsiveText('Splash Screen', fontSize: 20,)),
    );
  }
}
