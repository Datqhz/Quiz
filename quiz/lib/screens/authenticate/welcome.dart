import "package:flutter/material.dart";
import "package:quiz/screens/authenticate/sign_in.dart";
import "package:quiz/screens/authenticate/sign_up.dart";
import "package:quiz/shared/colors.dart";

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                height: MediaQuery.of(context).size.height / 3.5,
              ),
              const Text(
                "Cá nhân hóa trải nghiệm ghi nhớ của bạn ngay bây giờ.",
                style: TextStyle(
                  fontSize: 30,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
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
                  child: const Text("Đăng ký"),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                  child: const Text("Đăng nhập"),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
