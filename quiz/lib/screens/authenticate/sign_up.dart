import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:quiz/screens/authenticate/success.dart";
import "package:quiz/services/account_service.dart";
import "package:quiz/shared/colors.dart";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier _isObscure = ValueNotifier(true);
  final ValueNotifier _passwordFocus = ValueNotifier(false);
  final ValueNotifier _emailFocus = ValueNotifier(false);

  bool validateEmail(String email) {
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (regex.hasMatch(email)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/logo-icon.png",
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Đăng ký",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: _emailFocus,
                          builder: (context, value, child) {
                            return TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(29, 161, 242, 1)),
                                ),
                                labelText: value ? 'Username' : null,
                                labelStyle: const TextStyle(fontSize: 16),
                                hintText: !value ? "Username" : null,
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  decoration: TextDecoration.none),
                              validator: (email) {
                                if (email!.isEmpty) {
                                  return "Vui lòng nhập tên hiển thị!";
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ValueListenableBuilder(
                          valueListenable: _emailFocus,
                          builder: (context, value, child) {
                            return TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(29, 161, 242, 1)),
                                ),
                                labelText: value ? 'Email' : null,
                                labelStyle: const TextStyle(fontSize: 16),
                                hintText: !value ? "Email" : null,
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  decoration: TextDecoration.none),
                              validator: (email) {
                                if (email!.isEmpty) {
                                  return "Vui lòng nhập email của bạn!";
                                }
                                if (!validateEmail(email)) {
                                  return "Email của bạn không hợp lệ!";
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ValueListenableBuilder(
                            valueListenable: _isObscure,
                            builder: (context, obscure, child) {
                              return ValueListenableBuilder(
                                valueListenable: _passwordFocus,
                                builder: (context, value, child) {
                                  return TextFormField(
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  29, 161, 242, 1)),
                                        ),
                                        labelText: value ? 'Password' : null,
                                        labelStyle:
                                            const TextStyle(fontSize: 16),
                                        hintText: !value ? "Password" : null,
                                        hintStyle: const TextStyle(
                                            color: Colors.white),
                                        border: InputBorder.none,
                                        errorBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            _isObscure.value = !obscure;
                                          },
                                          icon: obscure
                                              ? const Icon(
                                                  Icons.remove_red_eye_outlined)
                                              : const Icon(
                                                  Icons.remove_red_eye),
                                        ),
                                        suffixStyle: const TextStyle(
                                            color: Colors.white)),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        decoration: TextDecoration.none),
                                    obscureText: obscure,
                                    validator: (password) {
                                      if (password!.isEmpty) {
                                        return "Vui lòng nhập mật khẩu!";
                                      }
                                      if (password.length < 6) {
                                        return "Mật khẩu có ít nhất 6 kí tự!";
                                      }
                                      return null;
                                    },
                                  );
                                },
                              );
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(right: 20, bottom: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.white,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final username = _usernameController.text;
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          bool result = await AccountService()
                              .signUp(email, password, username, 1);
                          if (result) {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpSuccess()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                width:
                                    2.6 * MediaQuery.of(context).size.width / 4,
                                behavior: SnackBarBehavior.floating,
                                content: const Text(
                                  'Email đã được sử dụng',
                                  textAlign: TextAlign.center,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
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
                  ],
                ),
              ),
            ),
            Positioned(
              left: 15,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  CupertinoIcons.xmark,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
