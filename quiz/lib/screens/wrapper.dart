import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/providers/auth_provider.dart';
import 'package:quiz/screens/ui/navigation.dart';

import 'authenticate/welcome.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // return NavigationApp();
    return Provider.of<AuthProvider>(context).isLoggedIn == true
        ? const NavigationApp()
        : const WelcomeScreen();
  }
}
