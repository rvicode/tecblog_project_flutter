import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project111/gen/assets.gen.dart';
import 'package:project111/components/my_colors.dart';
import 'package:project111/view/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.all(100),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Assets.images.lo.image(),
            const SizedBox(height: 30),
            const SpinKitThreeBounce(
              color: SolidColors.primeryColor,
              size: 30.0,
            )
          ]),
        ),
      )),
    );
  }
}
