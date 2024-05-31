import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz/shared/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo-icon.png",
            height: 100,
            width: 100,
          ),
          const SpinKitDoubleBounce(
            color: Color.fromARGB(255, 91, 109, 124),
            size: 30,
          )
        ],
      ),
    );
  }
}
