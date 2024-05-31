import 'package:flutter/material.dart';
import 'package:quiz/screens/authenticate/sign_in.dart';
import 'package:quiz/shared/colors.dart';

class SignUpSuccess extends StatelessWidget {
  const SignUpSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo-icon.png",
                height: 40,
                width: 40,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              const Text(
                "Đăng ký tài khoản thành công.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignIn(),
                        ));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.backgroundScreenColor,
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                  child: const Text("Đến trang đăng nhập"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
